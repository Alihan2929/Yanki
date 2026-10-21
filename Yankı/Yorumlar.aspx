<%@ Page Title="Yankı Detayı" Language="C#" MasterPageFile="~/Layout1.Master" AutoEventWireup="true" CodeBehind="Yorumlar.aspx.cs" Inherits="Yankı.Yorumlar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .comment-detail-container {
            max-width: 630px;
            margin: 24px auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Ana Gönderi Kartı */
        .main-post-card {
            background-color: var(--card-bg);
            border-radius: 20px;
            padding: 20px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            display: flex;
            gap: 15px;
        }

        .post-avatar {
            width: 48px;
            height: 48px;
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
            font-size: 15px;
        }

        .post-meta {
            color: var(--text-secondary);
            font-size: 13px;
        }

        .post-text {
            color: var(--text-main);
            font-size: 15px;
            line-height: 1.5;
            margin-bottom: 14px;
            word-break: break-word;
        }

        .post-media-image {
            width: 100%;
            max-height: 380px;
            border-radius: 16px;
            object-fit: cover;
            margin-bottom: 14px;
            border: 1px solid var(--border-color);
        }

        /* Yorum Yapma Alanı */
        .comment-create-box {
            background-color: var(--card-bg);
            border-radius: 20px;
            padding: 16px 20px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .txt-comment-input {
            width: 100%;
            border: none;
            resize: none;
            font-size: 15px;
            font-family: inherit;
            outline: none;
            background: transparent;
            min-height: 50px;
            color: var(--text-main);
            box-sizing: border-box;
        }

        .comment-submit-row {
            display: flex;
            justify-content: flex-end;
            border-top: 1px solid var(--border-color);
            padding-top: 10px;
        }

        .btn-comment-reply {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 8px 20px;
            font-weight: 700;
            font-size: 13px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-comment-reply:hover {
            background-color: var(--primary-hover);
        }

        /* Yorumlar Listesi Başlığı */
        .section-title {
            font-size: 16px;
            font-weight: 800;
            color: var(--text-main);
            margin-top: 10px;
            margin-bottom: -5px;
        }

        /* Yorum Kartları */
        .comment-item {
            background-color: var(--card-bg);
            border-radius: 16px;
            padding: 16px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            display: flex;
            gap: 12px;
        }

        .hidden-lbl {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="comment-detail-container">

        <!-- 1. ANA GÖNDERİ (DataList1) -->
        <asp:DataList ID="DataList1" runat="server" RepeatLayout="Flow" Width="100%">
            <ItemTemplate>
                <div class="main-post-card">
                    <img src='<%# Eval("ProfileImage") %>' class="post-avatar" alt="Profil" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />

                    <div class="post-content-area">
                        <div class="post-header">
                            <span class="post-name"><%# Eval("Username") %></span>
                            <span class="post-meta">@<%# Eval("Username") %> • 
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                            </span>
                        </div>

                        <div class="post-text">
                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("Content") %>'></asp:Label>
                        </div>

                        <!-- Medya Görseli -->
                        <asp:Image ID="imgPostDetail" runat="server" ImageUrl='<%# Eval("MediaUrl") %>' CssClass="post-media-image" Visible='<%# !string.IsNullOrEmpty(Eval("MediaUrl") as string) %>' />
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>


        <!-- 2. YORUM YAPMA KUTUSU -->
        <div class="comment-create-box">
            <asp:TextBox ID="txtYorum" runat="server" CssClass="txt-comment-input" TextMode="MultiLine" Rows="2" placeholder="Yanıtını gönder..."></asp:TextBox>
            <div class="comment-submit-row">
                <!-- OnClick eklendi -->
                <asp:Button ID="btnYorumGonder" runat="server" Text="Yanıtla" CssClass="btn-comment-reply" OnClick="YorumGonder_Click" />
            </div>
        </div>


        <!-- 3. YAPILAN YORUMLAR LİSTESİ (DataList2) -->
        <div class="section-title">Yanıtlar</div>

        <asp:DataList ID="DataList2" runat="server" RepeatLayout="Flow" Width="100%">
            <ItemTemplate>
                <div class="comment-item" style="margin-bottom: 12px;">
                    <img src='<%# Eval("ProfileImage") %>' class="post-avatar" alt="Profil" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />

                    <div class="post-content-area">
                        <div class="post-header">
                            <span class="post-name"><%# Eval("Username") %></span>
                            <span class="post-meta">@<%# Eval("Username") %> • <%# Eval("CreatedAt") %></span>
                        </div>

                        <div class="post-text" style="margin-bottom: 0;">
                            <%# Eval("Content") %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>

    </div>

</asp:Content>