using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Order_module_Order_Invoice : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Session["invoice"] != null)
                {  
                    this.Title = "Order_Invoice_" + Session["invoice"].ToString();
                    SystemInfo();
                    ItemsListDataBind();
                    Customerinfo();
                }
                else
                {
                    Response.Redirect("~/WebOrders.aspx");
                }
            }
            catch
            {

            }
 
        }

    }

    //header part  System information
    public void SystemInfo()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RestPOS_Databind_systeminfo", cn);
            cmd.CommandType = CommandType.StoredProcedure;
          //  cmd.Parameters.AddWithValue("@InvoiceNo", Session["invoice"].ToString());
            cn.Open();


            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);


         
 

            lblshopTitle.Text = dt.Rows[0]["CompanyName"].ToString();
            lblshopAddress.Text = dt.Rows[0]["CompanyAddress"].ToString();
            lblcomphone.Text = dt.Rows[0]["Phone"].ToString();
            lblcompanyphone.Text = dt.Rows[0]["phone"].ToString();
            lblwebAddress.Text = dt.Rows[0]["WebAddress"].ToString(); 
            lbldate.Text = DateTime.Now.ToString("yyyy-MMM-dd");           
            cn.Close();
          
        }
        catch
        {
        }
    }

    // ///Customer info
    public void Customerinfo()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_CustomerInfo", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InvoiceNo", Session["invoice"].ToString());
            cn.Open();


            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);

            // CustID, CustName, CustContact,  custaddress 
            lblcustname.Text        = dt.Rows[0]["CustName"].ToString();
            lblcustaddr.Text        = dt.Rows[0]["custaddress"].ToString();
            lblcustphone.Text       = dt.Rows[0]["CustContact"].ToString();
            lblshippingcost.Text    = dt.Rows[0]["Shippingcost"].ToString();
            lblVatRate.Text         = dt.Rows[0]["vatrate"].ToString();
            lblVatAmount.Text       = dt.Rows[0]["Vat"].ToString();
            lblsubTotal.Text        = dt.Rows[0]["Subtotal"].ToString(); 
            lbltotal.Text           = dt.Rows[0]["totalpayable"].ToString();
            lbldiscountamt.Text     = dt.Rows[0]["disamt"].ToString();

            lblInvoiceNoTop.Text    = dt.Rows[0]["ID"].ToString();
            lblInvoiceNo.Text       = dt.Rows[0]["ID"].ToString();
            lblComment.Text         = dt.Rows[0]["note"].ToString();
             
            cn.Close();

        }
        catch
        {
        }
    }


    // ///////  Item list Databind
    public void ItemsListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RestPOS_DataBind_OrderItemList", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InvoiceNo", Session["invoice"].ToString());
            cn.Open();

            grdItemList.DataSource = cmd.ExecuteReader();
            grdItemList.EmptyDataText = "No Records Found";
            grdItemList.DataBind();
            cn.Close();
          //  lbtotalRow.Text = "Total : " + Convert.ToString(grdItemList.Rows.Count) + " Records found" + "<br />";

        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }
     
    // Total calculation
    decimal total = 0;
    protected void grdItemList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            total = total + Convert.ToDecimal(e.Row.Cells[5].Text); 
           // e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Right;            
          //  e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Right;
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[4].Text = "Subtotal = ";

            //  Total Calculation
            e.Row.Cells[5].Text = total.ToString("");
            string totalat = total.ToString("c");
            int totalati = totalat.IndexOf('$');
            string totalatd = totalat.Substring(totalati + 1);
            e.Row.Cells[5].Text =  totalatd + " /-";
            e.Row.Cells[4].Font.Size = 10;
            e.Row.Cells[5].Font.Size = 10;

           // e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Font.Bold = true;
            e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Right;
           // lblsubTotal.Text = totalatd;
           // lblVatAmount.Text = Session["VatAmount"].ToString();
          //  decimal totalcost = Convert.ToDecimal(totalatd) + Convert.ToDecimal(Session["VatAmount"].ToString()) + Convert.ToDecimal(lblshippingcost.Text);
            //lbltotal.Text = totalcost.ToString();
        }
    }
 
}