<%@ Page Title="" Language="C#" MasterPageFile="~/Layout1.Master" AutoEventWireup="true" CodeBehind="Ayarlar.aspx.cs" Inherits="Yankı.Ayarlar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* --- AYARLAR SAYFASI MODERN YAPISI --- */
        .settings-wrapper * {
            box-sizing: border-box;
        }

        .settings-wrapper {
            padding: 20px 0;
            display: flex;
            justify-content: center;
            animation: fadeIn 0.4s ease;
        }

        .settings-container {
            display: flex;
            width: 100%;
            max-width: 860px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-subtle);
            min-height: 520px;
        }

        /* --- SOL MENÜ --- */
        .settings-menu {
            flex: 0 0 240px; 
            background-color: var(--bg-color);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
        }

        .settings-menu-header {
            padding: 24px 20px;
            font-size: 18px;
            font-weight: 800;
            color: var(--text-main);
            border-bottom: 1px solid var(--border-color);
            letter-spacing: -0.4px;
        }

        .menu-item {
            padding: 16px 20px;
            font-size: 14px;
            color: var(--text-secondary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.2s ease;
            border-left: 4px solid transparent;
            cursor: pointer;
            font-weight: 600;
        }

        .menu-item:hover {
            background-color: rgba(0, 0, 0, 0.03);
            color: var(--text-main);
        }

        .menu-item.active {
            background-color: var(--card-bg);
            color: var(--text-main);
            font-weight: 800;
            border-left: 4px solid var(--primary-color);
        }

        /* --- SAĞ İÇERİK ALANI --- */
        .settings-content {
            flex: 1; 
            padding: 32px;
            min-width: 0; 
            display: flex;
            flex-direction: column;
        }

        .content-header {
            font-size: 20px;
            font-weight: 800;
            margin-bottom: 24px;
            color: var(--text-main);
            letter-spacing: -0.4px;
        }

        /* Form Elemanları */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block; 
            font-size: 13px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%; 
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            font-size: 14px;
            color: var(--text-main);
            background-color: var(--bg-color);
            transition: all 0.2s ease;
            outline: none;
            font-family: inherit;
        }

        .form-control:focus {
            background-color: var(--card-bg);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(29, 155, 240, 0.15);
        }

        /* Dosya Yükleme (FileUpload) Tasarımı */
        .form-control-file {
            width: 100%;
            padding: 12px 15px;
            border: 2px dashed var(--border-color);
            border-radius: 12px;
            font-size: 13px;
            color: var(--text-secondary);
            background-color: var(--bg-color);
            cursor: pointer;
            transition: all 0.2s ease;
            font-family: inherit;
        }

        .form-control-file:hover {
            border-color: var(--primary-color);
            background-color: rgba(29, 155, 240, 0.04);
        }

        .form-control-file::file-selector-button {
            background-color: var(--border-color);
            color: var(--text-main);
            border: none;
            padding: 6px 14px;
            border-radius: 16px;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            margin-right: 12px;
            transition: background-color 0.2s;
        }

        .form-control-file::file-selector-button:hover {
            background-color: #cfd9de;
        }

        .form-hint {
            display: block;
            font-size: 12px;
            color: var(--text-secondary);
            margin-top: 6px;
        }

        /* Sekme (Tab) Alanları */
        .tab-pane {
            display: none;
            flex: 1;
            flex-direction: column;
        }

        .tab-pane.active-pane {
            display: flex;
            animation: fadeIn 0.3s ease;
        }

        /* Sekme İçi Kaydet Butonu Alanı */
        .tab-save-container {
            margin-top: auto; 
            text-align: right; 
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
        }

        .btn-save {
            background-color: var(--text-main);
            color: white;
            border: none;
            border-radius: 24px;
            padding: 11px 26px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(15, 20, 25, 0.15);
        }

        .btn-save:hover {
            background-color: #272c30;
            transform: translateY(-1px);
        }

        /* Koyu Mod İçin Ayarlar İçi Kart Düzeltmesi */
        body.dark-mode .settings-content [style*="background-color"] {
            background-color: #22303c !important;
            border-color: #38444d !important;
        }

        body.dark-mode .settings-content [style*="background-color"] * {
            color: var(--text-main) !important;
        }

        body.dark-mode .settings-content .btn-save {
            background-color: var(--primary-color) !important;
            color: #ffffff !important;
        }

        body.dark-mode .settings-content .btn-save:hover {
            background-color: var(--primary-hover) !important;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(6px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="settings-wrapper">
        <div class="settings-container">
            
            <!-- Sol Menü -->
            <div class="settings-menu">
                <div class="settings-menu-header">Ayarlar</div>
                <div class="menu-item active" onclick="switchTab('hesap', this)">👤 Hesap Bilgileri</div>
                <div class="menu-item" onclick="switchTab('sifre', this)">🔒 Şifre ve Güvenlik</div>
                <div class="menu-item" onclick="switchTab('gorunum', this)">🎨 Görünüm</div>
            </div>

            <!-- Sağ İçerik -->
            <div class="settings-content">
                
                <!-- 1. SEKME: HESAP BİLGİLERİ -->
                <div id="tab-hesap" class="tab-pane active-pane">
                    <div class="content-header">Hesap Bilgilerini Güncelle</div>

                    <div class="form-group">
                        <label>Kullanıcı Adı</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="@kullaniciadi"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>E-posta Adresi</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="ornek@mail.com"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Profil Fotoğrafı Yükle</label>
                        <asp:FileUpload ID="fileProfileImage" runat="server" CssClass="form-control-file" accept=".png,.jpg,.jpeg" />
                        <span class="form-hint">Cihazından bir fotoğraf seç. (Sadece .jpg ve .png desteklenir)</span>
                    </div>

                    <div class="tab-save-container">
                        <asp:Button ID="btnSaveHesap" runat="server" Text="Bilgileri Kaydet" CssClass="btn-save" OnClick="btnSaveHesap_Click" />
                    </div>
                </div>

                <!-- 2. SEKME: ŞİFRE VE GÜVENLİK -->
                <div id="tab-sifre" class="tab-pane">
                    <div class="content-header">Şifre ve Güvenlik</div>

                    <div class="form-group">
                        <label>Yeni Şifre Belirle</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Yeni şifreni gir"></asp:TextBox>
                        <span class="form-hint">Hesabının güvenliği için güçlü bir şifre kullan.</span>
                    </div>

                    <div class="tab-save-container">
                        <asp:Button ID="btnSaveSifre" runat="server" Text="Şifreyi Güncelle" CssClass="btn-save" OnClick="btnSaveSifre_Click" />
                    </div>
                </div>

                <!-- 3. SEKME: GÖRÜNÜM -->
                <div id="tab-gorunum" class="tab-pane">
                    <div class="content-header">Görünüm Ayarları</div>
                    
                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 20px; background-color: var(--bg-color); border: 1px solid var(--border-color); border-radius: 16px; margin-bottom: 20px;">
                        <div>
                            <div style="font-weight: 700; font-size: 15px; color: var(--text-main); margin-bottom: 4px;">Koyu Tema (Dark Mode)</div>
                            <div style="font-size: 13px; color: var(--text-secondary);">Göz yormayan antrasit gri tema modunu aç veya kapat.</div>
                        </div>
                        <asp:Button ID="btnSaveGorunum" runat="server" Text="Temayı Değiştir" CssClass="btn-save" OnClick="TemaDegistir_Click" style="margin-top: 0;" />
                    </div>
                </div>

            </div>

        </div>
    </div>

    <!-- Sekme Geçişleri İçin JavaScript -->
    <script type="text/javascript">
        function switchTab(tabId, element) {
            var panes = document.querySelectorAll('.tab-pane');
            panes.forEach(function (pane) {
                pane.classList.remove('active-pane');
            });

            document.getElementById('tab-' + tabId).classList.add('active-pane');

            var menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(function (item) {
                item.classList.remove('active');
            });

            element.classList.add('active');
        }
    </script>

</asp:Content>