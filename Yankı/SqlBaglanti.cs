using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace Yankı
{
    public class SqlBaglanti
    {
        // Bağlantı bilgisi artık Web.config içindeki "YankiDB" kaydından okunuyor
        public static SqlConnection baglan = new SqlConnection(
            System.Configuration.ConfigurationManager.ConnectionStrings["YankiDB"].ConnectionString);

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