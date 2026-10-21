<%@ Page Title="" Language="C#" MasterPageFile="~/Layout1.Master" AutoEventWireup="true" CodeBehind="Mesajlar.aspx.cs" Inherits="Yankı.Mesajlar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
/* =========================================================
   GENEL KONTEYNER & MODERN LAYOUT
   ========================================================= */
.messages-container {
    display: flex;
    background-color: var(--card-bg, #ffffff);
    border: 1px solid var(--border-color, #e1e8ed);
    border-radius: 24px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
    overflow: hidden;
    height: 650px;
    max-width: 1000px;
    margin: 30px auto;
    animation: fadeIn 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* =========================================================
   SOL SIDEBAR (SOHBET LİSTESİ)
   ========================================================= */
.conversations-sidebar {
    width: 360px;
    border-right: 1px solid var(--border-color, #e1e8ed);
    display: flex;
    flex-direction: column;
    background-color: var(--card-bg, #ffffff);
}

.sidebar-header {
    padding: 24px 20px;
    font-size: 20px;
    font-weight: 800;
    color: var(--text-main, #0f1419);
    border-bottom: 1px solid var(--border-color, #e1e8ed);
    letter-spacing: -0.3px;
}

.conversation-list {
    overflow-y: auto;
    flex: 1;
    scrollbar-width: thin;
    scrollbar-color: var(--border-color, #cbd5e1) transparent;
}

.conversation-list::-webkit-scrollbar {
    width: 6px;
}

.conversation-list::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

.conversation-item {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 16px 20px;
    border-bottom: 1px solid var(--border-color, #f1f3f5);
    text-decoration: none;
    transition: all 0.2s ease;
    cursor: pointer;
    width: 100%;
    background: none;
    border-top: none;
    border-left: none;
    border-right: none;
    text-align: left;
    font-family: inherit;
}

.conversation-item:hover {
    background-color: var(--bg-color, #f7f9fa);
    transform: translateX(2px);
}

.conv-avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
    box-shadow: 0 2px 5px rgba(0,0,0,0.08);
}

.conv-info {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    gap: 3px;
}

.conv-username {
    font-weight: 700;
    font-size: 15px;
    color: var(--text-main, #0f1419);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.conv-last-msg {
    font-size: 13px;
    color: var(--text-secondary, #536471);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* =========================================================
   SAĞ PANE (SOHBET ALANI)
   ========================================================= */
.chat-pane {
    flex: 1;
    display: flex;
    flex-direction: column;
    background-color: var(--bg-color, #f8fafc);
}

.chat-header {
    padding: 18px 24px;
    background-color: var(--card-bg, #ffffff);
    border-bottom: 1px solid var(--border-color, #e1e8ed);
    font-weight: 800;
    font-size: 16px;
    color: var(--text-main, #0f1419);
    display: flex;
    align-items: center;
    gap: 12px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.01);
}

.chat-messages-body {
    flex: 1;
    padding: 24px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    scroll-behavior: smooth;
    scrollbar-width: thin;
}

.chat-messages-body::-webkit-scrollbar {
    width: 6px;
}

.chat-messages-body::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

/* =========================================================
   DATA LIST / MESAJ LİSTESİ DÜZENİ
   ========================================================= */
.message-list {
    display: flex !important;
    flex-direction: column !important;
    gap: 10px;
    width: 100%;
}

/* =========================================================
   MESAJ BALONLARI
   ========================================================= */
.message-bubble {
    max-width: 65%;
    padding: 12px 18px;
    border-radius: 16px;
    font-size: 14px;
    line-height: 1.5;
    word-break: break-word;
    width: fit-content;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    position: relative;
    transition: transform 0.1s ease;
}

/* Giden Mesaj (Sağ) */
.message-bubble.outgoing {
    background: linear-gradient(135deg, var(--primary-color, #1d9bf0), #0a81d0);
    color: white;
    align-self: flex-end !important;
    margin-left: auto;
    border-bottom-right-radius: 4px;
}

/* Gelen Mesaj (Sol) */
.message-bubble.incoming {
    background-color: var(--card-bg, #ffffff);
    color: var(--text-main, #0f1419);
    align-self: flex-start !important;
    margin-right: auto;
    border: 1px solid var(--border-color, #e1e8ed);
    border-bottom-left-radius: 4px;
}

/* =========================================================
   ALT GİRİŞ / MESAJ GÖNDERME ÇUBUĞU
   ========================================================= */
.chat-input-footer {
    padding: 18px 24px;
    background-color: var(--card-bg, #ffffff);
    border-top: 1px solid var(--border-color, #e1e8ed);
    display: flex;
    gap: 12px;
    align-items: center;
}

.chat-input {
    flex: 1;
    padding: 14px 20px;
    border-radius: 30px;
    border: 1px solid var(--border-color, #cfd9de);
    background-color: var(--bg-color, #f7f9fa);
    color: var(--text-main, #0f1419);
    font-size: 14px;
    outline: none;
    transition: all 0.2s ease;
}

.chat-input:focus {
    border-color: var(--primary-color, #1d9bf0);
    background-color: var(--card-bg, #ffffff);
    box-shadow: 0 0 0 3px rgba(29, 155, 240, 0.15);
}

.btn-send-msg {
    background-color: var(--primary-color, #1d9bf0);
    color: white;
    border: none;
    border-radius: 30px;
    padding: 12px 24px;
    font-weight: 700;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 4px 12px rgba(29, 155, 240, 0.3);
}

.btn-send-msg:hover {
    filter: brightness(1.1);
    transform: translateY(-1px);
    box-shadow: 0 6px 15px rgba(29, 155, 240, 0.4);
}

.btn-send-msg:active {
    transform: translateY(0);
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="messages-container">

    <!-- SOL - SOHBET LİSTESİ -->
    <div class="conversations-sidebar">
        <div class="sidebar-header">
            Mesajlar
        </div>
        <div class="conversation-list">
            <asp:DataList
                ID="DataList2"
                runat="server"
                RepeatLayout="Flow"
                Width="100%">
                <ItemTemplate>
                    <asp:LinkButton
                        ID="btnSohbetSec"
                        runat="server"
                        CssClass="conversation-item"
                        CommandArgument='<%# Eval("KarsıID") %>'
                        OnClick="SohbetSec_Click">
                        <img
                            src='<%# Eval("ProfileImage") %>'
                            class="conv-avatar"
                            alt="Avatar"
                            onerror="this.src='https://ui-avatars.com/api/?name=User&background=cfd9de'" />
                        <div class="conv-info">
                            <span class="conv-username">
                                <%# Eval("Username") %>
                            </span>
                            <span class="conv-last-msg">
                                Sohbeti görüntüle...
                            </span>
                        </div>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>

    <!-- SAĞ - SOHBET -->
    <div class="chat-pane">
        <div class="chat-header">
            💬 Sohbet Ekranı
        </div>

        <!-- MESAJLAR -->
        <div class="chat-messages-body">
            <asp:DataList
                ID="DataList3"
                runat="server"
                RepeatLayout="Flow"
                Width="100%"
                CssClass="message-list">
                <ItemTemplate>
                    <div class='message-bubble <%# Eval("SenderID").ToString() == Session["id"].ToString() ? "outgoing" : "incoming" %>'>
                        <%# Eval("Message") %>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>

        <!-- MESAJ GÖNDER -->
        <div class="chat-input-footer">
            <asp:TextBox
                ID="txtMesajGonder"
                runat="server"
                CssClass="chat-input"
                placeholder="Yeni bir mesaj yazın...">
            </asp:TextBox>
            <asp:Button
                ID="btnMesajGonder"
                runat="server"
                Text="Gönder"
                CssClass="btn-send-msg"
                OnClick="MesajGonder_Click" />
        </div>
    </div>

</div>
</asp:Content>