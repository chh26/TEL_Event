﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TEL.Event.Lab.Method;

public partial class Event_Event : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TEL.Event.Lab.Method.SystemInfo gm = new TEL.Event.Lab.Method.SystemInfo();
            int isManager = gm.IsManager(Page.Session["EmpID"].ToString());
            hfIsManager.Value = isManager.ToString(); ;
            GeneratedCategoryItem();
            SetEventsGrid();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        //登入檢查
        int isManager = Convert.ToInt16(hfIsManager.Value);
        if (isManager == 0)
            Response.Redirect("Denied.aspx");//若為一般使用者則導到Denied頁面
        else if (isManager < 2)
        {
            tbAddEvent.Visible = false;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Event ev = new Event();
        int isManager = Convert.ToInt16(hfIsManager.Value);
        DataTable dt = ev.GetEventInfo(string.Empty, tbEventName.Text, ddlEventCategory.SelectedValue, sDate.Text, eDate.Text, ddlEventStatus.SelectedValue, string.Empty, isManager, Page.Session["EmpID"].ToString());

        this.gridEvents.DataSource = dt;
        this.gridEvents.DataBind();
    }

    protected void tbAddEvent_Click(object sender, EventArgs e)
    {
        Response.Redirect("Event_Create.aspx");
    }

    protected void btnMaintain_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string id = btn.CommandArgument.ToString();

        Response.Redirect($"Event_Edit.aspx?id={id}");
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string id = btn.CommandArgument.ToString();

        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), Guid.NewGuid().ToString(), "ShowDialogView('" + id + "');", true);
    }

    protected void btnRegisterManage_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string eventid = btn.CommandArgument.ToString();
        Response.Redirect($"Register.aspx?id={eventid}");
    }

    protected void btnRegisterExport_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string eventid = btn.CommandArgument.ToString();

        EventInfo evinfo = new EventInfo(eventid);
        ExportExcel ep = new ExportExcel();

        if (evinfo.EventRegisterModel == "1")
            ep.ExportRegisterModel1(eventid, string.Empty);
        else if (evinfo.EventRegisterModel == "2")
            ep.ExportRegisterModel2(eventid, string.Empty);
        else if (evinfo.EventRegisterModel == "3")
            ep.ExportRegisterModel3(eventid, string.Empty);
        else if (evinfo.EventRegisterModel == "4")
            ep.ExportRegisterModel4(eventid, string.Empty);
        else if (evinfo.EventRegisterModel == "5")
            ep.ExportRegisterModel5(eventid, string.Empty);
        else if (evinfo.EventRegisterModel == "6")
            ep.ExportRegisterModel6(eventid, string.Empty);

    }

    protected void btnSurveyManage_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string eventid = btn.CommandArgument.ToString();
        Response.Redirect($"Survey.aspx?id={eventid}");
    }

    protected void btnSurveyExport_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string eventid = btn.CommandArgument.ToString();
        EventInfo ev = new EventInfo(eventid);
        ExportExcel ep = new ExportExcel();

        if (ev.EventSurveyModel == "1")
            ep.ExportSurveyModel1(eventid);
        else if (ev.EventSurveyModel == "2")
            ep.ExportSurveyModel2(eventid);
        else if (ev.EventSurveyModel == "3")
            ep.ExportSurveyModel3(eventid);
        else if (ev.EventSurveyModel == "4")
            ep.ExportSurveyModel4(eventid);
    }

    protected void gridEvent_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //調整GridView資料行底色
            if (e.Row.RowIndex > -1)
            {
                //奇數行
                if (e.Row.RowIndex % 2 == 0)
                    e.Row.BackColor = Color.FromArgb(225, 225, 225);
                else
                    e.Row.BackColor = Color.FromArgb(245, 245, 245);
            }

            DataRowView dv = (DataRowView)e.Row.DataItem;

            Label lblStatus = (Label)e.Row.FindControl("lblStatus");

            //報名開始日期時間
            Label lblRegisterstart = (Label)e.Row.FindControl("lblRegisterstart");
            lblRegisterstart.Text = Convert.ToDateTime(dv["registerstart"].ToString()).ToString("yyyy/MM/dd HH:mm");
            //報名結束日期時間
            Label lblRegisterend = (Label)e.Row.FindControl("lblRegisterend");
            lblRegisterend.Text = Convert.ToDateTime(dv["registerend"].ToString()).ToString("yyyy/MM/dd HH:mm");

            //活動狀態
            DateTime now = DateTime.Now;
            int startCompare = Convert.ToDateTime(dv["eventstart"].ToString()).CompareTo(now);
            int endCompare = Convert.ToDateTime(dv["eventend"].ToString()).CompareTo(now);

            if (startCompare > 0)
            {
                // eventstart > now
                lblStatus.Text = lblNYStart.Text;
            }
            else if (endCompare < 0)
            {
                // eventend < now
                lblStatus.Text = lblEnd.Text;
            }
            else
            {
                //eventstart < now < eventend
                lblStatus.Text = lblInProgress.Text;
            }

            //是否啟用
            Label lblEnable = (Label)e.Row.FindControl("lblEnable");

            if (string.IsNullOrEmpty(dv["enabled"].ToString()))
                lblEnable.Text = lblEnableNo.Text;
            else
                lblEnable.Text = lblEnableYes.Text;

            Button btnSurveyManage = (Button)e.Row.FindControl("btnSurveyManage");
            Button btnSurveyExport = (Button)e.Row.FindControl("btnSurveyExport");
            Button btnSurveyPublish = (Button)e.Row.FindControl("btnSurveyPublish");

            if (string.IsNullOrEmpty(dv["surveymodel"].ToString()))
            {
                btnSurveyManage.Visible = false;
                btnSurveyExport.Visible = false;
                btnSurveyPublish.Visible = false;
            }
            else if (string.IsNullOrEmpty(dv["surveystartdate"].ToString()))
            {
                btnSurveyManage.Visible = false;
                btnSurveyExport.Visible = false;
                btnSurveyPublish.Visible = true;
            }
            else
            {
                btnSurveyManage.Visible = true;
                btnSurveyExport.Visible = true;
                btnSurveyPublish.Visible = false;
            }

        }
    }

    protected void gridEvent_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridEvents.PageIndex = e.NewPageIndex;
        SetEventsGrid();
    }


    protected void btnSurveyPublish_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string eventID = btn.CommandArgument.ToString().Split(',')[0];
        string eventName = btn.CommandArgument.ToString().Split(',')[1];
        string registermodel = btn.CommandArgument.ToString().Split(',')[2];
        string surveymodel = btn.CommandArgument.ToString().Split(',')[3];

        Event ev = new Event();
        string strSender = "FiestaSystem@tel.com";
        string strSubject = $"【通知】滿意度問卷填寫通知_{eventName}";
        string strDisplay = "Fiesta System";
        StringBuilder sbBody = new StringBuilder();
        DataTable dtRecipient = new DataTable();

        string surveyLink = HttpContext.Current.Request.Url.AbsoluteUri.Replace("/Event/Event.aspx", $"/Event/Event_SurveyModel{surveymodel}_Create.aspx?id={eventID}");
        string registerLink = HttpContext.Current.Request.Url.AbsoluteUri.Replace("/Event/Event.aspx", $"/Event/Default.aspx");
        sbBody.Append("<div>");
        sbBody.Append("<div>您好:</div>");
        sbBody.Append("<div><br></div>");
        sbBody.Append($"<div>此封信件為通知您參與了『<a href='{surveyLink}'>{eventName}（超連結）</a>』，請點選連結進行滿意度問卷填寫。</div>");
        sbBody.Append("<div><br></div>");
        sbBody.Append($"<div>相關報名資訊，可以至網站『<a href='{registerLink}'>我的活動（超連結）</a>』頁面中查看！</div>");
        sbBody.Append("<div>如果有任何問題請聯絡活動單位負責人，謝謝。</div>");
        sbBody.Append("<div><br></div>");
        sbBody.Append("<div><span style='color: #595959;'>※此信件為系統發送通知使用，請勿直接回覆。</span></div>");
        sbBody.Append("</div>");

        dtRecipient = ev.GetRegisteredEventInfo(eventID);



        if (dtRecipient.Rows.Count > 0)
        {
            if (SenMail.SendMail(strSender, dtRecipient, strSubject, sbBody.ToString(), strDisplay))
            {
                ev.UpdateEventSurveyStartDate(eventID);
            }
            else
            {
                lblMsg.Text = lblSurveyFailed.Text;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), Guid.NewGuid().ToString(), "ShowDialogMsg();", true);
            }
        }
        else
        {
            lblMsg.Text = lblNoRegister.Text;
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), Guid.NewGuid().ToString(), "ShowDialogMsg();", true);
        }
    }

    private void SetEventsGrid()
    {
        Event ev = new Event();
        int isManager = Convert.ToInt16(hfIsManager.Value);
        DataTable dt = ev.GetEventInfo(string.Empty, tbEventName.Text, ddlEventCategory.SelectedValue, sDate.Text, eDate.Text, ddlEventStatus.SelectedValue, string.Empty, isManager, Page.Session["EmpID"].ToString());

        this.gridEvents.DataSource = dt;
        this.gridEvents.DataBind();
    }

    // 取得活動分類選項
    protected void GeneratedCategoryItem()
    {
        this.ddlEventCategory.Items.Clear();

        ListItem li = new ListItem();
        li.Text = item_all.Text;
        li.Value = "";

        this.ddlEventCategory.Items.Add(li);

        SystemInfo si = new SystemInfo();
        DataTable dt = si.GetEventCategory("All");

        foreach (DataRow rs in dt.Rows)
        {
            ListItem li1 = new ListItem();
            li1.Text = rs["name"].ToString();
            li1.Value = rs["id"].ToString();

            this.ddlEventCategory.Items.Add(li1);
        }
    }
}