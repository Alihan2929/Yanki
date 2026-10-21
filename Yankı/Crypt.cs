using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BCrypt.Net;

namespace Yankı
{
    public class Crypt
    {
        public static String CryptSifre(string sifre)
        {
            string hash=BCrypt.Net.BCrypt.HashPassword(sifre);
            return hash;
        }

    }
}