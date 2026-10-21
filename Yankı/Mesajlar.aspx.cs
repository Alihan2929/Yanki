using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class Mesajlar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                KisileriGetir();
                MesajlarıGoster();
            }
        }
        void KisileriGetir()
        {
            int id = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("SELECT u.Username, u.ProfileImage,u.id as KarsıID FROM Followers_db f JOIN Users_db u ON u.id = f.Follower_ID WHERE f.Following_ID = @pid AND f.Status = 1", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid",id);
            SqlDataReader dr = komut.ExecuteReader();
            DataList2.DataSource = dr;
            DataList2.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }
        protected void MesajGonder_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);
            int secilenKullaniciID = Convert.ToInt32(Request.QueryString["to"]);
            string mesaj = txtMesajGonder.Text;
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("INSERT INTO Messages_db(SenderID,ReceiverID,Message,CreatedAt) VALUES(@psenderid,@preceiverid,@pmessage,@pcreatedat)",SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@psenderid",id);
            komut.Parameters.AddWithValue("@preceiverid", secilenKullaniciID);
            komut.Parameters.AddWithValue("@pmessage", mesaj);
            komut.Parameters.AddWithValue("@pcreatedat",DateTime.Now);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();
            MesajlarıGoster();
        }
        protected void SohbetSec_Click(object sender, EventArgs e)
        {
            int secilenKullaniciID = Convert.ToInt32(((LinkButton)sender).CommandArgument);
            Response.Redirect("Mesajlar.aspx?to=" + secilenKullaniciID);
        }
        void MesajlarıGoster()
        {
            SqlBaglanti.BaglantiKontrol();
            int id = Convert.ToInt32(Session["id"]);
            int id2 = Convert.ToInt32(Request.QueryString["to"]);
            SqlCommand komut = new SqlCommand("SELECT u.ProfileImage,u.Username,m.Message,m.ReceiverID,m.SenderID FROM Users_db u JOIN Messages_db m ON u.id = m.SenderID WHERE (u.id = @pid AND m.ReceiverID = @pid2) OR (u.id = @pid2 AND m.ReceiverID = @pid) ", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid",id);
            komut.Parameters.AddWithValue("@pid2", id2);
            SqlDataReader dr = komut.ExecuteReader();
            DataList3.DataSource = dr;
            DataList3.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }
    }
}