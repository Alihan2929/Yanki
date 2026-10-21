using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Yankı
{
    public partial class Arama : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sorgu = Request.QueryString["q"];
                if (!string.IsNullOrEmpty(sorgu))
                {
                    lblAramaBaslik.Text = "\"" + Server.HtmlEncode(sorgu) + "\" için arama sonuçları:";
                    AramaYap(sorgu);
                }
                else
                {
                    lblAramaBaslik.Text = "Lütfen aramak için bir kelime girin.";
                    lblKullaniciYok.Visible = true;
                    lblYankiYok.Visible = true;
                }
            }
        }

        private void AramaYap(string kelime)
        {
            try
            {
                SqlBaglanti.BaglantiKontrol();

                // 1. KULLANICI ARAMASI
                SqlCommand komutUser = new SqlCommand("SELECT id, Username, ProfileImage FROM Users_db WHERE Username LIKE @pKelime", SqlBaglanti.baglan);
                komutUser.Parameters.AddWithValue("@pKelime", "%" + kelime + "%");
                SqlDataAdapter daUser = new SqlDataAdapter(komutUser);
                DataTable dtUser = new DataTable();
                daUser.Fill(dtUser);

                if (dtUser.Rows.Count > 0)
                {
                    dlKullaniciSonuclari.DataSource = dtUser;
                    dlKullaniciSonuclari.DataBind();
                    lblKullaniciYok.Visible = false;
                }
                else
                {
                    dlKullaniciSonuclari.DataSource = null;
                    dlKullaniciSonuclari.DataBind();
                    lblKullaniciYok.Visible = true;
                }

                // 2. YANKI (GÖNDERİ) ARAMASI 
                // Tablo isimlerin varsayılan olarak Posts_db ve Users_db üzerinden INNER JOIN ile bağlanır
                SqlCommand komutPost = new SqlCommand("SELECT p.id,p.MediaUrl, p.Content, p.CreatedAt, u.Username, u.ProfileImage FROM Posts_db p INNER JOIN Users_db u ON p.UserID = u.id WHERE p.Content LIKE @pKelime ORDER BY p.CreatedAt DESC", SqlBaglanti.baglan);
                komutPost.Parameters.AddWithValue("@pKelime", "%" + kelime + "%");
                SqlDataAdapter daPost = new SqlDataAdapter(komutPost);
                DataTable dtPost = new DataTable();
                daPost.Fill(dtPost);

                if (dtPost.Rows.Count > 0)
                {
                    dlYankiSonuclari.DataSource = dtPost;
                    dlYankiSonuclari.DataBind();
                    lblYankiYok.Visible = false;
                }
                else
                {
                    dlYankiSonuclari.DataSource = null;
                    dlYankiSonuclari.DataBind();
                    lblYankiYok.Visible = true;
                }

                SqlBaglanti.baglan.Close();
            }
            catch (Exception)
            {
                lblKullaniciYok.Text = "Arama yapılırken bir hata oluştu.";
                lblKullaniciYok.Visible = true;
                lblYankiYok.Visible = true;
            }
        }
    }
}