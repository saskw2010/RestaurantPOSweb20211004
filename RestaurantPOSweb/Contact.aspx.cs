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

public partial class Contact : Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            EmailBindUpdate();

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
            Session["portno"]  = dt.Rows[0].ItemArray[2].ToString();
            Session["dispalyname"]   = dt.Rows[0].ItemArray[3].ToString();
            Session["emailuser"]   = dt.Rows[0].ItemArray[4].ToString();
            Session["password"]    = dt.Rows[0].ItemArray[5].ToString();
            Session["contactus"]  = dt.Rows[0].ItemArray[6].ToString();
            Session["enable"] = dt.Rows[0].ItemArray[7].ToString();
            cn.Close();
        }
        catch
        {
        }
    }

    protected void btnsend_Click(object sender, EventArgs e)
    {
        try
        {
            lblalert.Visible = true;
            lblalert.Text = "Email has been sent.";
            if (Session["enable"].ToString() == "Yes")
            { emailbody(Session["contactus"].ToString(), txtemail.Text.Trim()); } // recipient - email - company receive email
                                 

            txtname.Text = string.Empty;
            txtcompanyname.Text = string.Empty;
            txtemail.Text = string.Empty;
            txtphoneno.Text = string.Empty;
            txtmsgbody.Text = string.Empty;
        }
        catch (Exception ex)
        {
            lblalert.Visible = true;
            lblalert.Text = "Somethings bad! " + ex.Message;
        }
    }

    public void emailbody(string recipient, string senderemail)
    {
        string subject =  Session["dispalyname"].ToString() + " - Customer Care";
        string body = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>"
        + "<title>DynamicSoft (Computer generated mail)</title>"
        + "</head>"
        + "<body  style='width:970'>"
        + "<div style='width:100%;' > "
        + "<table width='100%' border='0'  cellpadding='0' cellspacing='0' style='padding:5px;'>"
        + "<tr>"
        + "<td  align='left'>"
        + "<table width='100%'> "
        + "<tr>"
        + "<td align='left' valign='top' style='font-family:Arial, Helvetica, sans-serif; font-size:14px; color:#525252;'><div>"
        + " Name: " + txtname.Text.Trim() + "<br/>"
        + " Company name: " + txtcompanyname.Text.Trim() + "<br/>"
        + " Email: " + txtemail.Text.Trim() + "<br/>"
        + " Phone Number: " + txtphoneno.Text.Trim() + "<br/><br/>"
        +   txtmsgbody.Text.Trim() + "<br/>"
        + "</div></td></tr></table></td></tr><br/></table></div>"
        + "</body></html>";
        SendEmail(recipient, senderemail, subject, body);
    }

    //Email Authentication
    private bool SendEmail(string recipient, string senderemail, string subject, string body)
    { 
        MailMessage mm = new MailMessage();
        mm.From = new MailAddress(Session["emailuser"].ToString(), Session["dispalyname"].ToString());
        mm.To.Add(new MailAddress(recipient));
        mm.Subject = subject;
        mm.Body = body;
        mm.ReplyToList.Add(senderemail);
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