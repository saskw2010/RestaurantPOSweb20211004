using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class ReturnPrintPage : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["vatR"] != null)  
            {
                try
                {
                    this.Title = "Returned_Invoice#" + Session["InvoiceNo"].ToString();
                    SystemInfo();
                    DataTable table = Session["Rtable"] as DataTable;

                    dtlistitems.DataSource = table;
                    dtlistitems.DataBind();

                    dtlistitems58.DataSource = table;
                    dtlistitems58.DataBind();

                    lblDatetime.Text    = DateTime.Now.ToString("MMM dd, yyyy.  hh:mm:ss tt");
                    lblvat.Text         = Session["vatR"].ToString();
                    lblvatRate.Text     = Session["vatRate"].ToString() + "%";
                    lbltotalpay.Text    = Session["totalPayable"].ToString();
                    lblpaidby.Text      = Session["PaidBy"].ToString();
                    lblPaidAmt.Text     = Session["PaidAmt"].ToString();
                    lblChange.Text      = Session["ChangeAmt"].ToString();
                    lblDue.Text         = Session["DueAmt"].ToString();
                    lblTotalQty.Text    = Session["TotalQty"].ToString();
                    decimal subtotal    = Convert.ToDecimal(Session["totalPayable"].ToString()) - Convert.ToDecimal(Session["vatR"].ToString());
                    lblsubTotal.Text    = subtotal.ToString();
                   
                    //Customer Info on POS Print Page
                    lblCustName.Text        = Session["CustName"].ToString();
                    lblCustID.Text          = Session["CustID"].ToString();
                    lblCustContactNo.Text   = Session["Contact"].ToString();
                    lblServedBy.Text        = Request.Cookies["POSCookies"]["UserID"].ToString();
                    lblInvoice.Text         = Session["InvoiceNo"].ToString();


                    lblDatetime2.Text   = DateTime.Now.ToString("MMM dd, yyyy.  hh:mm:ss tt");
                    lblvat2.Text        = Session["vatR"].ToString();
                    lblvatRate2.Text    = Session["vatRate"].ToString() + "%";
                    lbltotalpay2.Text   = Session["totalPayable"].ToString();
                    lblpaidby2.Text     = Session["PaidBy"].ToString();
                    lblPaidAmt2.Text    = Session["PaidAmt"].ToString();
                    lblChange2.Text     = Session["ChangeAmt"].ToString();
                    lblDue2.Text        = Session["DueAmt"].ToString();
                    lblTotalQty2.Text   = Session["TotalQty"].ToString();
                    decimal subtotal2   = Convert.ToDecimal(Session["totalPayable"].ToString()) - Convert.ToDecimal(Session["vatR"].ToString());
                    lblsubTotal2.Text   = subtotal2.ToString();
                    //Customer Info on POS Print Page
                    lblCustName2.Text       = Session["CustName"].ToString();
                    lblCustID2.Text         = Session["CustID"].ToString();
                    lblCustContactNo2.Text  = Session["Contact"].ToString();
                    lblServedBy2.Text       = Request.Cookies["POSCookies"]["UserID"].ToString();
                    lblInvoice2.Text        = Session["InvoiceNo"].ToString();

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
                }
                catch
                {
                }

            }
            else
            {
                Response.Redirect("~/Sales/ReturnSales_POS.aspx");
            }        

        }
       
    }

    //header part  System information
    public void SystemInfo()    
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_terminalInfo", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ShopID",  Session["ShopID"].ToString());
            cn.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);


            lblshopTitle.Text = dt.Rows[0].ItemArray[0].ToString();
            lblshopAddress.Text = dt.Rows[0].ItemArray[1].ToString();
            lblPhone.Text = dt.Rows[0].ItemArray[2].ToString();
            lblwebAddress.Text = dt.Rows[0].ItemArray[6].ToString();
           //// lblFooterMessage.Text = dt.Rows[0].ItemArray[7].ToString() + "Email: " + dt.Rows[0].ItemArray[3].ToString();    
            lblVATRegiNo.Text = dt.Rows[0].ItemArray[5].ToString();

            lblshopTitle2.Text = dt.Rows[0].ItemArray[0].ToString();
            lblshopAddress2.Text = dt.Rows[0].ItemArray[1].ToString();
            lblPhone2.Text = dt.Rows[0].ItemArray[2].ToString();
            lblwebAddress2.Text = dt.Rows[0].ItemArray[6].ToString();
           ///// lblFooterMessage2.Text = dt.Rows[0].ItemArray[8].ToString() + "<br/>  Email: " + dt.Rows[0].ItemArray[3].ToString();
            lblVATRegiNo2.Text = dt.Rows[0].ItemArray[5].ToString();
            cn.Close();
        }
        catch
        {
        }
    }
     
}