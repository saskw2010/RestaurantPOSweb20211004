using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class POS_printPage : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["vat"] != null)
            {
                try
                {
                    this.Title = "POS_Receipt#" + Session["InvoiceNo"].ToString();
                    SystemInfo();
                    DataTable table = Session["Stable"] as DataTable;

                    // grdItemList.EmptyDataText = "No Records Found";
                    //  grdItemList.DataSource = table;
                    // grdItemList.DataBind();

                    dtlistitems.DataSource = table;
                    dtlistitems.DataBind();

                    dtlistitems58.DataSource = table;
                    dtlistitems58.DataBind();

                    dtlistticket.DataSource = table;
                    dtlistticket.DataBind();

                    dtlistwaitercopy.DataSource = table;
                    dtlistwaitercopy.DataBind(); 

                    lblDatetime.Text    = DateTime.Now.ToString("MMM dd, yyyy.  hh:mm:ss tt");
                    lblvat.Text         = Session["vat"].ToString();
                    lblvatRate.Text     = Session["vatRate"].ToString() + "%";
                    lbltotalpay.Text    = Session["totalPayable"].ToString();
                    lblpaidby.Text      = Session["PaidBy"].ToString();
                    lblPaidAmt.Text     = Session["PaidAmt"].ToString();
                    lblChange.Text      = Session["ChangeAmt"].ToString();
                    lblDue.Text         = Session["DueAmt"].ToString();
                    lblTotalQty.Text    = Session["TotalQty"].ToString();
                    lbldiscountamt.Text = Session["discountamount"].ToString();
                  //  decimal subtotal = Convert.ToDecimal(Session["totalPayable"].ToString()) - Convert.ToDecimal(Session["vat"].ToString());
                    lblsubTotal.Text = Session["Subtotal"].ToString();
                    //Customer Info on POS Print Page
                    lblCustName.Text = Session["CustName"].ToString();
                    lblCustID.Text = Session["CustID"].ToString();
                    lblCustContactNo.Text = Session["Contact"].ToString();
                    lblServedBy.Text = Request.Cookies["POSCookies"]["UserID"].ToString();
                    lblInvoice.Text = Session["InvoiceNo"].ToString();
                    lbltableno.Text = Session["tableno"].ToString();
                    lbltokenno.Text = Session["tokenno"].ToString();

                    lblDatetime2.Text = DateTime.Now.ToString("MMM dd, yyyy.  hh:mm:ss tt");
                    lblvat2.Text = Session["vat"].ToString();
                    lblvatRate2.Text = Session["vatRate"].ToString() + "%";
                    lbltotalpay2.Text = Session["totalPayable"].ToString();
                    lblpaidby2.Text = Session["PaidBy"].ToString();
                    lblPaidAmt2.Text = Session["PaidAmt"].ToString();
                    lblChange2.Text = Session["ChangeAmt"].ToString();
                    lblDue2.Text = Session["DueAmt"].ToString();
                    lblTotalQty2.Text = Session["TotalQty"].ToString();
                    lbldiscountamt2.Text = Session["discountamount"].ToString();
                    lblsubTotal2.Text = Session["Subtotal"].ToString();
                    //Customer Info on POS Print Page
                    lblCustName2.Text = Session["CustName"].ToString();
                    lblCustID2.Text = Session["CustID"].ToString();
                    lblCustContactNo2.Text = Session["Contact"].ToString();
                    lblServedBy2.Text = Request.Cookies["POSCookies"]["UserID"].ToString();
                    lblInvoice2.Text = Session["InvoiceNo"].ToString();
                    lbltableno2.Text = Session["tableno"].ToString();
                    lbltokenno2.Text = Session["tokenno"].ToString();

                    lbldateTK.Text = DateTime.Now.ToString("MMM dd, yyyy.  HH:mm");
                    lblinvoiceTK.Text = Session["InvoiceNo"].ToString();
                    lbltablenoTK.Text = Session["tableno"].ToString();
                    lbltokenoTK.Text = Session["tokenno"].ToString();

                    lbldateTKW.Text = DateTime.Now.ToString("MMM dd, yyyy.  HH:mm");
                    lblinvoiceTKW.Text = Session["InvoiceNo"].ToString();
                    lbltablenoTKW.Text = Session["tableno"].ToString();
                    lbltokenoTKW.Text = Session["tokenno"].ToString();

                    if (System.Web.HttpContext.Current.Session["ShopID"] == null)
                    {
                        lblShopID.Text = "SYS89";
                        lblShopID2.Text = "SYS89";
                    }
                    else
                    {
                        lblShopID.Text = Session["ShopID"].ToString();
                        lblShopID2.Text = Session["ShopID"].ToString();
                    }
                    Session.Remove("tableno");
                }
                catch
                {
                }

            }
            else
            {
                Response.Redirect("~/Sales/SalesRegister.aspx");
            }        

        }
       
    }

    ////header part  System information
    //public void SystemInfo()
    //{
    //    try
    //    {
    //        SqlConnection cn = new SqlConnection(ConnectionString);
    //        SqlCommand cmd = new SqlCommand("SP_RestPOS_Databind_systeminfo", cn);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@InvoiceNo", Session["InvoiceNo"].ToString());
    //        cn.Open();


    //        SqlDataReader sdr = cmd.ExecuteReader();
    //        DataTable dt = new DataTable();
    //        dt.Load(sdr);
             

    //        lblshopTitle.Text  = dt.Rows[0]["CompanyName"].ToString();
    //        lblcompanytitleTK.Text = dt.Rows[0]["CompanyName"].ToString();
    //        lblshopAddress.Text = dt.Rows[0]["CompanyAddress"].ToString();
    //        lblPhone.Text = dt.Rows[0]["Phone"].ToString(); 
    //        lblwebAddress.Text = dt.Rows[0]["WebAddress"].ToString(); 
    //        lblFooterMessage.Text = DateTime.Now.ToString("yyyy-MMM-dd"); 
    //        lblVATRegiNo.Text = Session["invoice"].ToString();

    //        lblcompanytitleTK.Text = dt.Rows[0]["CompanyName"].ToString();
    //        lblshopTitle2.Text = dt.Rows[0]["CompanyName"].ToString();
    //        lblshopAddress2.Text = dt.Rows[0]["CompanyAddress"].ToString();
    //        lblPhone2.Text = dt.Rows[0]["Phone"].ToString();
    //        lblwebAddress2.Text = dt.Rows[0]["WebAddress"].ToString();
    //        lblFooterMessage2.Text = DateTime.Now.ToString("yyyy-MMM-dd");
    //        lblVATRegiNo2.Text = Session["invoice"].ToString();
    //        cn.Close();

    //    }
    //    catch
    //    {
    //    }
    //}

    //header part  System information
   
    public void SystemInfo()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_terminalInfo", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ShopID", Session["ShopID"].ToString());
            cn.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);

            lblcompanytitleTK.Text = "@" + dt.Rows[0].ItemArray[0].ToString();
            lblshopTitle.Text = dt.Rows[0].ItemArray[0].ToString();
            lblshopAddress.Text = dt.Rows[0].ItemArray[1].ToString();
            lblPhone.Text = dt.Rows[0].ItemArray[2].ToString();
            lblwebAddress.Text = dt.Rows[0].ItemArray[6].ToString();
            lblFooterMessage.Text = dt.Rows[0].ItemArray[8].ToString() + "<br/>  Email: " + dt.Rows[0].ItemArray[3].ToString();
            lblVATRegiNo.Text = dt.Rows[0].ItemArray[5].ToString();

            lblshopTitle2.Text = dt.Rows[0].ItemArray[0].ToString();
            lblshopAddress2.Text = dt.Rows[0].ItemArray[1].ToString();
            lblPhone2.Text = dt.Rows[0].ItemArray[2].ToString();
            lblwebAddress2.Text = dt.Rows[0].ItemArray[6].ToString();
            lblFooterMessage2.Text = dt.Rows[0].ItemArray[8].ToString() + "<br/>  Email: " + dt.Rows[0].ItemArray[3].ToString();
            lblVATRegiNo2.Text = dt.Rows[0].ItemArray[5].ToString();
            cn.Close();
        }
        catch
        {
        }
    }

}