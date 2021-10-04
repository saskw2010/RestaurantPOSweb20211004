using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
//using Directory.se;

public partial class _Default : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtProductCode.Focus();
            CategoryDDLDataBind();
        }
    }

    public void CategoryDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_CategoryDDL", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            DDLCategory.DataSource = dt;
            DDLCategory.DataTextField = "ItemCategory";
            DDLCategory.DataValueField = "ItemCategory";
            DDLCategory.DataBind();
            cn.Close();

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (FileUpload1.FileName == string.Empty)
        {
            lblmessage.Text = "Error | Please select item image ";
        }
        else
        {
            string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);

            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Insert_Items", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
          
            if (FileUpload1.HasFile)
            {
                cmd.Parameters.AddWithValue("@ItemCode", txtProductCode.Text);
                cmd.Parameters.AddWithValue("@ItemName", txtproductName.Text);
                cmd.Parameters.AddWithValue("@PurchasePrice", txtpurchasePrice.Text);
                cmd.Parameters.AddWithValue("@RetailPrice", txtRetailPrice.Text);
                cmd.Parameters.AddWithValue("@ItemQty", txtItemQty.Text);
                cmd.Parameters.AddWithValue("@ItemCategory", DDLCategory.Text);
                cmd.Parameters.AddWithValue("@Discount", txtItemDiscRate.Text);
                cmd.Parameters.AddWithValue("@LogBy", Request.Cookies["POSCookies"]["UserID"].ToString());
                cmd.Parameters.AddWithValue("@Itemphoto", "ItemsPhoto/" + txtProductCode.Text + extension);
            }


            cmd.ExecuteNonQuery();
            cn.Close();
 
            if (FileUpload1.HasFile)
            {
                if (extension == ".png")
                {
                    string strPath = MapPath("../ItemsPhoto/") + txtProductCode.Text + extension;
                    FileUpload1.SaveAs(strPath);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Only .Png Format can be support')", true);
                }

            }

            lblmessage.Text = "Successfully Saved";
            Response.Redirect("../ManageItems.aspx");

        }

    }
}

