using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ResetDatabase : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {         
            
            
        }       
    }

    public void resetdatabase()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Truncate_transaction", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open(); 
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Text = "Sales and Return transaction has been removed";

        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }
    protected void btnresetdatabase_Click(object sender, EventArgs e)
    {
        resetdatabase();
    }
}