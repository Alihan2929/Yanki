using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace Yankı
{
    public class SqlBaglanti
    {
        public static SqlConnection baglan = new SqlConnection(
    @"Data Source=DESKTOP-B5V6MH4\SQLEXPRESS;
      Initial Catalog=Yankı_db;
      Integrated Security=True;
      TrustServerCertificate=True");

        public static void BaglantiKontrol()
        {
            if (baglan.State == System.Data.ConnectionState.Closed ) {
                baglan.Open();
            
            }
            else
            {


            }

        }
    }
}