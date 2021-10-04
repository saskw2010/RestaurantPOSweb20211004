using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login_customer : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblLogMsg.Visible = false;
          //  exptodt();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string UserID = txtuser.Text.Trim();
        string pass = txtpass.Text.Trim();

        SqlConnection con = new SqlConnection(ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_User_Authentication_Customer", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@LOGINID", UserID);
        cmd.Parameters.AddWithValue("@PASSWORD", pass);
        con.Open();

        SqlDataReader rd = cmd.ExecuteReader();
        if (rd.HasRows)
        {
            rd.Read();
            lblLogMsg.Text = "Login successful.";

            Response.Cookies["RPOSTKCookies"]["UserID"]     = rd["CustEmail"].ToString();  
            Response.Cookies["RPOSTKCookies"]["accountno"]  = rd["id"].ToString(); 
            Response.Cookies["RPOSTKCookies"]["name"]       = rd["CustName"].ToString(); 
            Response.Cookies["RPOSTKCookies"]["phone"]      = rd["CustPhone"].ToString();
            Response.Cookies["RPOSTKCookies"]["CustAddress"] = rd["CustAddress"].ToString();  
            Response.Cookies["RPOSTKCookies"].Expires       = DateTime.Now.AddDays(9965);  
           // hitcounter();
            Response.Redirect("/Customeradmin/Orders.aspx", false);
        }
        else
        {
            lblLogMsg.Visible = true;
            lblLogMsg.Text = "We don't recognize this user ID or password.";
        }
        con.Close();
    }

    public void exptodt()
    {

        /////////////////// Exp date //////////////////Start ////////// Convert.ToInt32(InvoicesManager.Activationvalue) 
        //if (Convert.ToInt32(InvoicesManager.Activationvalue) > Convert.ToInt32(DateTime.Now.ToString("yyyyMMdd"))) // Exp date > Current date              
        //{
        //    btnSubmit.Enabled = true;

        //}
        //else
        //{
        //    btnSubmit.Enabled = false;
        //    lblLogMsg.Visible = true;
        //    lblLogMsg.Text = "Contact: tuahaca@gmail.com Trial version has been expired..";
        //    txtuser.Visible = false;
        //    txtpass.Visible = false;
        //    btnSubmit.Visible = false;
        //    Response.Cookies["VintcropTKCookies"].Expires = DateTime.Now.AddDays(-1);
        //}
        /////////////////// Exp date ////////////////// END //////////
    }

    public void hitcounter()
    {
        try
        {
            string ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

            SqlConnection cn = new SqlConnection(ConnectionString);

            SqlCommand cmd = new SqlCommand("SP_Insert_HitCounter", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@userID", txtuser.Text);
            cmd.Parameters.AddWithValue("@IPaddress", ip);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        catch
        {
        }
    }


}