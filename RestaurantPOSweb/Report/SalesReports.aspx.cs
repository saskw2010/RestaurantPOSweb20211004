using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report_SalesReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnTodaySales_Click((object) sender, (EventArgs) e);
        }

    }
    protected void txtDateTo_TextChanged(object sender, EventArgs e)
    {
        string DateFrom = txtDateFrom.Text;
        string DateTo = txtDateTo.Text;

        ObjectDataSourceSalesReport.SelectParameters["Date1"].DefaultValue = DateFrom;
        ObjectDataSourceSalesReport.SelectParameters["Date2"].DefaultValue = DateTo;
        ObjectDataSourceSalesReport.DataBind();
        this.ReportViewer1.LocalReport.Refresh();
    }
    protected void txtDateFrom_TextChanged(object sender, EventArgs e)
    {
        string DateFrom = txtDateFrom.Text;
        string DateTo =   txtDateTo.Text;

        ObjectDataSourceSalesReport.SelectParameters["Date1"].DefaultValue = DateFrom;
        ObjectDataSourceSalesReport.SelectParameters["Date2"].DefaultValue = DateTo;
        ObjectDataSourceSalesReport.DataBind();
        this.ReportViewer1.LocalReport.Refresh();
    }

    protected void btnTodaySales_Click(object sender, EventArgs e)
    {
        string datefrom = DateTime.Now.ToString("yyyy-MM-dd");
        string dateto = DateTime.Now.ToString("yyyy-MM-dd");

        ObjectDataSourceSalesReport.SelectParameters["Date1"].DefaultValue = datefrom;
        ObjectDataSourceSalesReport.SelectParameters["Date2"].DefaultValue = dateto;
        ObjectDataSourceSalesReport.DataBind();
        this.ReportViewer1.LocalReport.Refresh();
       

    }
    protected void txtShopID_TextChanged(object sender, EventArgs e)
    {
        ObjectDataSourceSalesReport.SelectParameters["ShopId"].DefaultValue = txtShopID.Text;
        ObjectDataSourceSalesReport.DataBind();
        this.ReportViewer1.LocalReport.Refresh();
    }
}