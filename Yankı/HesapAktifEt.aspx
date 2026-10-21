<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HesapAktifEt.aspx.cs" Inherits="Yankı.HesapAktifEt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Yankı - Hesap Doğrulama</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 420px;
            width: 100%;
        }
        .basarili {
            color: #16a34a;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .hata {
            color: #dc2626;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .btn-giris {
            display: inline-block;
            background-color: #1d9bf0;
            color: #ffffff;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: 0.2s;
        }
        .btn-giris:hover {
            background-color: #1a8cd8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <h2>Yankı Hesap Onayı</h2>
            
            <!-- Durum Mesajı -->
            <asp:Label ID="lblDurum" runat="server"></asp:Label>
            
            <div style="margin-top: 25px;">
                <asp:HyperLink ID="lnkGiris" runat="server" NavigateUrl="GirisYap.aspx" CssClass="btn-giris" Visible="false">
                    Giriş Sayfasına Git
                </asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>