﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Event.master" AutoEventWireup="true" CodeFile="Event_RegisterModel4_Create.aspx.cs" Inherits="Event_Event_RegisterModel4_Create" StylesheetTheme="Event" Culture="auto" UICulture="auto" %>

<%@ Register Src="~/Event/UserControl/UC_EventDescription.ascx" TagPrefix="uc1" TagName="UC_EventDescription" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(function () {
            //活動開始日期
            $('#<%= txtExamineebirthday.ClientID%>').prop("readonly", true).datepicker({
                dateFormat: 'yy/mm/dd',
                changeMonth: true,
                changeYear: true
            });
        });
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:UC_EventDescription runat="server" ID="UC_EventDescription" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
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
                    <td>
                        <asp:Label ID="lblHealthGroup" runat="server" Text="健檢組別"></asp:Label>
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
                    <td>
                        <asp:TextBox ID="txtHealthGroup" runat="server" ReadOnly="true" CssClass="QueryField"></asp:TextBox>
                    </td>
                </tr>
                <tr class="FormTRStyle">
                    <td>
                        <asp:Label ID="lblIdentity" runat="server" Text="受診者身份別"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblExamineename" runat="server" Text="受診者姓名"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblExamineename2" runat="server" Text="受診者拼音"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblExamineeidno" runat="server" Text="受診者居留證字號"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblExamineebirthday" runat="server" Text="受診者出生年月日"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblExamineemobile" runat="server" Text="受診者手機"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlIdentity" runat="server" CssClass="QueryField" Width="100%">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                            <asp:ListItem>社員</asp:ListItem>
                            <asp:ListItem>家屬</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExamineename" runat="server" CssClass="QueryField"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExamineename2" runat="server" CssClass="QueryField"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExamineeidno" runat="server" CssClass="QueryField" MaxLength="10"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExamineebirthday" MaxLength="10" runat="server" CssClass="QueryField"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExamineemobile" MaxLength="10" runat="server" CssClass="QueryField" onkeypress="if(event.keyCode < 48 || event.keyCode >57) event.returnValue = false;"></asp:TextBox>
                    </td>

                </tr>
                <tr class="FormTRStyle">
                    <td>
                        <asp:Label ID="lblHosipital" runat="server" Text="健檢醫院"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblArea" runat="server" Text="地區"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSolution" runat="server" Text="費用&方案"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblGender" runat="server" Text="受診者性別"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblExpectdate" runat="server" Text="期望受檢日"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSeconddate" runat="server" Text="備用受檢日"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlHosipital" runat="server" CssClass="QueryField" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="ddlHosipital_SelectedIndexChanged">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlArea" runat="server" CssClass="QueryField" Width="100%" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSolution" runat="server" CssClass="QueryField" Width="100%" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlSolution_SelectedIndexChanged">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="QueryField" Width="100%" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlGender_SelectedIndexChanged">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlExpectdate" runat="server" CssClass="QueryField" Width="100%" Enabled="false">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSeconddate" runat="server" CssClass="QueryField" Width="100%" Enabled="false">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="FormTRStyle">
                    <td>
                        <asp:Label ID="lblSecondsolution1" runat="server" Text="健檢次方案1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSecondsolution2" runat="server" Text="健檢次方案2"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSecondsolution3" runat="server" Text="健檢次方案3"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlSecondsolution1" runat="server" CssClass="QueryField" Width="100%" Enabled="false">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSecondsolution2" runat="server" CssClass="QueryField" Width="100%" Enabled="false">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSecondsolution3" runat="server" CssClass="QueryField" Width="100%" Enabled="false">
                            <asp:ListItem Selected="True">- 未指定 -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr class="FormTRStyle">
                    <td colspan="3">
                        <asp:Label ID="lblOptional" runat="server" Text="自費加選項目"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblAddress" runat="server" Text="健檢包寄送地點"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblMeal" runat="server" Text="餐點樣式"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:TextBox ID="txtOptional" runat="server" TextMode="MultiLine" Width="100%" Height="100px" CssClass="QueryField"></asp:TextBox>
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                        <asp:RadioButtonList ID="rblAddress" runat="server" CssClass="controlCommon" RepeatColumns="2" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rblAddress_SelectedIndexChanged">
                        </asp:RadioButtonList>
                        <asp:RadioButton ID="rbtnOrther" runat="server" Text="其它" CssClass="controlCommon" AutoPostBack="true" OnCheckedChanged="rbtnOrther_CheckedChanged" />
                        <asp:TextBox ID="txtOrther" runat="server" CssClass="QueryField"></asp:TextBox>
                    </td>
                    <td style="vertical-align: top;">
                        <asp:DropDownList ID="ddlMeal" runat="server" CssClass="QueryField" Width="100%">
                            <asp:ListItem Value="">- 未指定 -</asp:ListItem>
                            <asp:ListItem Value="日式">日式</asp:ListItem>
                            <asp:ListItem Value="西式">西式</asp:ListItem>
                            <asp:ListItem Value="中式">中式</asp:ListItem>
                            <asp:ListItem Value="素食">素食</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="FormTRStyle">
                    <td>
                        <asp:Label ID="lblNeedhotel" runat="server" Text="是否預約飯店"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblCheckininfo" runat="server" Text="住宿人名單(例：野原廣治 35歲)"></asp:Label>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButtonList ID="rblNeedhotel" runat="server" CssClass="controlCommon" AutoPostBack="true" OnSelectedIndexChanged="rblNeedhotel_SelectedIndexChanged">
                            <asp:ListItem Value="是">是</asp:ListItem>
                            <asp:ListItem Value="否" Selected="True">否</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td colspan="2" style="vertical-align: top">
                        <asp:TextBox ID="txtCheckininfo" runat="server" TextMode="MultiLine" CssClass="QueryField" Width="100%" Height="100%" Enabled="false"></asp:TextBox>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr class="FormTRStyle">
                    <td colspan="3">
                        <asp:Label ID="lblComment" runat="server" Text="意見/問題回饋"></asp:Label>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="100%" Height="100px" CssClass="QueryField"></asp:TextBox>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:Button ID="btnSummit" runat="server" Text="送出" CssClass="Button" OnClick="btnSummit_Click" />
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
                    <asp:Label ID="lblErrMsg" runat="server" Text=""></asp:Label><br />
                </asp:Panel>
            </div>

            <asp:Label ID="lblRequired" runat="server" Text="欄位 {0} 為必填欄位。" Visible="false"></asp:Label>
            <asp:Label ID="lblUnselect" runat="server" Text="- 未指定 -" Visible="false"></asp:Label>
            <asp:Label ID="lblLimitReached" runat="server" Text="此方案報名人數已達上限，請重新選擇其他方案" Visible="false"></asp:Label>
            <asp:Label ID="lblSendMailFailed" runat="server" Text="但報名成功通知mail寄送失敗。" Visible="false"></asp:Label>
            <asp:HiddenField ID="hfmsg" runat="server" Value="訊息" />
            <asp:HiddenField ID="hfWarning" runat="server" Value="警告" />
            <asp:Button ID="btnGoBackPage" runat="server" Text="Button" OnClick="btnGoBackPage_Click" Style="display: none;" />
            <asp:Label ID="lblRegisterErrMsg" runat="server" Text="報名資料新增發生錯誤。" Visible="false"></asp:Label>
            <asp:Label ID="lblIDFormatErr" runat="server" Text="居留證字號格式錯誤。" Visible="false"></asp:Label>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSummit" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

