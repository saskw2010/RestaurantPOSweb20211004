using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customeradmin_Orders : System.Web.UI.Page
{
    String ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                OrderListDataBind();
            }
        }
        catch
        {
            // Response.Redirect("~/public");
        }

    }

    // ///////  Item list Databind
    public void OrderListDataBind()
    {
        try
        {
            grdItemList.PageSize =   Convert.ToInt32(ddlpagesize.SelectedValue);
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_orders_Customer", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@accountno", Request.Cookies["RPOSTKCookies"]["accountno"].ToString());

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            grdItemList.DataSource = ds;
            grdItemList.EmptyDataText = "No Records Found";
            grdItemList.DataBind();
            con.Close();

        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    public void Orderdetails(string orderid)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_orderdetails", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@orderid", orderid);

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dtable = new DataTable();
            dtable.Load(sdr);

            grddetails.EmptyDataText = "No Records Found";
            grddetails.DataSource = cmd.ExecuteReader();
            grddetails.DataBind();
 

        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    public void Customerdetails(string orderid)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_CustomerDetails", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@orderid", orderid);

            SqlDataReader sdr = cmd.ExecuteReader();
           // DataTable dtable = new DataTable();
            //dtable.Load(sdr);
            sdr.Read();

            lblcontactpersion.Text  = sdr["CustName"].ToString();
            lbladdress1.Text    = sdr["CustAddress"].ToString();
         //   lbladdress2.Text    = sdr["address2"].ToString();
          //  lblcity.Text        = sdr["city"].ToString();
       //     lblcounrty.Text     = sdr["country"].ToString();
          //  lblpostalcode.Text  = sdr["postalcode"].ToString();
            lblphone.Text       = sdr["CustPhone"].ToString();
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    // //////// Search item by ID , Code , 
    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        try
        {

            grdItemList.PageSize = Convert.ToInt32(ddlpagesize.SelectedValue);
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_orders_Customer_search", con);           
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@value", txtsearch.Text);
            cmd.Parameters.AddWithValue("@accountno", Request.Cookies["RPOSTKCookies"]["accountno"].ToString());
            con.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);

            grdItemList.DataSource = ds;
            grdItemList.EmptyDataText = "No Records Found";
            grdItemList.DataBind();
            con.Close();

        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }


    // //// Redirect to Order invoice  
    protected void linkViewInvoice_Click(object sender, EventArgs e)
    {
        //lblmsg.Text ="";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblid.Text = gvrow.Cells[1].Text;
        Session["discount"]     = gvrow.Cells[4].Text;
        Session["vatamount"]    = gvrow.Cells[5].Text;
        Session["total"]        = gvrow.Cells[6].Text; 

        Customerdetails(gvrow.Cells[1].Text);
        Orderdetails(gvrow.Cells[1].Text);
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("$('#detailsmodal').modal('show');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
    }

    double total = 0;
    double Qty = 0;
    protected void grddetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            total += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Price"));
            Qty += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Qty"));
             
            e.Row.Cells[1].Width = 280;
            e.Row.Cells[3].Font.Bold = true;
            e.Row.Cells[1].Font.Bold = true;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label pricetotal = (Label)e.Row.FindControl("pricetotal");
           
            //lblsubTotal.Text = total.ToString();
           // lblTotalQty.Text = Qty.ToString();

            //	Apply_Amt Total Calculation
           
            e.Row.Cells[3].Text = total.ToString("");
            string Applyat = total.ToString("c");
            int Applyati = Applyat.IndexOf('$');
            string Applyatd = Applyat.Substring(Applyati + 1);

            //grandtotal before shipping cost
            decimal grandtotal = (Convert.ToDecimal(Applyatd) - Convert.ToDecimal(Session["discount"].ToString())) + Convert.ToDecimal(Session["vatamount"].ToString());
            decimal shippingcost =  Convert.ToDecimal(Session["total"].ToString()) - grandtotal;
            e.Row.Cells[3].Text = Applyatd + "<br/>" + Session["discount"].ToString() + "<br/>" + Session["vatamount"].ToString() + "<br/>" + shippingcost + "<br/>" + Session["total"].ToString();
            e.Row.Cells[3].Font.Bold = true;

            e.Row.Cells[1].HorizontalAlign =   HorizontalAlign.Right;
            e.Row.Cells[1].Text = "Sub Total: <br/>Discount:<br/>Vat:<br/>Shipping cost:<br/>Total:";
        }
    }


    protected void grdItemList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdItemList.PageIndex = e.NewPageIndex;
        OrderListDataBind();
    }
   
    protected void ddlpagesize_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtsearch.Text = string.Empty;
        OrderListDataBind();
    }
}