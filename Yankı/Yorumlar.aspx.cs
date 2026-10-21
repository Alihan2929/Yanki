using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class Yorumlar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PostuGetir();
                YorumlariGetir();
            }
        }
        void PostuGetir()
        {
            SqlBaglanti.BaglantiKontrol();
            int id = Convert.ToInt32(Request.QueryString["postId"]);
            SqlCommand komut = new SqlCommand("SELECT p.id as PostID,p.Content,p.MediaUrl,p.CreatedAt,u.Username,u.ProfileImage FROM Posts_db p JOIN Users_db u on p.UserID=u.id WHERE p.id = @pid",SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid",id);
            SqlDataReader dr = komut.ExecuteReader();
            DataList1.DataSource = dr;
            DataList1.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }
        void YorumlariGetir()
        {
            if (Request.QueryString["postId"] == null) return;

            SqlBaglanti.BaglantiKontrol();
            int id = Convert.ToInt32(Request.QueryString["postId"]);

            // c.Content hatası düzeltildi ve PostID filtresi eklendi
            SqlCommand komut = new SqlCommand("SELECT c.Content, c.CreatedAt, u.Username, u.ProfileImage FROM Comments_db c JOIN Users_db u ON c.UserID = u.id WHERE c.PostID = @pid ORDER BY c.CreatedAt DESC", SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);

            SqlDataReader dr = komut.ExecuteReader();
            DataList2.DataSource = dr;
            DataList2.DataBind();
            dr.Close();
            SqlBaglanti.baglan.Close();
        }
        protected void YorumGonder_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);
            int postid = Convert.ToInt32(Request.QueryString["postID"]);
            string content = txtYorum.Text;
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("INSERT INTO Comments_db(UserID,PostID,Content,CreatedAt,CommentType) VALUES(@pid,@ppostid,@pcontent,@pcreatedat,@pcommenttype) ",SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid",id);
            komut.Parameters.AddWithValue("@ppostid", postid);
            komut.Parameters.AddWithValue("@pcontent", content);
            komut.Parameters.AddWithValue("@pcreatedat",DateTime.Now);
            komut.Parameters.AddWithValue("@pcommenttype",1);
            komut.ExecuteNonQuery();
            SqlBaglanti.baglan.Close();
            YorumlariGetir();

        }
    }
}