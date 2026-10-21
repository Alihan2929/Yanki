using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Yankı
{
    public partial class AnaSayfa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("GirisYap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                KullanicilariGetir();
                YankılarıGetir();
            }
        }

        private void KullanicilariGetir()
        {
            int kullaniciID = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();


            SqlCommand komut = new SqlCommand("SELECT * FROM Users_db WHERE id != @pid AND id NOT IN(SELECT Following_ID FROM Followers_db WHERE Follower_ID = @pid)", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", kullaniciID);

            SqlDataReader dr = komut.ExecuteReader();
            DataList1.DataSource = dr;
            DataList1.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        protected void btnPaylas_Click(object sender, EventArgs e)
        {
            string media = "";
            int kullaniciID = Convert.ToInt32(Session["id"]);
            string gonderi = txtYeniGonderi.Text.Trim();

            // Eğer hem yazı boşsa hem de dosya seçilmediyse işlem yapma
            if (string.IsNullOrEmpty(gonderi) && !filePostMedia.HasFile)
                return;

            SqlBaglanti.BaglantiKontrol();

            if (filePostMedia.HasFile)
            {
                string benzersizIsim = Guid.NewGuid().ToString() + "_" + filePostMedia.FileName;
                media = "Images/" + benzersizIsim;
                string fizikselYol = Server.MapPath("~/Images/" + benzersizIsim);
                filePostMedia.SaveAs(fizikselYol);
            }

            // Eğer medya (MediaUrl) varsa PostType = 2, yoksa PostType = 1 yapılır
            int postType = !string.IsNullOrEmpty(media) ? 2 : 1;

            SqlCommand komut = new SqlCommand("INSERT INTO Posts_db (UserID, Content, MediaUrl, CreatedAt, UpdatedAt, PostType, Visibility, IsDeleted) VALUES (@pid, @pcontent, @pmedia, @pcreadetat, @pupdateat, @pposttype, @pvisibility, @pisdeleted)", SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pid", kullaniciID);
            komut.Parameters.AddWithValue("@pcontent", string.IsNullOrEmpty(gonderi) ? (object)DBNull.Value : gonderi);

            komut.Parameters.AddWithValue("@pmedia", string.IsNullOrEmpty(media) ? (object)DBNull.Value : media);

            komut.Parameters.AddWithValue("@pcreadetat", DateTime.Now);
            komut.Parameters.AddWithValue("@pupdateat", DateTime.Now);
            komut.Parameters.AddWithValue("@pposttype", postType); 
            komut.Parameters.AddWithValue("@pvisibility", true);
            komut.Parameters.AddWithValue("@pisdeleted", false);

            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            txtYeniGonderi.Text = "";

            YankılarıGetir();
        }

        private void YankılarıGetir()
        {
            SqlBaglanti.BaglantiKontrol();

            
            SqlCommand komut = new SqlCommand("SELECT p.id, u.Username, u.ProfileImage, p.Content,p.id as PostID, p.CreatedAt,p.MediaUrl,(SELECT COUNT(*) FROM Comments_db where PostID=p.id) as YorumSayisi,(SELECT COUNT(*) FROM Reposts_db where PostID = p.id) as RepostSayisi, (SELECT COUNT(*) FROM Likes_db WHERE PostsID = p.id) AS BegeniSayisi FROM Posts_db p JOIN Users_db u ON p.UserId = u.id WHERE p.Visibility = 1 ORDER BY p.CreatedAt DESC", SqlBaglanti.baglan);

            SqlDataReader dr = komut.ExecuteReader();
            DataList2.DataSource = dr;
            DataList2.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int kullaniciID = Convert.ToInt32(Session["id"]);
            int davetID = Convert.ToInt32(((Button)sender).CommandArgument);

            SqlBaglanti.BaglantiKontrol();

            // Kişi zaten takip ediliyor mu kontrol et (Çift kayıt önlemi)
            SqlCommand kontrolKomut = new SqlCommand("SELECT COUNT(*) FROM Followers_db WHERE Follower_ID = @follower AND Following_ID = @following", SqlBaglanti.baglan);
            kontrolKomut.Parameters.AddWithValue("@follower", kullaniciID);
            kontrolKomut.Parameters.AddWithValue("@following", davetID);

            int takipDurumu = Convert.ToInt32(kontrolKomut.ExecuteScalar());

            if (takipDurumu == 0)
            {
                // Followers_db kayıt ekle
                SqlCommand komut = new SqlCommand("INSERT INTO Followers_db(Follower_ID,Following_ID,Status,CreatedAt) VALUES(@follower,@following,@status,@date)", SqlBaglanti.baglan);
                komut.Parameters.AddWithValue("@follower", kullaniciID);
                komut.Parameters.AddWithValue("@following", davetID);
                komut.Parameters.AddWithValue("@status", 0);
                komut.Parameters.AddWithValue("@date", DateTime.Now);
                komut.ExecuteNonQuery();

                // Notifications_db bildirim ekle
                SqlCommand komut2 = new SqlCommand("INSERT INTO Notifications_db(SenderID,ReceiverID,Type,Message,IsRead,CreatedAt) VALUES(@sender,@receiver,@type,@message,@isread,@date)", SqlBaglanti.baglan);
                komut2.Parameters.AddWithValue("@sender", kullaniciID);
                komut2.Parameters.AddWithValue("@receiver", davetID);
                komut2.Parameters.AddWithValue("@type", 1);
                komut2.Parameters.AddWithValue("@message", "Seni takip etmek istiyor.");
                komut2.Parameters.AddWithValue("@isread", false);
                komut2.Parameters.AddWithValue("@date", DateTime.Now);
                komut2.ExecuteNonQuery();
            }

            SqlBaglanti.baglan.Close();

            Response.Redirect(Request.RawUrl);
        }

        protected void btnLike_Click(object sender, EventArgs e)
        {
            SqlBaglanti.BaglantiKontrol();
            int userid = Convert.ToInt32(Session["id"]);
            int postid = Convert.ToInt32(((LinkButton)sender).CommandArgument);

            SqlCommand kontrolKomut = new SqlCommand("SELECT COUNT(*) FROM Likes_db WHERE UserId = @puserid AND PostsID = @ppostid", SqlBaglanti.baglan);
            kontrolKomut.Parameters.AddWithValue("@puserid", userid);
            kontrolKomut.Parameters.AddWithValue("@ppostid", postid);

            int begeniDurumu = Convert.ToInt32(kontrolKomut.ExecuteScalar());

            if (begeniDurumu > 0)
            {
                SqlCommand silKomut = new SqlCommand("DELETE FROM Likes_db WHERE UserId = @puserid AND PostsID = @ppostid", SqlBaglanti.baglan);
                silKomut.Parameters.AddWithValue("@puserid", userid);
                silKomut.Parameters.AddWithValue("@ppostid", postid);
                silKomut.ExecuteNonQuery();
            }
            else
            {
                SqlCommand ekleKomut = new SqlCommand("INSERT INTO Likes_db(UserId, PostsID, CreatedAt) VALUES(@puserid, @ppostid, @pcreatedat)", SqlBaglanti.baglan);
                ekleKomut.Parameters.AddWithValue("@puserid", userid);
                ekleKomut.Parameters.AddWithValue("@ppostid", postid);
                ekleKomut.Parameters.AddWithValue("@pcreatedat", DateTime.Now);
                ekleKomut.ExecuteNonQuery();
            }

            SqlBaglanti.baglan.Close();


            YankılarıGetir();
        }
        protected void YorumYap_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            DataListItem item = (DataListItem)btn.NamingContainer;
            TextBox txtYorum = (TextBox)item.FindControl("txtYorumYap");

            if (txtYorum == null) return;

            string yorumText = txtYorum.Text.Trim();
            if (string.IsNullOrEmpty(yorumText)) return;

            int kullaniciID = Convert.ToInt32(Session["id"]);
            int postid = Convert.ToInt32(btn.CommandArgument);

            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("INSERT INTO Comments_db (UserID, PostID, Content, CreatedAt,CommentType) VALUES (@pid, @ppostid, @pcontent, @pcreatedat,@pcommanttype)", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", kullaniciID);
            komut.Parameters.AddWithValue("@ppostid", postid);
            komut.Parameters.AddWithValue("@pcontent", yorumText);
            komut.Parameters.AddWithValue("@pcreatedat", DateTime.Now);
            komut.Parameters.AddWithValue("@pcommanttype",1);

            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            YankılarıGetir();

        }
        protected void btnYorumGit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string postId = btn.CommandArgument;
            Response.Redirect("Yorumlar.aspx?postId=" + postId);
        }
        protected void btnRepost_Click(object sender, EventArgs e)
        {
            int userid = Convert.ToInt32(Session["id"]);
            int postid = Convert.ToInt32(((LinkButton)sender).CommandArgument);

            SqlBaglanti.BaglantiKontrol();

            SqlCommand kontrolKomut = new SqlCommand("SELECT COUNT(*) FROM Reposts_db WHERE UserID = @puserid AND PostID = @ppostid", SqlBaglanti.baglan);
            kontrolKomut.Parameters.AddWithValue("@puserid", userid);
            kontrolKomut.Parameters.AddWithValue("@ppostid", postid);

            int repostDurumu = Convert.ToInt32(kontrolKomut.ExecuteScalar());

            if (repostDurumu > 0)
            {
                SqlCommand silKomut = new SqlCommand("DELETE FROM Reposts_db WHERE UserID = @puserid AND PostID = @ppostid", SqlBaglanti.baglan);
                silKomut.Parameters.AddWithValue("@puserid", userid);
                silKomut.Parameters.AddWithValue("@ppostid", postid);
                silKomut.ExecuteNonQuery();
            }
            else
            {
                SqlCommand ekleKomut = new SqlCommand("INSERT INTO Reposts_db(UserID, PostID, CreatedAt) VALUES(@puserid, @ppostid, @pcreatedat)", SqlBaglanti.baglan);
                ekleKomut.Parameters.AddWithValue("@puserid", userid);
                ekleKomut.Parameters.AddWithValue("@ppostid", postid);
                ekleKomut.Parameters.AddWithValue("@pcreatedat", DateTime.Now);
                ekleKomut.ExecuteNonQuery();
            }

            SqlBaglanti.baglan.Close();
            YankılarıGetir(); 
        }

    }
}