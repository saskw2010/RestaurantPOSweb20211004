using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class LogStat : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LogDataBind();
        }

    }

    // ///////  Item list Databind
    public void LogDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_LogStat", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            grdviewLogstat.DataSource = cmd.ExecuteReader();
            grdviewLogstat.EmptyDataText = "No Records Found";
            grdviewLogstat.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdviewLogstat.Rows.Count) + " Records found" + "<br />";

        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }
}