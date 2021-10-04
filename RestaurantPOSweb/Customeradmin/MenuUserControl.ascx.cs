using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MenuUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                //if (Request.Cookies["RPOSTKCookies"] == null)
                //{
                //    Response.Redirect("~/Login_customer.aspx");
                //}
                //else
                //{
                //}
            }
        }
        catch
        {
            // Response.Redirect("~/public");
        }

    }
}