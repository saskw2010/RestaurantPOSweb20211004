using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Barcode_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (System.Web.HttpContext.Current.Session["Barcode"] != null)
            {
                barcodeValue.Text = Session["Barcode"].ToString();
                lblItemName.Text = Session["ItemName"].ToString();
                lblRetailsPrice.Text = Session["RetailsPrice"].ToString();
            }
            else
            {
                barcodeValue.Text = "";
                lblItemName.Text = "";
                lblRetailsPrice.Text = "";
            }

        }

    }
}