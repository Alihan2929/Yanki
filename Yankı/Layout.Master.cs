using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Yankı
{
    public partial class Layout : System.Web.UI.MasterPage
    {
        public string BodyClass = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);
            SqlBaglanti.BaglantiKontrol();
            SqlCommand komut = new SqlCommand("SELECT Theme FROM Users_db where id = @pid",SqlBaglanti.baglan);
            komut.Parameters.AddWithValue("@pid", id);
            int theme = Convert.ToInt32(komut.ExecuteScalar());
            if(theme == 1)
            {
                BodyClass = "dark-mode";
            }
            else
            {
                BodyClass = "";
            }

        }
    }
}