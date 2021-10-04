using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class ProfilePage : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDetailsData(Request.Cookies["POSCookies"]["UserID"].ToString());
           txtFname.Focus();
        }
    }

    public void LoadDetailsData(string UserID)
    {

        SqlConnection cn = new SqlConnection(ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_POS_DataBind_UsersProfileDetails", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cn.Open();
        cmd.Parameters.AddWithValue("@UserID", UserID);

        SqlDataReader sdr = cmd.ExecuteReader();
        DataTable dt = new DataTable();
        dt.Load(sdr);

        txtFname.Text =  dt.Rows[0].ItemArray[1].ToString();
        txtLName.Text = dt.Rows[0].ItemArray[2].ToString();
        txtPhone.Text  = dt.Rows[0].ItemArray[3].ToString();
        txtEmailaddr.Text  = dt.Rows[0].ItemArray[4].ToString();
        txtSupervisor.Text = dt.Rows[0].ItemArray[6].ToString();
        cn.Close();       

    }

    // /// Update user Profile | Change password
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string Result;
            SqlConnection cn = new SqlConnection(ConnectionString);           
            SqlCommand cmd = new SqlCommand("SP_POS_Update_UserProfile", cn);
            

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID",          Request.Cookies["POSCookies"]["UserID"].ToString());
            cmd.Parameters.AddWithValue("@Fname",           txtFname.Text);
            cmd.Parameters.AddWithValue("@LName",           txtLName.Text);
            cmd.Parameters.AddWithValue("@UserPhone",       txtPhone.Text);        
            cmd.Parameters.AddWithValue("@Lastupdateby",    "admin");
            cmd.Parameters.AddWithValue("@Password",        txtPassword.Text);
            cmd.Parameters.AddWithValue("@OldPassword",     txtOldPassword.Text);

            cmd.Parameters.Add("@ResultOutPut", SqlDbType.Int).Direction = ParameterDirection.Output;
            
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            Result = cmd.Parameters["@ResultOutPut"].Value.ToString();
            if (Result != "1")
            {
                lblmsg.Visible = true;
                lblmsg.Text = "!!! Current Password is incorrect";
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Successfully Updated";
            }        

        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;           
        }

    }
   
}