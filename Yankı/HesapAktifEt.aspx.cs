using System;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class HesapAktifEt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // URL'den gelen ?kod=... parametresindeki e-postayı alıyoruz
                string gelenEmail = Request.QueryString["kod"];

                if (!string.IsNullOrEmpty(gelenEmail))
                {
                    HesabiDogrula(gelenEmail);
                }
                else
                {
                    lblDurum.Text = "Geçersiz veya eksik doğrulama bağlantısı.";
                    lblDurum.CssClass = "hata";
                }
            }
        }

        private void HesabiDogrula(string email)
        {
            try
            {
                SqlBaglanti.BaglantiKontrol();

                // Yeni kolon olmadan, doğrudan Email üzerinden onaylama yapıyoruz
                string sorgu = @"UPDATE Users_db 
                                 SET IsVerified = 1 
                                 WHERE Email = @pemail AND IsVerified = 0";

                using (SqlCommand komut = new SqlCommand(sorgu, SqlBaglanti.baglan))
                {
                    komut.Parameters.AddWithValue("@pemail", email);

                    int etkilenenSatir = komut.ExecuteNonQuery();

                    if (etkilenenSatir > 0)
                    {
                        lblDurum.Text = "Tebrikler! Hesabınız başarıyla doğrulandı.";
                        lblDurum.CssClass = "basarili";
                        lnkGiris.Visible = true;
                    }
                    else
                    {
                        lblDurum.Text = "Bu hesap zaten aktif edilmiş veya bulunamadı.";
                        lblDurum.CssClass = "hata";
                        lnkGiris.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblDurum.Text = "İşlem sırasında bir hata oluştu: " + ex.Message;
                lblDurum.CssClass = "hata";
            }
            finally
            {
                SqlBaglanti.baglan.Close();
            }
        }
    }
}