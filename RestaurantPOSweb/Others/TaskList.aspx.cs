using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class TaskList : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {         
            if (Request.Cookies["POSCookies"] != null)
            {               

                TaskListDataBind(Request.Cookies["POSCookies"]["UserID"].ToString());
            }
            else
            {
                Response.Redirect("~/Login.aspx", true);
            }
            
        }       
    }

    public void TaskListDataBind(string UserID)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_TaskList", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@userID", UserID);

            grdViewTasklist.DataSource = cmd.ExecuteReader();
            grdViewTasklist.EmptyDataText = "No Records Found";
            grdViewTasklist.DataBind();
            cn.Close();
           // lbtotalRow.Text = "Total : " + Convert.ToString(grdViewReport.Rows.Count) + " Records found" + "<br />";

        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }
}