using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class _Default : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Request.Cookies["POSCookies"] != null)
            {
                //For Multiple values in single cookie
                string cookiesValues;
                cookiesValues = Request.Cookies["POSCookies"]["UserID"];

                TaskListDataBind(Request.Cookies["POSCookies"]["UserID"].ToString());
                 TopSoldItems();
            }
            else
            {
                Response.Redirect("~/Login.aspx", true);
            }
        }

    }

    [WebMethod]
    public static List<SalesChartSummary> GetChartData()
    {
        String ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
        //   SqlConnection cn = new SqlConnection(ConnectionString);
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(" SELECT  top 8 CONVERT(VARCHAR(30),[Logtime],105) as [Year]  ,SUM([totalpayable]) as [Total] FROM tbl_SalesPayment " +
                                            " group by CONVERT(VARCHAR(30),[Logtime],105)  ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            con.Close();
            	
			
        }
        List<SalesChartSummary> dataList = new List<SalesChartSummary>();
        foreach (DataRow dtrow in dt.Rows)
        {
            SalesChartSummary details = new SalesChartSummary();
            details.Year = dtrow[0].ToString();
            details.Total = Convert.ToDouble(dtrow[1]);
            // details.Total11 = dtrow[2].ToString();           
            dataList.Add(details);
        }
        return dataList;
    }

    public class SalesChartSummary
    {
        public string Year { get; set; }
        public double Total { get; set; }
        // public string Total11 { get; set; }        
    } 

    public void TaskListDataBind(string UserID)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_TaskList", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@userID", UserID);

            grdViewTasklist.DataSource = cmd.ExecuteReader();
            grdViewTasklist.EmptyDataText = "No Records Found";
            grdViewTasklist.DataBind();
            cn.Close();
            // lbtotalRow.Text = "Total : " + Convert.ToString(grdViewReport.Rows.Count) + " Records found" + "<br />";
            
        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }

    public void TopSoldItems()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_TopSoldItems", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
           // cmd.Parameters.AddWithValue("@userID", UserID);

            grdviewTopSoldItems.DataSource = cmd.ExecuteReader();
            grdviewTopSoldItems.EmptyDataText = "No Records Found";
            grdviewTopSoldItems.DataBind();
            cn.Close();
            // lbtotalRow.Text = "Total : " + Convert.ToString(grdViewReport.Rows.Count) + " Records found" + "<br />";

        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }
}