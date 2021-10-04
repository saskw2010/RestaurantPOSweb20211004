using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.UI.DataVisualization.Charting;

public partial class ChartReport : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["POSCookies"] != null)
            {
                string cookiesValues = Request.Cookies["POSCookies"]["UserID"];

                //Default last 30 days data load
               ChartSalesReportDataLOAD(txtDateFrom.Text, txtDateTo.Text, 1);
               ChartProfitReportDataLOAD(txtDateFrom.Text, txtDateTo.Text, 1);
                 
            }
            else
            {
                Response.Redirect("~/Login.aspx", true);
            }

        }

    }

    protected void ChartSalesReportDataLOAD(string Date1, string Date2, int ReportType)
    {
        SqlConnection ConnectionString = new SqlConnection(ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ToString());
        ConnectionString.Open();
        SqlCommand cmd = new SqlCommand("SP_Load_ChartSales_ValueXY", ConnectionString);       
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Date1", Date1);
        cmd.Parameters.AddWithValue("@Date2", Date2);
        cmd.Parameters.AddWithValue("@ReportType", ReportType);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds_Post = new DataSet();
        da.Fill(ds_Post);
        ConnectionString.Close();
        if (ds_Post.Tables[0].Rows.Count > 0)
        {

            DataView dv = ds_Post.Tables[0].DefaultView;
            ChartSalesReport.Series["Default"].Points.DataBindXY(dv, "DATE", dv, "Total");
            // Chart1.ChartAreas[0].AxisY2.LabelStyle.Angle = -70;
            ChartSalesReport.ChartAreas[0].AxisX.LabelStyle.Angle = -40;
        }
        else
        {

        }
    }

    protected void ChartProfitReportDataLOAD(string Date1, string Date2, int ReportType)
    {
        SqlConnection ConnectionString = new SqlConnection(ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ToString());
        ConnectionString.Open();
        SqlCommand cmd = new SqlCommand("[SP_Load_ChartProfit_ValueXY]", ConnectionString);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Date1", Date1);
        cmd.Parameters.AddWithValue("@Date2", Date2);
        cmd.Parameters.AddWithValue("@ReportType", ReportType);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds_Post = new DataSet();
        da.Fill(ds_Post);
        ConnectionString.Close();
        if (ds_Post.Tables[0].Rows.Count > 0)
        {

            DataView dv = ds_Post.Tables[0].DefaultView;
            ChartProfitReport.Series["Sales"].Points.DataBindXY(dv, "DATE", dv,     "Total");
            ChartProfitReport.Series["Profit"].Points.DataBindXY(dv, "DATE", dv,    "Profit");
            ChartProfitReport.ChartAreas[0].AxisY2.LabelStyle.Angle = -70;
            ChartProfitReport.ChartAreas[0].AxisX.LabelStyle.Angle = -40;
        }
        else
        {

        }
    }

   


    protected void txtDateTo_TextChanged(object sender, EventArgs e)
    {
        ChartSalesReportDataLOAD(txtDateFrom.Text,  txtDateTo.Text,2);
        ChartProfitReportDataLOAD(txtDateFrom.Text, txtDateTo.Text , 2);
    }
    protected void txtDateFrom_TextChanged(object sender, EventArgs e)
    {
        ChartSalesReportDataLOAD(txtDateFrom.Text, txtDateTo.Text,2);
        ChartProfitReportDataLOAD(txtDateFrom.Text, txtDateTo.Text, 2);
    }
    protected void btnMonthlySales_Click(object sender, EventArgs e)
    {
        ChartSalesReportDataLOAD(txtDateFrom.Text, txtDateTo.Text, 1);
        ChartProfitReportDataLOAD(txtDateFrom.Text, txtDateTo.Text, 1);
        
    }
}