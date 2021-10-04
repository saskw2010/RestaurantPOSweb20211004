using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage_Master_Ft_page : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["RPOSTKCookies"] == null)
                {
                  //  Response.Redirect("~/Login_customer.aspx");
                    LinklogOut.Text = "Login";
                    LinklogOut.PostBackUrl = "~/Login_customer.aspx";
                    lnkmyaccount.Visible = false;
                    
                }
                else
                {
                    lnklogin.Visible = false;
                    lblaccountno.Text = Request.Cookies["RPOSTKCookies"]["name"].ToString();
                 //   Response.Cookies["RPOSTKCookies"]["name"] = name;
                }
            }
        }
        catch
        {
           // Response.Redirect("~/public");
        }
    }

    protected void LinklogOut_Click(object sender, EventArgs e)
    {
        //   Session.Clear();
        ////  Response.Redirect("Login.aspx");

        if (Request.Cookies["RPOSTKCookies"] != null)
        {
            lnklogin.Visible = true;
            lnkmyaccount.Visible = false;
            Response.Cookies["RPOSTKCookies"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("/Default.aspx");  //to refresh the page
        }
    }
}
