using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Report_Report_GeneralLedger : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.Title = "Return_Report_" + DateTime.Now.ToString("MMM_dd_yyyy_HHmmss");  
            lblDatetime.Text = DateTime.Now.ToString("MMM dd, yyyy.  hh:mm:ss tt");
            SystemInfo();

            string date = DateTime.Now.ToString("yyyy-MM-dd");
            string dtstart = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
            string dtend = DateTime.Now.AddDays(-0).ToString("yyyy-MM-dd");

            txtDateFrom.Text = dtstart.ToString();
            txtDateTo.Text = dtend.ToString();
        }
    }

    //header part  System information
    public void SystemInfo()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_SettingsUpdate", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);


            lblshopTitle.Text = dt.Rows[0].ItemArray[1].ToString();
            lblshopAddress.Text = dt.Rows[0].ItemArray[2].ToString();
            lblPhone.Text = dt.Rows[0].ItemArray[3].ToString();
            lblwebAddress.Text = dt.Rows[0].ItemArray[5].ToString();
            // lblFooterMessage.Text = dt.Rows[0].ItemArray[8].ToString();
            //lblVATRegiNo.Text = dt.Rows[0].ItemArray[7].ToString();
            cn.Close();
        }
        catch
        {
        }
    }
    
 
    public void Report_DateToDate_DataBind(string DateFrom, string DateTo)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Report_general_ledger", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@DateFrom", DateFrom);
            cmd.Parameters.AddWithValue("@DateTo", DateTo);

            grdViewReport.DataSource = cmd.ExecuteReader();
            grdViewReport.EmptyDataText = "No Records Found";
            grdViewReport.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdViewReport.Rows.Count) + " Records found" + "<br />";
            SystemInfo();
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }


    protected void txtDateFrom_TextChanged(object sender, EventArgs e)
    {
        Report_DateToDate_DataBind(txtDateFrom.Text, txtDateTo.Text);
    }

    protected void txtDateTo_TextChanged(object sender, EventArgs e)
    {
        Report_DateToDate_DataBind(txtDateFrom.Text, txtDateTo.Text);
    }

     

    // total Calculation  show on footer part
    double totalsales = 0;
    double totalreturns = 0; 

    protected void grdViewReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totalsales += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Sale"));
            totalreturns += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Return")); 

            e.Row.Cells[0].Width = 120; 
            e.Row.Cells[1].Font.Bold = true; 
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {            
            lblVat.Text = "Total Sales = " + totalsales.ToString();
            lblTotal.Text = "Total Return = " + totalreturns.ToString();
         //   lbltotalProfit.Text = "Total Profit = " + totalProfit.ToString();

            //Total  Sale Calculation
            e.Row.Cells[1].Text = totalsales.ToString("");
            string tvat = totalsales.ToString("c");
            int tsalcut = tvat.IndexOf('$');
            string tsalcutsum = tvat.Substring(tsalcut + 1);
            e.Row.Cells[1].Text = tsalcutsum;


            // Total Return calculation 
            e.Row.Cells[2].Text = totalreturns.ToString("");
            string tpay = totalreturns.ToString("c");
            int tpaycut = tpay.IndexOf('$');
            string tpaycutsum = tpay.Substring(tpaycut + 1);
            e.Row.Cells[2].Text = tpaycutsum;    
        
            decimal balance = Convert.ToDecimal(totalsales.ToString("")) - Convert.ToDecimal(totalreturns.ToString("")) ;

            e.Row.Cells[1].Text = totalsales.ToString("") + "<br/>" + balance.ToString();
            e.Row.Cells[2].Text = totalreturns.ToString("");

            e.Row.Cells[0].Text = "Total <br/> Balance";
            e.Row.Cells[0].Font.Size = 10;
            e.Row.Cells[1].Font.Size = 10;
            e.Row.Cells[2].Font.Size = 10;
            e.Row.Cells[0].Font.Bold = true;
            e.Row.Cells[1].Font.Bold = true;
            e.Row.Cells[2].Font.Bold = true;
             
            //e.Row.Cells[5].HorizontalAlign = e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            //e.Row.Cells[6].HorizontalAlign = e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Right; 
        }
    }

    #region Not used
    //Open Popup Show Details sales reports for every single trXID 
    protected void LinkDetails_click(object sender, EventArgs e)
    {
        //Details	Invoice	SalesID	Date	Qty	Subtotal	Vat	Total	Pay Type	Amount	Due	note	ShopId	Cust.Contact	ServedBy
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblInvoiceID.Text = gvrow.Cells[1].Text;
        lblNetTotal.Text = "Net total: " + gvrow.Cells[6].Text;
        lblProfit.Text = "Total Profit: " + gvrow.Cells[7].Text;
        lblDueAmount.Text = gvrow.Cells[10].Text;
        ReportDataBind_SalesDetails(gvrow.Cells[1].Text);

        Session["totalPayable"] = gvrow.Cells[6].Text;
        Session["vat"] = gvrow.Cells[5].Text;
        Session["PaidBy"] = gvrow.Cells[8].Text;

        Session["PaidAmt"] = gvrow.Cells[9].Text;
        Session["DueAmt"] = gvrow.Cells[10].Text;
        Session["Note"] = gvrow.Cells[11].Text;

        Session["CustContact"] = gvrow.Cells[13].Text;         
        Session["TotalQty"]     = gvrow.Cells[3].Text;
        Session["InvoiceNo"]    = gvrow.Cells[1].Text;
        Session["servedby"]     = gvrow.Cells[14].Text;
        Session["ShopID"]       = gvrow.Cells[12].Text; 

        this.ModalPopupDetails.Show();
    }

    protected void btntakepayment_Click(object sender, EventArgs e)
    {
        Session["invoice"] = lblInvoiceID.Text;
        Response.Redirect("~/Sales/TakePayment.aspx");
    }

    //Print: Move to all info into print page 
    protected void btnMovetoPrintPage_Click(object sender, EventArgs e)
    {
        Session["totalPayable"] = Session["totalPayable"];
        Session["vat"] = Session["vat"];
        Session["PaidBy"] = Session["PaidBy"];
        Session["PaidAmt"] = Session["PaidAmt"];
        Session["DueAmt"] = Session["DueAmt"];

        if (Convert.ToDouble(Session["DueAmt"]) > 0.00)
        {
            // double change = (Convert.ToDouble(Session["PaidAmt"])) - Convert.ToDouble(Session["totalPayable"]);
            Session["ChangeAmt"] = "0.00";
        }
        else
        {
            decimal change = (Convert.ToDecimal(Session["PaidAmt"])) - Convert.ToDecimal(Session["totalPayable"]);
            Session["ChangeAmt"] = Math.Round(change,2);
        }

        Session["Note"]         = Session["Note"];
        Session["CustName"]     = "";
        Session["CustID"]       = "";
        Session["Contact"]      = Session["CustContact"];
        Session["TotalQty"]     = Session["TotalQty"];
        Session["InvoiceNo"]    = Session["InvoiceNo"];
        Session["ShopID"]       = Session["ShopID"];
        DataTable table = new DataTable();

        table.Columns.Add("Code", typeof(string));
        table.Columns.Add("Items", typeof(string));
        table.Columns.Add("Qty", typeof(string));
        table.Columns.Add("Price", typeof(string));
        table.Columns.Add("Disc%", typeof(string));
        table.Columns.Add("Total", typeof(string));

        // Select the all row  from the GridView control
        for (int i = 0; i < grdviewTrXDetails.Rows.Count; i++)
        {
            string Code = grdviewTrXDetails.Rows[i].Cells[0].Text;
            string ItemName = grdviewTrXDetails.Rows[i].Cells[1].Text;
            string Qty = grdviewTrXDetails.Rows[i].Cells[2].Text;
            string Price = grdviewTrXDetails.Rows[i].Cells[3].Text;
            string Disc = grdviewTrXDetails.Rows[i].Cells[4].Text;
            string Total = grdviewTrXDetails.Rows[i].Cells[5].Text;

            table.Rows.Add(Code, ItemName, Qty, Price, Disc, Total);
        }
        table.AcceptChanges();
        Session.Add("Stable", table);
        Response.Redirect("~/Report/POS_printPage.aspx");
    }
  
    //AutoComplete  AutoCompleteExtender  ////////////////////////////////////////////   AutoCompleteExtender
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetMDN(string prefixText)
    {

        string constr = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ToString();
        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT TOP 8 * from    tbl_SalesPayment where ID like '%'+ @Value +'%'   or ServedBy like '%'+ @Value +'%' or CustContact like '%'+ @Value +'%' or ShopId   like '%'+ @Value +'%' or CustName   like '%'+ @Value +'%' or CustContact   like '%'+ @Value +'%' ", con);

        cmd.Parameters.AddWithValue("@Value", prefixText);

        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        adp.Fill(dt);
        List<string> MDN = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            // string var = dt.Rows[i][0].ToString() + " " + dt.Rows[i][12].ToString();
            string var = dt.Rows[i][0].ToString();
            MDN.Add(var);
            con.Close();
        }
        return MDN;
    }
   
    public void ReportDataBind(string value)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Report", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@Value", value);

            grdViewReport.DataSource = cmd.ExecuteReader();
            grdViewReport.EmptyDataText = "No Records Found";
            grdViewReport.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdViewReport.Rows.Count) + " Records found" + "<br />";

        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    public void ReportDataBind_SalesDetails(string value)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Report_SalesDetails", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@Value", value);

            grdviewTrXDetails.DataSource = cmd.ExecuteReader();
            grdviewTrXDetails.EmptyDataText = "No Records Found";
            grdviewTrXDetails.DataBind();
            cn.Close();
            lblRowCount.Text = "Sold item  : " + Convert.ToString(grdviewTrXDetails.Rows.Count) + "  " + "<br />";
        }
        catch
        {
            lblRowCount.Text = "No Records Found";
        }
    }


    #endregion
}