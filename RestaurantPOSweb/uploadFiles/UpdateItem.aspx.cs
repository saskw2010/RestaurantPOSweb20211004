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

public partial class UpdateItem : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (System.Web.HttpContext.Current.Session["BarCode"] != null)
            {
                txtProductCode.Focus();
                CategoryDDLDataBind();

                txtProductCode.Text = Session["BarCode"].ToString();
                txtproductName.Text = Session["txtItemName"].ToString();
                txtItemQty.Text = Session["Qty"].ToString();
                txtpurchasePrice.Text = Session["PurchasePrice"].ToString();
                txtRetailPrice.Text = Session["RetailPrice"].ToString();
                DDLCategory.Text = Session["Category"].ToString();
                txtItemDiscRate.Text = Session["Discount"].ToString();
                imgItemPhoto.ImageUrl = "~/ItemsPhoto/" + txtProductCode.Text + ".png";
            }
            else
            {
                Response.Redirect("../ManageItems.aspx");
            }
  
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



    //Update item
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
     
        SqlConnection cn = new SqlConnection(ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_POS_Update_Item", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cn.Open();

        cmd.Parameters.AddWithValue("@ItemCode", txtProductCode.Text);
        cmd.Parameters.AddWithValue("@ItemName", txtproductName.Text);
        cmd.Parameters.AddWithValue("@ItemQty", Convert.ToDecimal(txtItemQty.Text));
        cmd.Parameters.AddWithValue("@PurchasePrice", Convert.ToDecimal(txtpurchasePrice.Text));
        cmd.Parameters.AddWithValue("@RetailPrice", Convert.ToDecimal(txtRetailPrice.Text));
        cmd.Parameters.AddWithValue("@Discount", Convert.ToDecimal(txtItemDiscRate.Text));
        cmd.Parameters.AddWithValue("@ItemCategory", DDLCategory.Text);
        cmd.Parameters.AddWithValue("@Lastupdateby", Request.Cookies["POSCookies"]["UserID"].ToString());

        if (FileUpload1.HasFile)
        {
            cmd.Parameters.AddWithValue("@Itemphoto", "ItemsPhoto/" + txtProductCode.Text + extension);
        }
        else
        {
            cmd.Parameters.AddWithValue("@Itemphoto", imgItemPhoto.ImageUrl);                    
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
        imgItemPhoto.ImageUrl = "~/ItemsPhoto/" + txtProductCode.Text + ".png";
        lblStatus.Text = "successfully updated";
       // Response.Redirect("UpdateItem.aspx");
    }
}

