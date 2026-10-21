using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Listele();
            }
            void Listele()
            {
                int id = Convert.ToInt32(Session["id"]);
                SqlBaglanti.BaglantiKontrol();
                SqlCommand komut = new SqlCommand("SELECT u.ProfileImage, u.Username, (SELECT COUNT(*) FROM Followers_db WHERE Following_ID = u.id AND Status = 1) AS TakipciSayisi, (SELECT COUNT(*) FROM Followers_db WHERE Follower_ID = u.id AND Status = 1) AS TakipEdilen FROM Users_db u WHERE u.id = @pid", SqlBaglanti.baglan);
                komut.Parameters.AddWithValue("@pid", id);
                SqlDataReader dr = komut.ExecuteReader();
                DataList2.DataSource = dr;
                DataList2.DataBind();
                dr.Close();
                SqlBaglanti.baglan.Close();
            }
        }
    }
}