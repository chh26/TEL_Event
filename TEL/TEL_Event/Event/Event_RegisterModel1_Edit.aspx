﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Event.master" AutoEventWireup="true" CodeFile="Event_RegisterModel1_Edit.aspx.cs" Inherits="Event_Event_RegisterModel1_Edit" StylesheetTheme="Event" Culture="auto" UICulture="auto" %>

<%@ Register Src="~/Event/UserControl/UC_EventDescription.ascx" TagPrefix="uc1" TagName="UC_EventDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function ShowDialogMsg() {
            $(function () {
                $("#dialogMsg").dialog({
                    title: $('#<%=hfmsg.ClientID%>')[0].value,
                    modal: true,
                    width: "700px",
                    Height: "500px",
                    position: { my: "center center", at: "center top+175", },
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        }
                    },
                    open: function (event, ui) {
                        //打開dialog時，顯示panel
                        document.getElementById("ContentPlaceHolder1_ContentPanel1").style.display = "block";
                    }
                });
            });

        }

        function ShowRegisterSccessDialog() {
            $(function () {
                $("#dialogRegisterSccess").dialog({
                    title: $('#<%=hfmsg.ClientID%>')[0].value,
                    modal: true,
                    width: "700px",
                    Height: "500px",
                    position: { my: "center center", at: "center top+175", },
                    buttons: {
                        Close: function () {
                            <%= btnGoBackPage.ClientID%>.click();
                        $(this).dialog('close');
                    }
                },
                    open: function (event, ui) {
                        //打開dialog時，顯示panel
                        document.getElementById("ContentPlaceHolder1_ContentPanel2").style.display = "block";
                    }
                });
        });

        }

        function ShowNoRegisterInfo() {
            $(function () {
                $("#dialogNoRegisterInfo").dialog({
                    title: $('#<%=hfmsg.ClientID%>')[0].value,
                    modal: true,
                    width: "700px",
                    Height: "500px",
                    position: { my: "center center", at: "center top+175", },
                    buttons: {
                        Close: function () {
                            <%= btnGoBackPage.ClientID%>.click();
                        $(this).dialog('close');
                    }
                },
                    open: function (event, ui) {
                        //打開dialog時，顯示panel
                        document.getElementById("ContentPlaceHolder1_ContentPanel4").style.display = "block";
                    }
                });
        });
        }

        //失敗通知 訊息開窗
        function ShowDialogFailed(ErrMsg) {
            $(function () {
                $("#dialogFailed").dialog({
                    title: $('#<%=hfWarning.ClientID%>')[0].value,
                    modal: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        }
                    },
                    open: function (event, ui) {
                        //打開dialog時，顯示panel
                        document.getElementById("ContentPlaceHolder1_ContentPanel3").style.display = "block";
                        $('#<%= lblErrMsg.ClientID %>').text(ErrMsg);

                    }
                });
            });

        };

        //是否刪除 訊息開窗
        function ShowDialogDelete(id) {
            $(function () {
                $("#dialogDelete").dialog({
                    title: $('#<%=hfmsg.ClientID%>')[0].value,
                    modal: true,
                    buttons: [
                        {
                            text: "確定",
                            click: function () {
                                onDelete(id);
                                $(this).dialog("close");
                            }
                        },
                        {
                            text: "取消",
                            click: function () {
                                $(this).dialog("close");
                            }
                        }
                    ],
                    open: function (event, ui) {
                        //打開dialog時，顯示panel
                        document.getElementById("ContentPlaceHolder1_ContentPanel6").style.display = "block";
                    }
                });
            });

        };

        //刪除資料events
        function onDelete(id) {
            PageMethods.DeleteRegisterModel1(id, Success, Failure);
        }

        //刪除資料events Success callback
        function Success(result) {
            //ShowDialogSuccessReload(result);
            //刪除成功 reload gridview
            <%= btnGoBackPage.ClientID%>.click();
        }

        //刪除資料events Failure callback
        function Failure(error) {
            ShowDialogFailed($('#<%=hfDeleteErrMsg.ClientID%>')[0].value);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <uc1:UC_EventDescription runat="server" ID="UC_EventDescription" />
    <table>
        <tr>
            <td>
                <asp:Label ID="lblStation" runat="server" Text="勤務地"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblEmpid" runat="server" Text="工號"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblCName" runat="server" Text="中文姓名"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblEName" runat="server" Text="英文姓名"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblDepartment" runat="server" Text="部門"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtStation" runat="server" ReadOnly="true" CssClass="QueryField"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtEmpid" runat="server" ReadOnly="true" CssClass="QueryField"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtCName" runat="server" ReadOnly="true" CssClass="QueryField"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtEName" runat="server" ReadOnly="true" CssClass="QueryField"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtDepartment" runat="server" ReadOnly="true" CssClass="QueryField"></asp:TextBox>
            </td>
        </tr>
        <tr class="FormTRStyle">
            <td colspan="5">
                <asp:Label ID="lblAttendContent" runat="server" Text="欲參加的內容"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:DropDownList ID="ddlAttendContent" runat="server" CssClass="QueryField" Width="100%">
                    <asp:ListItem Selected="True" Value="">- 未指定 -</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="2"></td>
        </tr>
        <tr class="FormTRStyle">
            <td colspan="5">
                <asp:Label ID="lblComment" runat="server" Text="意見/問題回饋"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="100%" Height="100px" CssClass="QueryField"></asp:TextBox>
            </td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:Button ID="btnSummit" runat="server" Text="儲存" CssClass="Button" OnClick="btnSummit_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="刪除" CssClass="Button" OnClick="btnDelete_Click" />
                <asp:Button ID="btnCannel" runat="server" Text="取消" CssClass="Button" OnClick="btnCannel_Click" />
            </td>
        </tr>
    </table>

    <div id="dialogMsg" title="Dialog Title">
        <asp:Panel ID="ContentPanel1" runat="server" Style="display: none">
            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        </asp:Panel>
    </div>


    <div id="dialogRegisterSccess" title="Dialog Title">
        <asp:Panel ID="ContentPanel2" runat="server" Style="display: none">
            <asp:Label ID="lblRegisterSccess" runat="server" Text="報名成功"></asp:Label>
        </asp:Panel>
    </div>
    <div id="dialogFailed" title="Dialog Title">
        <asp:Panel ID="ContentPanel3" runat="server" Style="display: none">
            <asp:Label ID="lblFailed" runat="server" Text="失敗。"></asp:Label>
            <asp:Label ID="lblErrMsg" runat="server" Text="" ></asp:Label><br />
        </asp:Panel>
    </div>

    <div id="dialogDelete" title="Dialog Title">
        <asp:Panel ID="ContentPanel6" runat="server" Style="display: none">
            <asp:Label ID="lblDeleteWarning" runat="server" Text="確定刪除該筆資料？"></asp:Label>
        </asp:Panel>
    </div>

    <div id="dialogNoRegisterInfo" title="Dialog Title">
        <asp:Panel ID="ContentPanel4" runat="server" Style="display: none">
            <asp:Label ID="lblNoRegisterInfo" runat="server" Text="查無報名資料。"></asp:Label>
        </asp:Panel>
    </div>

    <asp:Label ID="lblRequired" runat="server" Text="欄位 {0} 為必填欄位。" Visible="false"></asp:Label>
    <asp:Label ID="lblUnselect" runat="server" Text="- 未指定 -" Visible="false"></asp:Label>
    <asp:Label ID="lblLimitReached" runat="server" Text="此方案報名人數已達上限，請重新選擇其他方案" Visible="false"></asp:Label>
    <asp:Label ID="lblSendMailFailed" runat="server" Text="但報名成功通知mail寄送失敗。" Visible="false"></asp:Label>
    <asp:HiddenField ID="hfmsg" runat="server" Value="訊息" />
    <asp:HiddenField ID="hfWarning" runat="server" Value="警告" />
    <asp:Button ID="btnGoBackPage" runat="server" Text="Button" OnClick="btnGoBackPage_Click" Style="display: none;" />
    <asp:Label ID="lblUpdateErrMsg" runat="server" Text="報名資料儲存發生錯誤。" Visible="false"></asp:Label>
    <asp:HiddenField ID="hfDeleteErrMsg" runat="server" Value="報名資料刪除發生錯誤。" />
</asp:Content>

