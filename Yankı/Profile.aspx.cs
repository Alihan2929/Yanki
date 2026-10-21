using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class Profile : System.Web.UI.Page
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
                // Profil kartı her halükarda yüklenecek
                Listele();

                Takipcilerim_Click(null,null);
                TakipEdilenler_Click(null, null);


                // URL'den hangi sekmede olduğumuzu okuyoruz
                string tab = Request.QueryString["tab"];

                // Tüm listeleri başta gizleyelim
                DataList1.Visible = false;
                DataList3.Visible = false;
                DataList4.Visible = false;

                if (tab == "begeni")
                {
                    DataList3.Visible = true;  // Beğenilenleri göster
                    Begeniler();               // Beğeni metodunu çalıştır
                }
                else if (tab == "retweetler")
                {
                    DataList4.Visible = true;  // Retweetleri göster
                    Retweet();                 // Retweet metodunu çalıştır
                }
                else
                {
                    // Varsayılan olarak (veya "gonderiler" sekmesinde) kendi gönderileri çıkar
                    DataList1.Visible = true;  // Kendi gönderilerini göster
                    Yorumlar();                // Kendi gönderilerini çeken metodu çalıştır
                }
            }
        }

        void Listele()
        {
            int kullaniciID = Convert.ToInt32(Session["id"]);

            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT u.Bio,u.ProfileImage, u.Username, (SELECT COUNT(*) FROM Followers_db WHERE Following_ID = u.id AND Status = 1) AS TakipciSayisi, (SELECT COUNT(*) FROM Followers_db WHERE Follower_ID = u.id AND Status = 1) AS TakipEdilenSayisi FROM Users_db u WHERE u.id = @pid", SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pid", kullaniciID);

            SqlDataReader dr = komut.ExecuteReader();

            DataList2.DataSource = dr;
            DataList2.DataBind();

            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        void Yorumlar()
        {
            int kullaniciID = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT p.id,p.MediaUrl ,p.CreatedAt, p.Content, s.Username, s.ProfileImage FROM Posts_db p join Users_db s on s.id = p.UserID where s.id = @pid ORDER BY CreatedAt desc", SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pid", kullaniciID);
            SqlDataReader dr = komut.ExecuteReader();

            DataList1.DataSource = dr;
            DataList1.DataBind();

            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        void Begeniler()
        {
            int id = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT u.Username, u.ProfileImage,p.MediaUrl, p.CreatedAt, p.Content FROM Likes_db l INNER JOIN Posts_db p ON l.PostsID = p.id INNER JOIN Users_db u ON p.UserID = u.id WHERE l.UserID = @pid", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);

            SqlDataReader dr =komut.ExecuteReader();

            DataList3.DataSource = dr;
            DataList3.DataBind();

            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            SqlBaglanti.BaglantiKontrol();
            int id = Convert.ToInt32(((Button)sender).CommandArgument);
            int kullaniciID = Convert.ToInt32(Session["id"]);

            // Sadece kendi gönderisini silebilsin; bağlı yorum, beğeni ve repost kayıtlarını da temizle
            string sahiplik = "(SELECT id FROM Posts_db WHERE id = @pid AND UserID = @puser)";

            SqlCommand komut2 = new SqlCommand("DELETE FROM Comments_db WHERE PostID IN " + sahiplik, SqlBaglanti.baglan);
            komut2.Parameters.AddWithValue("@pid", id);
            komut2.Parameters.AddWithValue("@puser", kullaniciID);
            komut2.ExecuteNonQuery();

            SqlCommand komut3 = new SqlCommand("DELETE FROM Likes_db WHERE PostsID IN " + sahiplik, SqlBaglanti.baglan);
            komut3.Parameters.AddWithValue("@pid", id);
            komut3.Parameters.AddWithValue("@puser", kullaniciID);
            komut3.ExecuteNonQuery();

            SqlCommand komut4 = new SqlCommand("DELETE FROM Reposts_db WHERE PostID IN " + sahiplik, SqlBaglanti.baglan);
            komut4.Parameters.AddWithValue("@pid", id);
            komut4.Parameters.AddWithValue("@puser", kullaniciID);
            komut4.ExecuteNonQuery();

            SqlCommand komut = new SqlCommand("DELETE FROM Posts_db WHERE id = @pid AND UserID = @puser", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            komut.Parameters.AddWithValue("@puser", kullaniciID);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            Listele();
            Yorumlar();
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            SqlBaglanti.BaglantiKontrol();

            Button btn = (Button)sender;
            int id = Convert.ToInt32(btn.CommandArgument);

            DataListItem item = (DataListItem)btn.NamingContainer;

            TextBox txtEditContent = (TextBox)item.FindControl("txtEditContent");

            string content = txtEditContent.Text;

            SqlCommand komut = new SqlCommand(
                "UPDATE Posts_db SET Content=@content WHERE id=@pid AND UserID=@puser",
                SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@content", content);
            komut.Parameters.AddWithValue("@pid", id);
            komut.Parameters.AddWithValue("@puser", Convert.ToInt32(Session["id"]));

            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            Listele();
            Yorumlar();
        }
        void Retweet()
        {
            int id = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("SELECT p.CreatedAt,p.Content,p.MediaUrl,u.Username,u.ProfileImage FROM Posts_db p JOIN Reposts_db r ON p.id = r.PostID JOIN Users_db u ON u.id = p.UserID WHERE r.UserID = @pid", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            SqlDataReader dr = komut.ExecuteReader();
            DataList4.DataSource = dr;
            DataList4.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();

        }
        protected void Takipcilerim_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);

            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT u.Username, u.ProfileImage FROM Followers_db f JOIN Users_db u ON u.id = f.Follower_ID WHERE f.Following_ID = @pid AND f.Status = 1", SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pid", id);

            SqlDataReader dr = komut.ExecuteReader();

            DataListTakipciler.DataSource = dr;
            DataListTakipciler.DataBind();

            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        protected void TakipEdilenler_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);

            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT u.Username, u.ProfileImage FROM Followers_db f JOIN Users_db u ON u.id = f.Following_ID WHERE f.Follower_ID = @pid AND f.Status = 1", SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pid", id);

            SqlDataReader dr = komut.ExecuteReader();

            DataListTakipEdilen.DataSource = dr;
            DataListTakipEdilen.DataBind();

            dr.Close();
            SqlBaglanti.baglan.Close();
        }


    }
}