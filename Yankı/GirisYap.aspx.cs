using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace Yankı
{
    public partial class GirisYap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlBaglanti.BaglantiKontrol();

            SqlCommand komut = new SqlCommand(
                "SELECT * FROM Users_db WHERE Email=@pemail",
                SqlBaglanti.baglan);

            komut.Parameters.AddWithValue("@pemail", eposta_txt.Text.Trim());

            SqlDataReader dr = komut.ExecuteReader();

            if (dr.Read())
            {
                string gercekHash = dr["PasswordHash"].ToString();

                bool dogruMu = BCrypt.Net.BCrypt.Verify(sifre_txt.Text, gercekHash);

                if (dogruMu)
                {
                    // Oturum açma işlemi
                    Session["id"] = dr["id"].ToString();
                    Session["Username"] = dr["Username"].ToString();

                    dr.Close();
                    SqlBaglanti.baglan.Close();

                    Response.Redirect("AnaSayfa.aspx");
                }
                else
                {
                    dr.Close();
                    SqlBaglanti.baglan.Close();

                    lblHata.Text = "E-posta adresi veya şifre hatalı.";
                    lblHata.Visible = true;
                }
            }
            else
            {
                dr.Close();
                SqlBaglanti.baglan.Close();

                lblHata.Text = "E-posta adresi veya şifre hatalı.";
                lblHata.Visible = true;
            }
        }
    }
}