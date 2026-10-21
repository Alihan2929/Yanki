<%@ Page Title="Arama Sonuçları" Language="C#" MasterPageFile="~/Layout1.Master" AutoEventWireup="true" CodeBehind="Arama.aspx.cs" Inherits="Yankı.Arama" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-results-container {
            max-width: 630px;
            margin: 24px auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .search-title {
            font-size: 18px;
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 4px;
        }

        .section-header {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-main);
            margin-top: 10px;
            margin-bottom: 10px;
            padding-bottom: 6px;
            border-bottom: 1px solid var(--border-color);
        }

        /* Kullanıcı Kartı */
        .search-item {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--shadow-subtle);
            transition: border-color 0.2s ease;
            margin-bottom: 12px;
        }

        .search-item:hover {
            border-color: #cfd9de;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
        }

        .user-details {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-weight: 700;
            font-size: 15px;
            color: var(--text-main);
            text-decoration: none;
        }

        .user-name:hover {
            text-decoration: underline;
        }

        .user-handle {
            font-size: 13px;
            color: var(--text-secondary);
        }

        .btn-view-profile {
            background-color: var(--text-main);
            color: white;
            text-decoration: none;
            padding: 8px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            transition: background-color 0.2s ease;
        }

        .btn-view-profile:hover {
            background-color: #272c30;
        }

        /* Yankı (Gönderi) Kartı */
        .feed-post {
            background-color: var(--card-bg);
            border-radius: 20px;
            padding: 20px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            display: flex;
            gap: 15px;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 12px;
            transition: border-color 0.2s ease;
        }

        .feed-post:hover {
            border-color: #cfd9de;
        }

        .post-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            object-fit: cover;
        }

        .post-content-area {
            flex: 1;
        }

        .post-header {
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 6px;
        }

        .post-name {
            font-weight: 700;
            color: var(--text-main);
            text-decoration: none;
            font-size: 14px;
        }

        .post-meta {
            color: var(--text-secondary);
            font-size: 13px;
        }

        .post-text {
            color: var(--text-main);
            font-size: 14px;
            line-height: 1.5;
            word-break: break-word;
            margin-bottom: 12px;
        }

        /* Arama Sonuçlarındaki Gönderi Görseli */
        .post-media-image {
            width: 100%;
            max-height: 350px;
            border-radius: 16px;
            object-fit: cover;
            margin-bottom: 14px;
            border: 1px solid var(--border-color);
        }

        .no-results {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 20px;
            text-align: center;
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="search-results-container">
        
        <div class="search-title">
            <asp:Label ID="lblAramaBaslik" runat="server" Text="Arama Sonuçları"></asp:Label>
        </div>

        <!-- 1. KULLANICI SONUÇLARI -->
        <div class="section-header">Kullanıcılar</div>
        <asp:DataList ID="dlKullaniciSonuclari" runat="server" RepeatLayout="Flow" Width="100%">
            <ItemTemplate>
                <div class="search-item">
                    <div class="user-info">
                        <img src='<%# Eval("ProfileImage") %>' class="user-avatar" alt="Profil" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de'" />
                        <div class="user-details">
                            <a href='<%# "Profile.aspx?username=" + Eval("Username") %>' class="user-name">
                                <%# Eval("Username") %>
                            </a>
                            <span class="user-handle">@<%# Eval("Username") %></span>
                        </div>
                    </div>
                    <a href='<%# "Profile.aspx?username=" + Eval("Username") %>' class="btn-view-profile">Profili Gör</a>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:Label ID="lblKullaniciYok" runat="server" CssClass="no-results" Text="Eşleşen kullanıcı bulunamadı." Visible="false"></asp:Label>


        <!-- 2. YANKI (GÖNDERİ) SONUÇLARI -->
        <div class="section-header" style="margin-top: 20px;">Yankılar</div>
        <asp:DataList ID="dlYankiSonuclari" runat="server" RepeatLayout="Flow" Width="100%">
            <ItemTemplate>
                <div class="feed-post">
                    <img src='<%# Eval("ProfileImage") %>' class="post-avatar" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />
                    <div class="post-content-area">
                        <div class="post-header">
                            <span class="post-name"><%# Eval("Username") %></span>
                            <span class="post-meta">@<%# Eval("Username") %> • 
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                            </span>
                        </div>
                        <div class="post-text">
                            <%# Eval("Content") %>
                        </div>

                        <!-- Arama Sonucu İçindeki Medya Görseli -->
                        <asp:Image ID="imgPostSearch" runat="server" ImageUrl='<%# Eval("MediaUrl") %>' CssClass="post-media-image" Visible='<%# !string.IsNullOrEmpty(Eval("MediaUrl") as string) %>' />
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:Label ID="lblYankiYok" runat="server" CssClass="no-results" Text="Eşleşen yankı bulunamadı." Visible="false"></asp:Label>

    </div>
</asp:Content>