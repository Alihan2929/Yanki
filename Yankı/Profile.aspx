<%@ Page Title="" Language="C#" MasterPageFile="~/Layout1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Yankı.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* --- PROFİL ANA YAPI --- */
        .profile-container {
            max-width: 630px;
            margin: 24px auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-card {
            background-color: var(--card-bg);
            border-radius: 20px;
            box-shadow: var(--shadow-subtle);
            border: 1px solid var(--border-color);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            width: 100%;
            animation: fadeIn 0.4s ease;
        }

        .profile-cover {
            height: 160px;
            background: linear-gradient(135deg, var(--primary-color), #0a66c2);
            width: 100%;
        }

        .profile-details {
            padding: 16px 20px 0 20px; 
            position: relative;
        }

        /* Ayarlar Butonu */
        .btn-settings {
            position: absolute;
            top: 16px;
            right: 20px;
            background-color: transparent;
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 7px 18px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-settings:hover { 
            background-color: var(--bg-color); 
            border-color: #cfd9de;
        }

        .profile-avatar-container {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            border: 4px solid var(--card-bg);
            background-color: var(--card-bg);
            margin-top: -65px; 
            margin-bottom: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .profile-avatar-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-name {
            font-size: 20px;
            font-weight: 800;
            color: var(--text-main);
            margin-bottom: 2px;
            display: block;
            letter-spacing: -0.4px;
        }

        .profile-handle {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 10px;
        }

        .profile-bio {
            font-size: 14px;
            color: var(--text-main);
            margin-bottom: 12px;
            line-height: 1.4;
            word-break: break-word;
        }

        .profile-stats {
            display: flex;
            gap: 20px;
            margin-top: 8px;
            margin-bottom: 18px;
        }

        .stat-btn {
            background: none;
            border: none;
            padding: 0;
            font-size: 14px;
            color: var(--text-secondary);
            display: inline-flex;
            gap: 6px;
            align-items: center;
            cursor: pointer;
            font-family: inherit;
            text-decoration: none;
        }

        .stat-btn:hover {
            text-decoration: underline;
            color: var(--text-main);
        }

        .stat-value {
            font-weight: 700;
            color: var(--text-main);
        }

        /* --- MODAL STİLİ --- */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
            justify-content: center;
            align-items: center;
            animation: fadeIn 0.25s ease;
        }

        .modal-overlay.active {
            display: flex;
        }

        .dropdown-box {
            background-color: var(--card-bg);
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.25);
            border: 1px solid var(--border-color);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            width: 90%;
            max-width: 420px;
            max-height: 70vh;
            animation: scaleIn 0.25s ease;
            margin: 0;
        }

        .dropdown-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
            font-weight: 800;
            font-size: 16px;
            color: var(--text-main);
            position: sticky;
            top: 0;
            background-color: var(--card-bg);
            z-index: 1;
        }

        .dropdown-close-btn {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: var(--text-secondary);
            font-weight: 700;
            padding: 4px 8px;
            border-radius: 50%;
            line-height: 1;
            transition: all 0.2s;
        }
        .dropdown-close-btn:hover {
            color: var(--text-main);
            background-color: var(--bg-color);
        }

        .dropdown-body {
            padding: 8px 20px 16px;
            overflow-y: auto;
            scrollbar-width: thin;
            flex: 1;
        }

        .follow-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .follow-item:last-child {
            border-bottom: none;
        }

        .follow-user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .follow-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            object-fit: cover;
        }

        .follow-names {
            display: flex;
            flex-direction: column;
        }

        .follow-username {
            font-weight: 700;
            font-size: 15px;
            color: var(--text-main);
        }

        .follow-handle {
            font-size: 13px;
            color: var(--text-secondary);
        }

        /* --- PROFİL SEKMELERİ --- */
        .profile-tabs {
            display: flex;
            border-bottom: 1px solid var(--border-color);
            width: 100%;
        }

        .profile-tab {
            flex: 1;
            text-align: center;
            padding: 14px 0;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-secondary);
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.2s;
            position: relative;
        }

        .profile-tab:hover {
            background-color: var(--bg-color);
            color: var(--text-main);
        }

        .profile-tab.active {
            font-weight: 800;
            color: var(--text-main);
        }

        .profile-tab.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 45px;
            height: 4px;
            background-color: var(--primary-color);
            border-radius: 4px 4px 0 0;
        }

        /* --- KULLANICI GÖNDERİLERİ --- */
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
            margin-bottom: 12px;
            word-break: break-word;
        }

        .post-media-image {
            width: 100%;
            max-height: 350px;
            border-radius: 16px;
            object-fit: cover;
            margin-bottom: 14px;
            border: 1px solid var(--border-color);
        }

        .post-interaction {
            display: flex;
            justify-content: space-between;
            max-width: 320px;
            color: var(--text-secondary);
            margin-top: 10px;
            margin-bottom: 12px;
        }

        .interaction-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: color 0.2s;
        }

        .interaction-btn:hover { color: var(--primary-color); }
        .interaction-btn.like:hover { color: #f4212e; }
        .interaction-btn.retweet:hover { color: #00ba7c; }
        .interaction-btn.liked { color: #f4212e; }

        .post-actions-right {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid var(--border-color);
        }

        .txt-edit-post {
            width: 100%;
            border: 1px solid var(--primary-color);
            border-radius: 12px;
            padding: 12px;
            font-size: 14px;
            font-family: inherit;
            outline: none;
            resize: vertical;
            margin-bottom: 10px;
            box-sizing: border-box;
            background-color: var(--bg-color);
            color: var(--text-main);
        }

        .btn-edit, .btn-delete, .btn-cancel {
            background-color: transparent;
            border-radius: 16px;
            padding: 5px 14px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .btn-edit { color: var(--primary-color); border: 1px solid var(--primary-color); }
        .btn-edit:hover { background-color: rgba(29, 155, 240, 0.08); }
        
        .btn-delete { color: #f4212e; border: 1px solid rgba(244, 33, 46, 0.4); }
        .btn-delete:hover { background-color: rgba(244, 33, 46, 0.08); }

        .btn-cancel { color: var(--text-secondary); border: 1px solid var(--border-color); }
        .btn-cancel:hover { background-color: var(--border-color); color: var(--text-main); }

        .btn-save-edit {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 5px 16px;
            border-radius: 16px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .btn-save-edit:hover { background-color: var(--primary-hover); }

        .hidden-lbl { display: none; }
        
        #ContentPlaceHolder1_DataList2, #ContentPlaceHolder1_DataList1, #ContentPlaceHolder1_DataList3, #ContentPlaceHolder1_DataList4, #ContentPlaceHolder1_DataListTakipciler, #ContentPlaceHolder1_DataListTakipEdilen { width: 100%; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes scaleIn {
            from { opacity: 0; transform: scale(0.92); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="profile-container">

        <!-- 1. PROFİL KARTI ALANI (DataList2) -->
        <asp:DataList ID="DataList2" runat="server" RepeatLayout="Flow">
            <ItemTemplate>
                <div class="profile-card">
                    <div class="profile-cover"></div>

                    <div class="profile-details">
                        <a href="Ayarlar.aspx" class="btn-settings">Ayarlar</a>

                        <div class="profile-avatar-container">
                            <img src='<%# Eval("ProfileImage") %>' alt="Profil" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de'" />
                        </div>

                        <div class="profile-text">
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Username") %>' CssClass="profile-name"></asp:Label>
                            <div class="profile-handle">@<%# Eval("Username") %></div>
                            
                            <!-- Biyografi Alanı -->
                            <div class="profile-bio">
                                <asp:Label ID="LabelBio" runat="server" Text='<%# Eval("Bio") %>'></asp:Label>
                            </div>

                            <div class="profile-stats">
                                <!-- Takip Edilenler Butonu -->
                                <asp:LinkButton ID="btnTakipEdilen" runat="server" CssClass="stat-btn" OnClick="TakipEdilenler_Click" OnClientClick="toggleDropdown('following-dropdown'); return false;">
                                    <span class="stat-value">
                                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("TakipEdilenSayisi") %>'></asp:Label>
                                    </span>
                                    Takip Edilen
                                </asp:LinkButton>

                                <!-- Takipçiler Butonu -->
                                <asp:LinkButton ID="btnTakipciler" runat="server" CssClass="stat-btn" OnClick="Takipcilerim_Click" OnClientClick="toggleDropdown('followers-dropdown'); return false;">
                                    <span class="stat-value">
                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("TakipciSayisi") %>'></asp:Label>
                                    </span>
                                    Takipçi
                                </asp:LinkButton>
                            </div>
                        </div>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("ProfileImage") %>' CssClass="hidden-lbl"></asp:Label>
                    </div>

                    <!-- PROFİL SEKMELERİ -->
                    <div class="profile-tabs">
                        <a href="Profile.aspx?tab=gonderiler" class='profile-tab <%# string.IsNullOrEmpty(Request.QueryString["tab"]) || Request.QueryString["tab"] == "gonderiler" ? "active" : "" %>'>Gönderiler</a>
                        <a href="Profile.aspx?tab=yanitlar" class='profile-tab <%# Request.QueryString["tab"] == "yanitlar" ? "active" : "" %>'>Yanıtlar</a>
                        <a href="Profile.aspx?tab=retweetler" class='profile-tab <%# Request.QueryString["tab"] == "retweetler" ? "active" : "" %>'>Retweetler</a>
                        <a href="Profile.aspx?tab=medya" class='profile-tab <%# Request.QueryString["tab"] == "medya" ? "active" : "" %>'>Medya</a>
                        <a href="Profile.aspx?tab=begeni" class='profile-tab <%# Request.QueryString["tab"] == "begeni" ? "active" : "" %>'>Beğeni</a>
                    </div>
                    
                </div>
            </ItemTemplate>
        </asp:DataList>

        <!-- MODAL OVERLAY + TAKİP EDİLENLER -->
        <div id="following-dropdown" class="modal-overlay" onclick="closeIfOverlay(event, 'following-dropdown')">
            <div class="dropdown-box" onclick="event.stopPropagation()">
                <div class="dropdown-header">
                    <span>Takip Edilenler</span>
                    <button type="button" class="dropdown-close-btn" onclick="closeDropdown('following-dropdown')">✕</button>
                </div>
                <div class="dropdown-body">
                    <asp:DataList ID="DataListTakipEdilen" runat="server" RepeatLayout="Flow" Width="100%">
                        <ItemTemplate>
                            <div class="follow-item">
                                <div class="follow-user-info">
                                    <img src='<%# Eval("ProfileImage") %>' class="follow-avatar" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />
                                    <div class="follow-names">
                                        <span class="follow-username"><%# Eval("Username") %></span>
                                        <span class="follow-handle">@<%# Eval("Username") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>

        <!-- MODAL OVERLAY + TAKİPÇİLER -->
        <div id="followers-dropdown" class="modal-overlay" onclick="closeIfOverlay(event, 'followers-dropdown')">
            <div class="dropdown-box" onclick="event.stopPropagation()">
                <div class="dropdown-header">
                    <span>Takipçiler</span>
                    <button type="button" class="dropdown-close-btn" onclick="closeDropdown('followers-dropdown')">✕</button>
                </div>
                <div class="dropdown-body">
                    <asp:DataList ID="DataListTakipciler" runat="server" RepeatLayout="Flow" Width="100%">
                        <ItemTemplate>
                            <div class="follow-item">
                                <div class="follow-user-info">
                                    <img src='<%# Eval("ProfileImage") %>' class="follow-avatar" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />
                                    <div class="follow-names">
                                        <span class="follow-username"><%# Eval("Username") %></span>
                                        <span class="follow-handle">@<%# Eval("Username") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>

        <!-- LİSTELEME ALANLARI -->
        <div class="feed-list-container">

            <!-- 2. KULLANICININ GÖNDERİLERİ ALANI (DataList1) -->
            <asp:DataList ID="DataList1" runat="server" RepeatLayout="Flow">
                <ItemTemplate>
                    <div class="feed-post">
                        <img src='<%# Eval("ProfileImage") %>' class="post-avatar" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />
                        
                        <div class="post-content-area">
                            <div class="post-header">
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("Username") %>' CssClass="post-name"></asp:Label>
                                <span class="post-meta">
                                    @<%# Eval("Username") %> • 
                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                </span>
                            </div>

                            <div class="view-mode">
                                <div class="post-text">
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("Content") %>'></asp:Label>
                                </div>

                                <asp:Image ID="imgPostProfile" runat="server" ImageUrl='<%# Eval("MediaUrl") %>' CssClass="post-media-image" Visible='<%# !string.IsNullOrEmpty(Eval("MediaUrl") as string) %>' />

                                <div class="post-interaction">
                                    <div class="interaction-btn">💬 0</div>
                                    <div class="interaction-btn retweet">🔁 0</div>
                                    <div class="interaction-btn like">❤️ 0</div>
                                    <div class="interaction-btn">📊 0</div>
                                </div>

                                <div class="post-actions-right">
                                    <asp:Button ID="Button4" runat="server" Text="Düzenle" CssClass="btn-edit" OnClientClick="toggleEdit(this); return false;" />
                                    <asp:Button ID="Button3" runat="server" Text="Sil" CssClass="btn-delete" OnClientClick="return confirm('Bu gönderiyi silmek istediğine emin misin?');" OnClick="Button3_Click" CommandArgument='<%# Eval("id") %>' />
                                </div>
                            </div>

                            <div class="edit-mode" style="display: none;">
                                <asp:TextBox ID="txtEditContent" runat="server" TextMode="MultiLine" Rows="3" CssClass="txt-edit-post" Text='<%# Eval("Content") %>'></asp:TextBox>
                                <div class="post-actions-right">
                                    <asp:Button ID="btnSaveEdit" runat="server" Text="Kaydet" CssClass="btn-save-edit" CommandArgument='<%# Eval("id") %>' OnClick="SaveButton_Click" />
                                    <button type="button" class="btn-cancel" onclick="toggleView(this);">Vazgeç</button>
                                </div>
                            </div>
                        </div>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProfileImage") %>' CssClass="hidden-lbl"></asp:Label>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <!-- 3. BEĞENİLEN GÖNDERİLER ALANI (DataList3) -->
            <asp:DataList ID="DataList3" runat="server" RepeatLayout="Flow">
                <ItemTemplate>
                    <div class="feed-post">
                        <img src='<%# Eval("ProfileImage") %>' class="post-avatar" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />
                        
                        <div class="post-content-area">
                            <div class="post-header">
                                <asp:Label ID="Label15" runat="server" Text='<%# Eval("Username") %>' CssClass="post-name"></asp:Label>
                                <span class="post-meta">
                                    @<%# Eval("Username") %> • 
                                    <asp:Label ID="Label14" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                </span>
                            </div>

                            <div class="post-text">
                                <asp:Label ID="Label13" runat="server" Text='<%# Eval("Content") %>'></asp:Label>
                            </div>

                            <asp:Image ID="imgPostLiked" runat="server" ImageUrl='<%# Eval("MediaUrl") %>' CssClass="post-media-image" Visible='<%# !string.IsNullOrEmpty(Eval("MediaUrl") as string) %>' />

                            <div class="post-interaction">
                                <div class="interaction-btn">💬 0</div>
                                <div class="interaction-btn retweet">🔁 0</div>
                                <div class="interaction-btn like liked">❤️ 1</div>
                                <div class="interaction-btn">📊 0</div>
                            </div>
                        </div>
                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("ProfileImage") %>' CssClass="hidden-lbl"></asp:Label>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <!-- 4. RETWEET EDİLEN GÖNDERİLER ALANI (DataList4) -->
            <asp:DataList ID="DataList4" runat="server" RepeatLayout="Flow">
                <ItemTemplate>
                    <div class="feed-post">
                        <img src='<%# Eval("ProfileImage") %>' class="post-avatar" alt="Avatar" onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de&color=fff'" />
                        
                        <div class="post-content-area">
                            <div class="post-header">
                                <asp:Label ID="LabelName" runat="server" Text='<%# Eval("Username") %>' CssClass="post-name"></asp:Label>
                                <span class="post-meta">
                                    @<%# Eval("Username") %> • 
                                    <asp:Label ID="LabelDate" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                </span>
                            </div>

                            <div class="post-text">
                                <asp:Label ID="LabelContent" runat="server" Text='<%# Eval("Content") %>'></asp:Label>
                            </div>

                            <asp:Image ID="imgPostRepost" runat="server" ImageUrl='<%# Eval("MediaUrl") %>' CssClass="post-media-image" Visible='<%# !string.IsNullOrEmpty(Eval("MediaUrl") as string) %>' />

                            <div class="post-interaction">
                                <div class="interaction-btn">💬 0</div>
                                <div class="interaction-btn retweet">🔁 Repost</div>
                                <div class="interaction-btn like">❤️ 0</div>
                                <div class="interaction-btn">📊 0</div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

        </div>
    </div>


    <script type="text/javascript">
        function toggleEdit(btn) {
            var viewDiv = btn.closest('.view-mode');
            var editDiv = viewDiv.nextElementSibling;
            viewDiv.style.display = 'none';
            editDiv.style.display = 'block';
        }

        function toggleView(btn) {
            var editDiv = btn.closest('.edit-mode');
            var viewDiv = editDiv.previousElementSibling;
            editDiv.style.display = 'none';
            viewDiv.style.display = 'block';
        }

        // Modal aç/kapa
        function toggleDropdown(dropdownId) {
            var box = document.getElementById(dropdownId);
            var otherId = (dropdownId === 'following-dropdown') ? 'followers-dropdown' : 'following-dropdown';

            // Diğerini kapat
            document.getElementById(otherId).classList.remove('active');

            // Tıklananı aç/kapat
            if (box.classList.contains('active')) {
                box.classList.remove('active');
                document.body.style.overflow = '';
            } else {
                box.classList.add('active');
                document.body.style.overflow = 'hidden';
            }
        }

        function closeDropdown(dropdownId) {
            document.getElementById(dropdownId).classList.remove('active');
            document.body.style.overflow = '';
        }

        // Overlay’e tıklayınca kapat
        function closeIfOverlay(event, dropdownId) {
            if (event.target.id === dropdownId) {
                closeDropdown(dropdownId);
            }
        }

        // ESC tuşu ile kapatma
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeDropdown('following-dropdown');
                closeDropdown('followers-dropdown');
            }
        });
    </script>

</asp:Content>