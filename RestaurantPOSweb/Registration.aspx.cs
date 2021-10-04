using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class public_Registration : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
        }        
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        { 
                string ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

                SqlConnection cn = new SqlConnection(ConnectionString);
                SqlCommand cmd = new SqlCommand("SP_RPOS_Insert_Customers", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@name",     txtname.Text);
                cmd.Parameters.AddWithValue("@phone",    txtphone.Text);
                cmd.Parameters.AddWithValue("@username", txtusernameo.Text);
                cmd.Parameters.AddWithValue("@passoword", txtPassoword.Text);
                cmd.Parameters.AddWithValue("@CustAddress", txtaddress.Text);
                cmd.Parameters.AddWithValue("@ip",       ip); 

                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();

                lblmsg.Visible = true;
                lblmsg.Text = "Done";


                //After Signup Login to Dashboard
                SqlConnection con = new SqlConnection(ConnectionString);
                string com = "   Select  * from tbl_Customer " +
                             " where CustEmail = '" + txtusernameo.Text + "' and passoword = '" + txtPassoword.Text + "'  ";
                SqlDataAdapter adpt = new SqlDataAdapter(com, ConnectionString);
                DataTable dt = new DataTable();

                adpt.Fill(dt);
                con.Open();
                if (dt.Rows.Count > 0)
                {
                    string accountno    = dt.Rows[0]["id"].ToString();
                    string userid       = dt.Rows[0]["CustEmail"].ToString();
                    string name         = dt.Rows[0]["CustName"].ToString();
                    string phone        = dt.Rows[0]["CustPhone"].ToString();
                    string CustAddress  = dt.Rows[0]["CustAddress"].ToString(); 

                    Response.Cookies["RPOSTKCookies"]["UserID"] = userid;
                    Response.Cookies["RPOSTKCookies"]["accountno"] = accountno;
                    Response.Cookies["RPOSTKCookies"]["name"] = name;
                    Response.Cookies["RPOSTKCookies"]["phone"] = phone;
                    Response.Cookies["RPOSTKCookies"]["CustAddress"] = CustAddress;  
                    Response.Cookies["RPOSTKCookies"].Expires = DateTime.Now.AddDays(9965);
 
                 
                    Response.Redirect("~/Customeradmin/Default.aspx", false);
                }
                else
                {
                    lblmsg.Text = "Invalid User ! already signup from this network \n Please use your existing account.\nMore details please contact to support.";
                }
                con.Close();             

        }
        catch //(Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Duplicate User \n Invalid User ! \n";// + ex.Message;

        }
    }
 
}