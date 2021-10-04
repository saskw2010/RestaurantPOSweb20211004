using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

using System.Net;
using System.Net.Mail; 
using System.Threading.Tasks;
 

public partial class password_resets : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EmailBindUpdate();
           // Response.Write(Request.Url.Authority);

        }
    }

    public void EmailBindUpdate()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_DataBind_emailsetupUpdate", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);

            Session["smtp"] = dt.Rows[0].ItemArray[1].ToString();
            Session["portno"] = dt.Rows[0].ItemArray[2].ToString();
            Session["dispalyname"] = dt.Rows[0].ItemArray[3].ToString();
            Session["emailuser"] = dt.Rows[0].ItemArray[4].ToString();
            Session["password"] = dt.Rows[0].ItemArray[5].ToString();
            Session["contactus"] = dt.Rows[0].ItemArray[6].ToString();
            Session["enable"] = dt.Rows[0].ItemArray[7].ToString();
            cn.Close();
        }
        catch
        {
        }
    }

    protected void btnSetpassword_Click(object sender, EventArgs e)
    {
        try
        {
            string emailaddress = txtEmailaddr.Text;
            SqlConnection con = new SqlConnection(ConnectionString);
            string com = " Select  id,  username, password from tbl_customers " +
                        " where username = '" + emailaddress + "' AND  [status] = 1 ";
            SqlDataAdapter adpt = new SqlDataAdapter(com, ConnectionString);
            DataTable dt = new DataTable();

            adpt.Fill(dt);
            con.Open();
            if (dt.Rows.Count > 0)
            {
                string accountno = dt.Rows[0].ItemArray[0].ToString();
                string username = dt.Rows[0].ItemArray[1].ToString();
                string passowrd = dt.Rows[0].ItemArray[2].ToString();

               
                lblalert.Visible = true;
                lblalert.Text = "Your password have been emailed to you. Please check your email.";
                if (Session["enable"].ToString() == "Yes")
                { emailbody(username, passowrd); }
            }
            else
            {
                lblalert.Visible = true;
                lblalert.Text = "No user was found with that email address !";
            }
 
            con.Close();
        }
        catch (Exception ex)
        {
            lblalert.Visible = true;
            lblalert.Text = "Somethings bad! " + ex.Message;
        }
    }

    public void emailbody(string username ,  string password)
    {
        string domain = Request.Url.Authority;// Page.Request.Url.Host;
        string useremail = txtEmailaddr.Text.Trim(); 
        string subject = Session["dispalyname"].ToString() + " - Retrieve password";
        string body = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>"
        + "<title>DynamicSoft (Computer generated mail)</title>"
        + "</head>"
        + "<body  style='background-color:#efeeef; width:970'>"
        + "<div style='width:100%;' > "
        + "<table width='100%' border='0'  cellpadding='0' cellspacing='0' style='padding:70px;'>"
        + "<tr>"
        + "<td  align='center' bgcolor='#ffffff' style='padding:30px;'>"
        + "<table width='100%' border='0' cellspacing='0' cellpadding='0' style='margin-top:10px;'> "
        + "<tr>"
        + "<td align='left' valign='top' style='font-family:Arial, Helvetica, sans-serif; font-size:14px; color:#525252;'><div>"
        + "<h2 style='color:#1052a1'>  Password Request </h2> "
        + " A request to retrieve your password has been made. <br/><br/>" 
        + " Username: " + username + "<br/>"
        + " Password: " + password + "<br/><br/>"
        + " <a href='http://"+ domain +"/public/Login.aspx'><b> Login </b></a> <br/><br/>"
        + "<b>DynamicSoft team</b><br/><br/> "
        + "</div></td></tr></table></td></tr><br/></table></div>"
        + "</body></html>";
        SendEmail(useremail, subject, body);
    }
       
    //Email Authentication
    private bool SendEmail(string recipient,   string subject, string body)
    {
        MailMessage mm = new MailMessage();
        mm.From = new MailAddress(Session["emailuser"].ToString(), Session["dispalyname"].ToString());
        mm.To.Add(new MailAddress(recipient));
        mm.Subject = subject;
        mm.Body = body; 
        mm.IsBodyHtml = true;
        SmtpClient smtp = new SmtpClient();
        smtp.Host = Session["smtp"].ToString(); //   //"smtp.1and1.com; //
        smtp.EnableSsl = true;
        NetworkCredential NetworkCred = new NetworkCredential();
        NetworkCred.UserName = Session["emailuser"].ToString();  //"noreply@citkar.com";
        NetworkCred.Password = Session["password"].ToString();
        smtp.UseDefaultCredentials = true;
        smtp.Credentials = NetworkCred;
        smtp.Port = Convert.ToInt32(Session["portno"].ToString()); // 587;
        smtp.Send(mm);
        return true;
    }
}