using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class Sales_module_Sales_history : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ItemsListDataBind();
            txtsearch.Focus();
            // lblmsg.Visible = false;
            
        }

    }

    // ///////  Item list Databind
    public void ItemsListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_SalesList", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            grdItemList.DataSource = cmd.ExecuteReader();
            grdItemList.EmptyDataText = "No Records Found";
            grdItemList.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdItemList.Rows.Count) + " Records found" + "<br />";

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
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Saleslist_search", cn);
            cmd.Parameters.AddWithValue("@value", txtsearch.Text);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            grdItemList.DataSource = cmd.ExecuteReader();
            grdItemList.EmptyDataText = "No Records Found";
            grdItemList.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdItemList.Rows.Count) + " Records found" + "<br />";
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }
    
        // //// Redirect to Take payment page  
    protected void linktakepayment_Click(object sender, EventArgs e)
    {
        //lblmsg.Text ="";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        Session["invoiceno"] = gvrow.Cells[2].Text;         
        Response.Redirect("~/Sales/TakePayment.aspx");
    }

    
    //AutoComplete  AutoCompleteExtender  ////////////////////////////////////////////   AutoCompleteExtender
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetMDN(string prefixText)
    {

        string constr = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ToString();
        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT TOP 8 * from    tbl_SalesPayment " +
          " where   (CustName like '%' + @value + '%' and dueAmount > 0 )  or ( ID like '%' + @value + '%'  and dueAmount > 0) ", con);
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

    protected void grdItemList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // e.Row.Cells[0].Width = 10;
            e.Row.Cells[1].Width = 10;
        }
    }
}