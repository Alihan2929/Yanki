<%@ Page Title="" Language="C#" MasterPageFile="~/Layout1.Master" AutoEventWireup="true" CodeBehind="AnaSayfa.aspx.cs" Inherits="Yankı.AnaSayfa" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* --- GENEL YAPI --- */
        .feed-container {
            max-width: 630px;
            margin: 24px auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* --- 1. YENİ GÖNDERİ OLUŞTURMA ALANI --- */
        .create-post-box {
            background-color: var(--card-bg);
            border-radius: 20px;
            padding: 20px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            display: flex;
            gap: 15px;
            animation: fadeIn 0.4s ease;
        }

        .post-input-area {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .txt-tweet {
            width: 100%;
            border: none;
            resize: none;
            font-size: 16px;
            font-family: inherit;
            outline: none;
            background: transparent;
            min-height: 60px;
            color: var(--text-main);
        }

        .txt-tweet::placeholder {
            color: var(--text-secondary);
        }

        /* Medya Önizleme Alanı */
        .media-preview-container {
            position: relative;
            margin-top: 10px;
            display: none; 
            max-height: 280px;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .media-preview-container img {
            width: 100%;
            max-height: 280px;
            object-fit: cover;
            display: block;
        }

        .btn-remove-media {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            border: none;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.2s;
        }

        .btn-remove-media:hover {
            background-color: rgba(244, 33, 46, 0.9);
        }

        /* Medya Yükleme ve Buton Satırı */
        .post-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid var(--border-color);
            padding-top: 12px;
            margin-top: 5px;
        }

        .media-upload-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            cursor: pointer;
        }

        .media-upload-btn {
            background-color: transparent;
            color: var(--primary-color);
            border: 1px solid var(--border-color);
            padding: 6px 14px;
            border-radius: 16px;
            font-size: 13px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .media-upload-btn:hover {
            background-color: rgba(29, 155, 240, 0.08);
            border-color: var(--primary-color);
        }

        .hidden-file-input {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
            width: 100%;
            height: 100%;
        }

        .btn-tweet {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 8px 22px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(29, 155, 240, 0.25);
        }

        .btn-tweet:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        /* --- 2. TANIYOR OLABİLECEKLERİN --- */
        .suggestions-box {
            background-color: var(--card-bg);
            border-radius: 20px;
            padding: 18px 20px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            animation: fadeIn 0.4s ease;
        }

        .suggestions-header {
            font-size: 16px;
            font-weight: 800;
            margin-bottom: 14px;
            color: var(--text-main);
            letter-spacing: -0.4px;
        }

        .user-list {
            display: flex;
            flex-wrap: nowrap;
            gap: 14px;
            padding: 4px 2px 8px 2px;
            overflow-x: auto;
            scrollbar-width: thin;
        }

        .user-list::-webkit-scrollbar {
            height: 5px;
        }

        .user-list::-webkit-scrollbar-thumb {
            background-color: var(--border-color);
            border-radius: 10px;
        }

        .user-card {
            background-color: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 16px 12px;
            min-width: 150px;
            max-width: 150px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            flex-shrink: 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
            cursor: pointer;
        }

        .user-card:hover {
            transform: translateY(-4px);
            border-color: rgba(29, 155, 240, 0.4);
            box-shadow: 0 8px 20px rgba(29, 155, 240, 0.08);
        }

        .avatar-container {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            overflow: hidden;
            margin-bottom: 10px;
            background-color: var(--bg-color);
            border: 2px solid var(--border-color);
            transition: opacity 0.2s ease;
        }

        .avatar-container:hover {
            opacity: 0.9;
        }

        .avatar-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .username-lbl {
            font-weight: 700;
            font-size: 13px;
            color: var(--text-main);
            margin-bottom: 2px;
            display: block;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 100%;
            cursor: pointer;
        }

        .username-lbl:hover {
            text-decoration: underline;
            color: var(--primary-color);
        }

        .user-handle {
            font-size: 11px;
            color: var(--text-secondary);
            margin-bottom: 12px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 100%;
            display: block;
        }

        .hidden-lbl {
            display: none;
        }

        .btn-action {
            background-color: var(--text-main);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 6px 14px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            width: 100%;
            margin-top: auto;
            transition: all 0.2s ease;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .btn-action:hover {
            background-color: var(--primary-color);
            transform: translateY(-1px);
        }

        /* --- 3. AKIŞ ALANI --- */
        .feed-list-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

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
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .feed-post:hover {
            border-color: #cfd9de;
            background-color: rgba(0, 0, 0, 0.01);
        }

        .user-avatar-small {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background-color: var(--border-color);
            object-fit: cover;
            cursor: pointer;
            transition: opacity 0.2s ease;
            flex-shrink: 0;
        }

        .user-avatar-small:hover {
            opacity: 0.85;
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

        .post-name-wrapper {
            cursor: pointer;
            display: inline-flex;
            align-items: center;
        }

        .post-name {
            font-weight: 700;
            color: var(--text-main);
            font-size: 14px;
            cursor: pointer;
        }

        .post-name:hover {
            text-decoration: underline;
            color: var(--primary-color);
        }

        .post-meta {
            color: var(--text-secondary);
            font-size: 13px;
        }

        .post-text {
            color: var(--text-main);
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .post-text span {
            display: block;
            word-break: break-word;
        }

        /* Akıştaki Gönderi Görseli */
        .post-media-image {
            width: 100%;
            max-height: 350px;
            border-radius: 16px;
            object-fit: cover;
            margin-bottom: 14px;
            border: 1px solid var(--border-color);
            cursor: zoom-in;
            transition: opacity 0.2s;
        }

        .post-media-image:hover {
            opacity: 0.95;
        }

        /* Etkileşim Alanı */
        .post-interaction {
            display: flex;
            justify-content: space-between;
            max-width: 280px;
            color: var(--text-secondary);
        }

        .interaction-tab-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            color: var(--text-secondary); 
            background: none;
            border: none;
            padding: 4px 8px;
            border-radius: 12px;
            font-family: inherit;
        }

        .interaction-tab-btn:hover {
            color: var(--primary-color); 
            background-color: rgba(29, 155, 240, 0.08);
        }

        .interaction-tab-btn.retweet:hover {
            color: #00ba7c; 
            background-color: rgba(0, 186, 124, 0.08);
        }

        .interaction-tab-btn.like:hover {
            color: #f4212e; 
            background-color: rgba(244, 33, 46, 0.08);
        }

        /* --- YORUM YAPMA AÇILIR ALANI --- */
        .comment-box-container {
            display: none; 
            margin-top: 14px;
            padding-top: 14px;
            border-top: 1px solid var(--border-color);
            animation: fadeIn 0.3s ease;
        }

        .txt-comment {
            width: 100%;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 10px 14px;
            resize: none;
            font-size: 14px;
            font-family: inherit;
            outline: none;
            background: var(--bg-color);
            color: var(--text-main);
            min-height: 50px;
            box-sizing: border-box;
            transition: all 0.2s;
        }

        .txt-comment:focus {
            background: #ffffff;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(29, 155, 240, 0.15);
        }

        .comment-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 8px;
        }

        .btn-comment-submit {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 6px 16px;
            font-weight: 700;
            font-size: 13px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-comment-submit:hover {
            background-color: var(--primary-hover);
        }

        #ContentPlaceHolder1_DataList2 {
            width: 100%;
        }

        #ContentPlaceHolder1_DataList2 td {
            padding-bottom: 15px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* --- TAM EKRAN RESİM MODAL ALANI --- */
        .image-modal {
            display: none;
            position: fixed;
            z-index: 99999;
            left: 0;
            top: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.88);
            backdrop-filter: blur(4px);
            justify-content: center;
            align-items: center;
            cursor: zoom-out;
        }

        .image-modal img {
            max-width: 90vw;
            max-height: 90vh;
            border-radius: 12px;
            object-fit: contain;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            animation: zoomModal 0.25s ease;
            cursor: default;
        }

        .modal-close-btn {
            position: absolute;
            top: 20px;
            right: 25px;
            color: #ffffff;
            font-size: 36px;
            font-weight: bold;
            cursor: pointer;
            background: none;
            border: none;
            line-height: 1;
            transition: opacity 0.2s;
        }

        .modal-close-btn:hover {
            opacity: 0.7;
        }

        @keyframes zoomModal {
            from { transform: scale(0.85); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="feed-container">

        <!-- 1. YAZI YAZMA VE MEDYA YÜKLEME ALANI -->
        <div class="create-post-box">
            <div class="post-input-area">
                <asp:TextBox ID="txtYeniGonderi" runat="server" CssClass="txt-tweet" TextMode="MultiLine" Rows="2" placeholder="Neler oluyor?"></asp:TextBox>
                
                <!-- Seçilen Görselin Anlık Önizleme Alanı -->
                <div id="mediaPreviewBox" class="media-preview-container">
                    <img id="imgPreview" src="#" alt="Önizleme" />
                    <button type="button" class="btn-remove-media" onclick="clearMedia()">×</button>
                </div>

                <div class="post-toolbar">
                    <div class="media-upload-wrapper">
                        <div class="media-upload-btn">
                            📷 Medya Ekle
                        </div>
                        <asp:FileUpload ID="filePostMedia" runat="server" CssClass="hidden-file-input" accept=".png,.jpg,.jpeg" onchange="previewImage(this);" />
                    </div>

                    <asp:Button ID="btnPaylas" runat="server" Text="Yankıla" CssClass="btn-tweet" OnClick="btnPaylas_Click" />
                </div>
            </div>
        </div>

        <!-- 2. KİMİ TAKİP ETMELİ (DataList1) -->
        <div class="suggestions-box">
            <div class="suggestions-header">Kimi Takip Etmeli</div>

            <asp:DataList ID="DataList1" runat="server" RepeatLayout="Flow" CssClass="user-list">
                <ItemTemplate>
                    <div class="user-card" onclick="goToProfile('<%# Eval("Username") %>', event);">
                        <div class="avatar-container">
                            <img src='<%# Eval("ProfileImage") %>' alt="Profil" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de'" />
                        </div>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Username") %>' CssClass="username-lbl"></asp:Label>
                        <span class="user-handle">@<%# Eval("Username") %></span>

                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("ProfileImage") %>' CssClass="hidden-lbl"></asp:Label>
                        <asp:Button ID="Button1" runat="server" CssClass="btn-action" Text="Takip Et" CommandArgument='<%# Eval("id") %>' OnClick="Button1_Click" />
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>

        <!-- 3. AKIŞ ALANI (DataList2) -->
        <div class="feed-list-container">
            <asp:DataList ID="DataList2" runat="server" RepeatLayout="Flow">
                <ItemTemplate>
                    <div class="feed-post" onclick="goToDetail('<%# Eval("id") %>', event);">

                        <!-- Profil Fotoğrafı Tıklaması -->
                        <img src='<%# Eval("ProfileImage") %>' class="user-avatar-small" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" onclick="goToProfile('<%# Eval("Username") %>', event);" />

                        <div class="post-content-area">

                            <div class="post-header">
                                <!-- İsme Tıklayınca UserProfile Açılır -->
                                <span class="post-name-wrapper" onclick="goToProfile('<%# Eval("Username") %>', event);">
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Username") %>' CssClass="post-name"></asp:Label>
                                </span>
                                
                                <span class="post-meta">@<%# Eval("Username") %> • 
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                </span>
                            </div>

                            <div class="post-text">
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Content") %>'></asp:Label>
                            </div>

                            <!-- Gönderide Medya Varsa Görseli Gösterir (Tıklandığında Büyütür) -->
                            <asp:Image ID="imgPost" runat="server" ImageUrl='<%# Eval("MediaUrl") %>' CssClass="post-media-image" Visible='<%# !string.IsNullOrEmpty(Eval("MediaUrl") as string) %>' onclick="openImageModal(this.src, event);" />

                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("ProfileImage") %>' CssClass="hidden-lbl"></asp:Label>

                            <div class="post-interaction">
                                <!-- Yorum Butonu -->
                                <button type="button" class="interaction-tab-btn" onclick="toggleCommentBox(this); event.stopPropagation();">
                                    💬 <%# Eval("YorumSayisi") %>
                                </button>
                                
                                <!-- Repost / Retweet Butonu -->
                                <asp:LinkButton ID="btnRetweet" runat="server" CssClass="interaction-tab-btn retweet" CommandName="retweet" CommandArgument='<%# Eval("id") %>' OnClick="btnRepost_Click">
                                    🔁 <%# Eval("RepostSayisi") %>
                                </asp:LinkButton>
                                
                                <!-- Beğeni Butonu -->
                                <asp:LinkButton ID="btnLike" runat="server" CssClass="interaction-tab-btn like" CommandName="like" OnClick="btnLike_Click" CommandArgument='<%# Eval("id") %>'>
                                    ❤️ <%# Eval("BegeniSayisi") %>
                                </asp:LinkButton>
                            </div>

                            <!-- AÇILIR YORUM YAPMA ALANI -->
                            <div class="comment-box-container" onclick="event.stopPropagation();">
                                <asp:TextBox ID="txtYorumYap" runat="server" CssClass="txt-comment" TextMode="MultiLine" Rows="2" placeholder="Yankını yanıtla..."></asp:TextBox>
                                <div class="comment-actions">
                                    <asp:Button ID="btnYorumGonder" runat="server" Text="Yanıtla" CssClass="btn-comment-submit" CommandArgument='<%# Eval("id") %>' OnClick="YorumYap_Click" />
                                </div>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>

    </div>

    <!-- BÜYÜTÜLMÜŞ GÖRSEL MODAL PENCERESİ -->
    <div id="imageLightboxModal" class="image-modal" onclick="closeImageModal()">
        <button type="button" class="modal-close-btn" onclick="closeImageModal()">&times;</button>
        <img id="lightboxTargetImg" src="" alt="Büyütülmüş Görsel" onclick="event.stopPropagation();" />
    </div>

    <!-- JavaScript Fonksiyonları -->
    <script type="text/javascript">
        function goToProfile(username, event) {
            if (event) {
                event.stopPropagation();
                event.preventDefault();
            }
            window.location.href = 'UserProfile.aspx?u=' + encodeURIComponent(username);
        }

        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('imgPreview').src = e.target.result;
                    document.getElementById('mediaPreviewBox').style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function clearMedia() {
            var fileInput = document.getElementById('<%= filePostMedia.ClientID %>');
            fileInput.value = '';
            document.getElementById('mediaPreviewBox').style.display = 'none';
            document.getElementById('imgPreview').src = '#';
        }

        function toggleCommentBox(btn) {
            var postContentArea = btn.closest('.post-content-area');
            var commentBox = postContentArea.querySelector('.comment-box-container');
            if (commentBox.style.display === 'block') {
                commentBox.style.display = 'none';
            } else {
                commentBox.style.display = 'block';
            }
        }

        function goToDetail(postId, event) {
            if (event.target.closest('button') || event.target.closest('a') || event.target.closest('input') || event.target.closest('textarea') || event.target.closest('.user-avatar-small') || event.target.closest('.post-name-wrapper')) {
                return;
            }
            window.location.href = 'Yorumlar.aspx?postId=' + postId;
        }

        /* Fotoğrafı Büyütme Fonksiyonları */
        function openImageModal(imgSrc, event) {
            if (event) {
                event.stopPropagation();
            }
            var modal = document.getElementById('imageLightboxModal');
            var targetImg = document.getElementById('lightboxTargetImg');

            targetImg.src = imgSrc;
            modal.style.display = 'flex';
        }

        function closeImageModal() {
            var modal = document.getElementById('imageLightboxModal');
            modal.style.display = 'none';
            document.getElementById('lightboxTargetImg').src = '';
        }

        // ESC tuşuna basınca modalı kapatma
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeImageModal();
            }
        });
    </script>

</asp:Content>