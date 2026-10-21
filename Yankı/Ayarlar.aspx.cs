using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class Ayarlar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaveHesap_Click(object sender, EventArgs e)
        {
            SqlBaglanti.BaglantiKontrol();

            int id = Convert.ToInt32(Session["id"]);
            string image = "";
            if (fileProfileImage.HasFile)
            {
                string benzersizIsim = Guid.NewGuid().ToString() + "_" + fileProfileImage.FileName;

                image = "Images/" + benzersizIsim;

                string fizikselYol = Server.MapPath("~/Images/" + benzersizIsim);
                fileProfileImage.SaveAs(fizikselYol);
            }

            SqlCommand komut = new SqlCommand(
                "UPDATE Users_db SET ProfileImage=@pimage WHERE id=@pid",
                SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pimage", image);
            komut.Parameters.AddWithValue("@pid", id);

            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();

            Response.Redirect("Profile.aspx");
        }
        protected void btnSaveSifre_Click(object sender, EventArgs e)
        {
            SqlBaglanti.BaglantiKontrol();

            int id = Convert.ToInt32(Session["id"]);
            string sifre = txtPassword.Text;
            string hashsifre = Crypt.CryptSifre(sifre);
            SqlCommand komut = new SqlCommand("UPDATE Users_db set PasswordHash=@psifre where id = @pid", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@psifre", hashsifre);
            komut.Parameters.AddWithValue("@pid", id);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();
        }
        protected void TemaDegistir_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand("SELECT Theme FROM Users_db where id = @pid", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            int theme = Convert.ToInt32(komut.ExecuteScalar());
            if (theme == 1)
            {
                SqlCommand komut2 = new SqlCommand("UPDATE Users_db SET Theme = 0 where id = @pid", SqlBaglanti.baglan);
                komut2.Parameters.AddWithValue("@pid", id);
                komut2.ExecuteNonQuery();
                SqlBaglanti.baglan.Close();
            }
            else
            {

                SqlCommand komut3 = new SqlCommand("UPDATE Users_db SET Theme = 1 where id = @pid", SqlBaglanti.baglan);
                komut3.Parameters.AddWithValue("@pid", id);
                komut3.ExecuteNonQuery();
                SqlBaglanti.baglan.Close();
            }
            SqlBaglanti.baglan.Close();

            Response.Redirect("Ayarlar.aspx");

        }


    }
}