<%@ Page Title="Giriş Yap" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="GirisYap.aspx.cs" Inherits="Yankı.GirisYap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Giriş Formu Modern Konteyneri */
        .auth-container {
            max-width: 400px;
            margin: 20px auto;
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Başlık Alanı */
        .auth-header {
            text-align: center;
            margin-bottom: 28px;
        }

        .auth-header h2 {
            font-size: 26px;
            color: var(--text-main);
            margin-bottom: 6px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .auth-header p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Modern Hata Mesajı Tasarımı */
        .alert-error {
            background-color: #fce8e6;
            color: #f4212e;
            border: 1px solid rgba(244, 33, 46, 0.2);
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
            display: block;
        }

        /* Form Grupları */
        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            font-size: 13px;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        /* Modern TextBox Tasarımları */
        .form-control {
            width: 100%;
            padding: 12px 16px;
            font-size: 14px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            outline: none;
            transition: all 0.2s ease;
            box-sizing: border-box;
            background-color: #f7f9f9;
            color: var(--text-main);
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(29, 155, 240, 0.15);
        }

        /* Modern Giriş Yap Butonu */
        .btn-submit {
            width: 100%;
            background-color: var(--text-main); 
            color: #ffffff;
            font-weight: 700;
            font-size: 15px;
            padding: 13px;
            border: none;
            border-radius: 24px;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 8px;
            box-shadow: 0 4px 12px rgba(15, 20, 25, 0.15);
        }

        .btn-submit:hover {
            background-color: #272c30;
            transform: translateY(-1px);
        }

        /* Alt Bilgi (Kayıt Ol Yönlendirmesi) */
        .auth-footer {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .auth-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 700;
            transition: text-decoration 0.2s;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="auth-container">
        
        <div class="auth-header">
            <h2>Giriş Yap</h2>
            <p>Yankı'ya geri dön ve neler olup bittiğini gör.</p>
        </div>

        <!-- Hata Mesajı Kutusu -->
        <asp:Label ID="lblHata" runat="server" CssClass="alert-error" Visible="false"></asp:Label>

        <div class="form-group">
            <label>E-Posta</label>
            <asp:TextBox ID="eposta_txt" runat="server" CssClass="form-control" TextMode="Email" placeholder="ornek@posta.com" required="required"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Şifre</label>
            <asp:TextBox ID="sifre_txt" runat="server" CssClass="form-control" TextMode="Password" placeholder="Şifrenizi girin" required="required"></asp:TextBox>
        </div>

        <asp:Button ID="Button1" runat="server" Text="Giriş Yap" CssClass="btn-submit" OnClick="Button1_Click" />

        <div class="auth-footer">
            Henüz bir hesabın yok mu? <a href="KayitOl.aspx">Kayıt Ol</a>
        </div>

    </div>

</asp:Content>