using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class KayitOl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Kullanıcının girdiği verileri alıp boşlukları temizliyoruz
            string kullaniciAdi = kullaniciAdi_txt.Text.Trim();
            string Eposta = eposta_txt.Text.Trim();
            string sifre = sifre_txt.Text;
            string tekrarSifre = tekrarsifre_txt.Text;

            // 1. KONTROL: Boş alan bırakılmış mı?
            if (string.IsNullOrEmpty(kullaniciAdi) || string.IsNullOrEmpty(Eposta) || string.IsNullOrEmpty(sifre) || string.IsNullOrEmpty(tekrarSifre))
            {
                lblMesaj.Text = "Lütfen tüm alanları eksiksiz doldurun.";
                lblMesaj.CssClass = "alert-box alert-error";
                lblMesaj.Visible = true;
                return;
            }

            // 2. KONTROL: Şifreler uyuşuyor mu?
            if (!sifre.Equals(tekrarSifre))
            {
                lblMesaj.Text = "Şifreler eşleşmiyor. Lütfen kontrol edip tekrar deneyin.";
                lblMesaj.CssClass = "alert-box alert-error";
                lblMesaj.Visible = true;
                return;
            }

            // Veritabanı Kayıt İşlemi
            try
            {
                SqlBaglanti.BaglantiKontrol();
                string hashpassword = Crypt.CryptSifre(sifre);

                SqlCommand komut = new SqlCommand("INSERT INTO Users_db(Username,Email,PasswordHash,Bio,ProfileImage,CoverImage,IsPrivate,IsVerified,CreateAt,LastLogin,Theme) values(@pusername, @pemail,@ppasswordhash,@pbio,@pprofileimage,@pcoverimage,@pisprivate,@pisverified,@pcreateat,@plastlogin,@ptheme)", SqlBaglanti.baglan);

                komut.Parameters.AddWithValue("@pusername", kullaniciAdi);
                komut.Parameters.AddWithValue("@pemail", Eposta);
                komut.Parameters.AddWithValue("@ppasswordhash", hashpassword);
                komut.Parameters.AddWithValue("@pbio", "");
                komut.Parameters.AddWithValue("@pprofileimage", "https://ui-avatars.com/api/?name=" + kullaniciAdi + "&background=1d9bf0&color=fff");
                komut.Parameters.AddWithValue("@pcoverimage", "");
                komut.Parameters.AddWithValue("@pisprivate", true);
                komut.Parameters.AddWithValue("@pisverified", true); // Mail onayı kalktığı için doğrudan true yapıldı
                komut.Parameters.AddWithValue("@pcreateat", DateTime.Now);
                komut.Parameters.AddWithValue("@plastlogin", DateTime.Now);
                komut.Parameters.AddWithValue("@ptheme", 0);

                komut.ExecuteNonQuery();
                SqlBaglanti.baglan.Close();

                // Başarılı Bildirimi
                lblMesaj.Text = "Kaydınız başarıyla tamamlandı! Giriş yapabilirsiniz.";
                lblMesaj.CssClass = "alert-box alert-success";
                lblMesaj.Visible = true;

                // Form alanlarını temizle
                kullaniciAdi_txt.Text = "";
                eposta_txt.Text = "";
                sifre_txt.Text = "";
                tekrarsifre_txt.Text = "";
            }
            catch (Exception ex)
            {
                lblMesaj.Text = "Kayıt başarısız oldu. Hata Detayı: " + ex.Message;
                lblMesaj.CssClass = "alert-box alert-error";
                lblMesaj.Visible = true;
            }
        }
    }
}