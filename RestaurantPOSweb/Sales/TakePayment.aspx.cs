using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Sales_TakePayment : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["invoiceno"] != null)
            {
                lblInvoiceNo.Text = Session["invoiceno"].ToString();
                ItemsListDataBind();
                InvoiceInfo();
                paymentListDataBind();
                txtPaid.Focus();
            }
        }
    }

    // ///////  Item list Databind
    public void ItemsListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("[SP_POS_DataBind_OrderItemList]", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InvoiceNO", Session["invoiceno"].ToString());
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

    // ///////  Invoice Info
    public void InvoiceInfo()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("[SP_POS_DataBind_SalesPamentDetails]", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@InvoiceNo", Session["invoiceno"].ToString());

            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.HasRows)
            {
                rd.Read();                 
                lblvat.Text = rd["Vat"].ToString();
              //  lbldis.Text = rd["discount"].ToString();
                lbltotal.Text = rd["totalpayable"].ToString();             
                lblDue.Text = rd["dueAmount"].ToString();
            }
            cn.Close();
        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }

    // ///////  Payment  list Databind
    public void paymentListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_SalesPaymentlist", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InvoiceNo", Session["invoiceno"].ToString());
            cn.Open();

            grdpaymentlist.DataSource = cmd.ExecuteReader();
            grdpaymentlist.EmptyDataText = "No Records Found";
            grdpaymentlist.DataBind();
            cn.Close();
            //  lbtotalRow.Text = "Total : " + Convert.ToString(grdItemList.Rows.Count) + " Records found" + "<br />";

        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }


    // list column width
    protected void grdItemList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Width = 20;
            e.Row.Cells[2].Width = 10;
        }
    }
    protected void btnReceivedPayment_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToDecimal(lblDue.Text) < Convert.ToDecimal(txtPaid.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Exceed Paid amount please pay due amount')", true);
                txtPaid.Text = lblDue.Text;
            }
            else
            {
                SqlConnection cn = new SqlConnection(ConnectionString);
                SqlCommand cmd = new SqlCommand("SP_POS_Insert_ReceiveDuePayment", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();

                cmd.Parameters.AddWithValue("@spid",        lblInvoiceNo.Text);
                cmd.Parameters.AddWithValue("@payType",     DDLPaidBy.Text);
                cmd.Parameters.AddWithValue("@paidAmount",  txtPaid.Text);               
                cmd.Parameters.AddWithValue("@date",        txtDate.Text);
                cmd.Parameters.AddWithValue("@trxtype",     "sales_Due");
                cmd.Parameters.AddWithValue("@dueAmount",   lblDue.Text);
                cmd.Parameters.AddWithValue("@ServedBy",    Request.Cookies["POSCookies"]["UserID"].ToString());

                cmd.ExecuteNonQuery();
                cn.Close();
                InvoiceInfo();
                txtPaid.Text = string.Empty;
                txtPaid.Text = string.Empty;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Due received')", true);
                paymentListDataBind();
               // btnReceivedPayment.Enabled = false;
            }

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }
}