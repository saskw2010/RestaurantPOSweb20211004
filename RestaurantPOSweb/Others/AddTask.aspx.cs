using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class AddTask : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UserID_DDLDataBind();
        }
    }

    // User ID  Data bind into dropdown list 
    public void UserID_DDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_UserID", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            DDSentto.DataSource = dt;
            DDSentto.DataTextField = "UserID";
            DDSentto.DataValueField = "UserID";
            DDSentto.DataBind();
            cn.Close();
        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Insert_Task", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            cmd.Parameters.AddWithValue("@task_title",          txtTaskTitle.Text);            
            cmd.Parameters.AddWithValue("@task_Description",    txtTaskDescription.Text);
            cmd.Parameters.AddWithValue("@taskfrom",            Request.Cookies["POSCookies"]["UserID"].ToString());
            cmd.Parameters.AddWithValue("@taskto",              DDSentto.Text);
           
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmessage.Text = "Successfully Send";

           // txtTaskTitle.Text = string.Empty;
           // txtTaskDescription.Text = string.Empty;
            //DDSentto.Text = string.Empty; 
          
        }
        catch (Exception ex)
        {
            lblmessage.Text = ex.Message;
        }
    }
}