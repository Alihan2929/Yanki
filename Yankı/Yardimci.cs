using System;
using System.IO;
using System.Web.UI.WebControls;

namespace Yankı
{
    public static class Yardimci
    {
        private static readonly string[] IzinliUzantilar = { ".png", ".jpg", ".jpeg" };
        private const int MaksBoyutBayt = 5 * 1024 * 1024; // 5 MB

        /// <summary>
        /// Yüklenen resmi ~/Images klasörüne kaydeder ve "Images/..." yolunu döner.
        /// Uzantı veya boyut uygun değilse null döner.
        /// </summary>
        public static string ResimKaydet(FileUpload yukleme, System.Web.HttpServerUtility server)
        {
            if (yukleme == null || !yukleme.HasFile)
                return null;

            string uzanti = Path.GetExtension(yukleme.FileName).ToLowerInvariant();
            if (Array.IndexOf(IzinliUzantilar, uzanti) < 0)
                return null;

            if (yukleme.PostedFile.ContentLength > MaksBoyutBayt)
                return null;

            // Kullanıcının verdiği dosya adını kullanmıyoruz (path traversal ve çakışma riski)
            string benzersizIsim = Guid.NewGuid().ToString() + uzanti;
            string fizikselYol = server.MapPath("~/Images/" + benzersizIsim);
            yukleme.SaveAs(fizikselYol);

            return "Images/" + benzersizIsim;
        }
    }
}
