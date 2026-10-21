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
            // Giriş yapmamış kullanıcı ayarlara erişemesin
            if (Session["id"] == null)
            {
                Response.Redirect("GirisYap.aspx");
                return;
            }
        }

        protected void btnSaveHesap_Click(object sender, EventArgs e)
        {
            // Dosya seçilmediyse profil resmini boşaltmak yerine hiçbir şey yapma
            if (!fileProfileImage.HasFile)
            {
                Response.Redirect("Profile.aspx");
                return;
            }

            string image = Yardimci.ResimKaydet(fileProfileImage, Server);
            if (image == null)
            {
                // Geçersiz uzantı veya 5 MB üstü dosya
                return;
            }

            SqlBaglanti.BaglantiKontrol();

            int id = Convert.ToInt32(Session["id"]);

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
            string sifre = txtPassword.Text;

            // Boş veya çok kısa şifreyi kabul etme
            if (string.IsNullOrWhiteSpace(sifre) || sifre.Length < 6)
                return;

            SqlBaglanti.BaglantiKontrol();

            int id = Convert.ToInt32(Session["id"]);
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