using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;

namespace Yankı
{
    public partial class Layout1 : System.Web.UI.MasterPage
    {
        public string BodyClass = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Session["id"]);
                SqlBaglanti.BaglantiKontrol();
                SqlCommand komut = new SqlCommand("SELECT Theme FROM Users_db where id = @pid", SqlBaglanti.baglan);
                komut.Parameters.AddWithValue("@pid", id);
                int theme = Convert.ToInt32(komut.ExecuteScalar());
                if (theme == 1)
                {
                    BodyClass = "dark-mode";
                }
                else
                {
                    BodyClass = "";
                }
                Listele();
                BildirimSayisi();
            }
        }

        void Listele()
        {
            if (Session["id"] == null)
                return;

            int kullaniciID = Convert.ToInt32(Session["id"]);

            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT n.id, f.id AS FollowID, n.SenderID, n.ReceiverID, u.Username, u.ProfileImage, n.Message, n.CreatedAt, n.Type FROM Notifications_db n INNER JOIN Users_db u ON n.SenderID = u.id INNER JOIN Followers_db f ON f.Follower_ID = n.SenderID AND f.Following_ID = n.ReceiverID WHERE n.ReceiverID = @id and Status = 0 ORDER BY n.CreatedAt DESC", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@id", kullaniciID);

            SqlDataReader dr = komut.ExecuteReader();

            DataList1.DataSource = dr;
            DataList1.DataBind();

            dr.Close();
            SqlBaglanti.baglan.Close();
        }

        // Arama Çubuğu Enter Tetikleyicisi
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string aranan = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(aranan))
            {
                Response.Redirect("Arama.aspx?q=" + Server.UrlEncode(aranan));
            }
        }

        protected void btnBildirimClick(object sender, EventArgs e)
        {
            int bildirimID = Convert.ToInt32(((Button)sender).CommandArgument);
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("UPDATE Notifications_db set IsRead = 1 where id = @pid", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", bildirimID);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();
            Listele();
            BildirimSayisi();
        }

        protected void IstekKabulClick(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(((Button)sender).CommandArgument);
            int kullaniciID = Convert.ToInt32(Session["id"]);

            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("UPDATE Followers_db SET Status = 1 WHERE id = @pid; UPDATE Notifications_db SET IsRead = 1 WHERE ReceiverID = @kullaniciID AND SenderID = (SELECT Follower_ID FROM Followers_db WHERE id = @pid)", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            komut.Parameters.AddWithValue("@kullaniciID", kullaniciID);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            Listele();
            BildirimSayisi();
        }

        protected void IstekReddetClick(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(((Button)sender).CommandArgument);
            int kullaniciID = Convert.ToInt32(Session["id"]);

            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("UPDATE Followers_db set Status = 2 where id = @pid; UPDATE Notifications_db SET IsRead = 1 WHERE ReceiverID = @kullaniciID AND SenderID = (SELECT Follower_ID FROM Followers_db WHERE id = @pid)", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            komut.Parameters.AddWithValue("@kullaniciID", kullaniciID);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            Listele();
            BildirimSayisi();
        }

        void BildirimSayisi()
        {
            if (Session["id"] == null)
                return;

            int id = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("SELECT Count(*) as Sayi FROM Notifications_db where ReceiverID = @pid and IsRead = 0 HAVING Count(*) > 0", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            SqlDataReader dr = komut.ExecuteReader();
            DataListSayac.DataSource = dr;
            DataListSayac.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }
    }
}