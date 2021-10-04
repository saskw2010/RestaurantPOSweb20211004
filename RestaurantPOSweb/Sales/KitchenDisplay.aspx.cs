using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_KitchenDisplay : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShopLocationDDLDataBind();
            loaddatabind(ddllocation.SelectedValue);
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        loaddatabind(ddllocation.SelectedValue);
    }

    public void ShopLocationDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_ShoplocationDDL", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            ddllocation.DataSource = dt;
            ddllocation.DataTextField = "Location";
            ddllocation.DataValueField = "TerminalID";
            ddllocation.SelectedValue = Request.Cookies["POSCookies"]["ShopID"].ToString();
            ddllocation.DataBind();
            cn.Close();

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }

    public void loaddatabind(string shopid)
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_KitchenDisplay");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ShopId", shopid);
            con.Open();

            dtlistview.DataSource = cmd.ExecuteReader();
            dtlistview.DataBind();  
            con.Close();
        }
        catch
        {
        }
    }

    protected void imgmoveclick_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton btn = (ImageButton)sender;
        DataListItem item = (DataListItem)btn.NamingContainer;
        Label LbltableName = (Label)item.FindControl("LbltableName");

        Session["tableName"] = LbltableName.Text;
        Response.Redirect("~/Sales/SalesRegister.aspx");
    }
    protected void dtlistview_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item  || e.Item.ItemType == ListItemType.AlternatingItem)
        {          
            Label lblinvoiceno = (Label)e.Item.FindControl("lblinvoiceno"); 

            DataRowView drv = e.Item.DataItem as DataRowView;
            DataList dtlistkditems = e.Item.FindControl("dtlistkditems") as DataList; 

            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_KitchenDisplayItems");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SP_ID",  lblinvoiceno.Text); 
            con.Open();

            dtlistkditems.DataSource = cmd.ExecuteReader();
            dtlistkditems.DataBind();
            con.Close();

        }
    }

    protected void btnorderReady_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        DataListItem item = (DataListItem)btn.NamingContainer;
        Label lblinvoiceno = (Label)item.FindControl("lblinvoiceno");

        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Update_KitchenDisplay_Ready", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@invoiceno", lblinvoiceno.Text); 

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
             
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Order has been served')", true);
           // loaddatabind(Request.Cookies["POSCookies"]["ShopID"].ToString());
        }
        catch //(Exception ex)
        {
            
        }

    }
    protected void ddllocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            loaddatabind(ddllocation.SelectedValue);
        }
        catch
        {
        }
    }
}