using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Tableview : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loaddatabind();
        }
    }

    public void loaddatabind()
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_Tablelist");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure; 
            con.Open();

            dtlistTableview.DataSource = cmd.ExecuteReader();
            dtlistTableview.DataBind();
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
}