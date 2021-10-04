using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Data.OleDb;

public partial class Items_UploadItems : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;      
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }


    

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileUpload1.HasFile == false)
            {
                lblmessage.Text = "Please Select .CSV file";
            }
            else
            {
                string csvPath = Server.MapPath("~/CSVFile/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
                FileUpload1.SaveAs(csvPath);
                DataTable dtt = ConvertCSVtoDataTable(csvPath);

                for (int i = 0; i < dtt.Rows.Count; i++)
                {
                    SqlConnection cn = new SqlConnection(ConnectionString);
                    SqlCommand cmd = new SqlCommand("SP_POS_Insert_Items", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cn.Open();

                    cmd.Parameters.AddWithValue("@ItemCode",        dtt.Rows[i].ItemArray[0].ToString());
                    cmd.Parameters.AddWithValue("@ItemName",        dtt.Rows[i].ItemArray[1].ToString());
                    cmd.Parameters.AddWithValue("@PurchasePrice",   dtt.Rows[i].ItemArray[2].ToString());
                    cmd.Parameters.AddWithValue("@RetailPrice",     dtt.Rows[i].ItemArray[3].ToString());
                    cmd.Parameters.AddWithValue("@ItemCategory",    dtt.Rows[i].ItemArray[4].ToString());
                    cmd.Parameters.AddWithValue("@Discount",        dtt.Rows[i].ItemArray[5].ToString());                     
                    cmd.Parameters.AddWithValue("@ItemQty",         dtt.Rows[i].ItemArray[6].ToString());
                    cmd.Parameters.AddWithValue("@kditem",          dtt.Rows[i].ItemArray[7].ToString()); 
                    cmd.Parameters.AddWithValue("@description",     dtt.Rows[i].ItemArray[8].ToString());
                    cmd.Parameters.AddWithValue("@options",         dtt.Rows[i].ItemArray[9].ToString());
                    cmd.Parameters.AddWithValue("@mdate",           dtt.Rows[i].ItemArray[10].ToString());
                    cmd.Parameters.AddWithValue("@edate",           dtt.Rows[i].ItemArray[11].ToString());
                    cmd.Parameters.AddWithValue("@LogBy",           Request.Cookies["InventMgtCookies"]["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@Itemphoto",       "~/ItemsPhoto/item.png");


                    cmd.ExecuteNonQuery();
                    cn.Close();
                    lblmessage.Text = "Successfully Saved";
                }
            }         
        }
        catch (Exception ex)
        {
            lblmessage.Text = "Already uploaded <br/>"+ ex.Message;
        }
    }


    public static DataTable ConvertCSVtoDataTable(string strFilePath)
    {
        StreamReader sr = new StreamReader(strFilePath);
        string[] headers = sr.ReadLine().Split(',');
        DataTable dt = new DataTable();
        foreach (string header in headers)
        {
            dt.Columns.Add(header);
        }
        while (!sr.EndOfStream)
        {
            string[] rows = System.Text.RegularExpressions.Regex.Split(sr.ReadLine(), ",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
            DataRow dr = dt.NewRow();
            for (int i = 0; i < headers.Length; i++)
            {
                dr[i] = rows[i];
            }
            dt.Rows.Add(dr);
        }
        return dt;
    } 


 
}