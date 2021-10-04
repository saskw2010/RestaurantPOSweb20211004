using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Items_AddIngredient : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString; 
    protected void Page_Load(object sender, EventArgs e)
    { 
        try
        {
            if (!IsPostBack)
            {
                ListDataBind();
                VendorsDDLDataBind();
            }
        }
        catch
        {
        }
    }

    public void VendorsDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_VerdorsDDL", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            ddlvendor.DataSource = dt;
            ddlvendor.DataTextField = "vendors";
            ddlvendor.DataValueField = "vendors";
            ddlvendor.DataBind();
            cn.Close();

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }

   
    public void ListDataBind()
    {
        try
        { 
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_ingredients", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            grdvwList.DataSource = ds;
            grdvwList.EmptyDataText = "No Records Found";
            grdvwList.DataBind();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdvwList.Rows.Count) + " Results" + "<br />";
            con.Close();
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }


    //Add New Table Popup
    protected void btnAddnew_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        btnSave.Text = "Save";
        //  Button Linkdetails = sender as Button;
        // GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;
        VendorsDDLDataBind();

        lblID.Text = "1";
        lbllabelName.Text = "Add New ";
        txtinvname.Text = string.Empty;
        txtpurchaseprice.Text = string.Empty; 
        btnSave.Text = "Add New";
        this.MpeEditShow.Show();

    }

    //Update attribute
    protected void LinkEdit_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        btnSave.Text = "Save";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblID.Visible = true;
        lblID.Text              = gvrow.Cells[1].Text;
        txtinvname.Text         = gvrow.Cells[2].Text;
        txtweight.Text          = gvrow.Cells[3].Text;
        ddluints.SelectedValue  = gvrow.Cells[4].Text;
        txtqty.Text             = gvrow.Cells[5].Text;
        txtpurchaseprice.Text   = (Convert.ToDecimal(gvrow.Cells[7].Text) / Convert.ToDecimal(gvrow.Cells[5].Text)).ToString();
        ddlvendor.SelectedValue = gvrow.Cells[8].Text;
        lbllabelName.Text       = "Edit "; 
        this.MpeEditShow.Show();
    }

    //ADD Update 
    protected void btnSave_Click(object sender, EventArgs e) 
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd;
            if (lblID.Text == "1")
            {
                cmd = new SqlCommand("SP_RPOS_Add_ingredient", cn); 
            }
            else
            {
                cmd = new SqlCommand("SP_RPOS_Update_ingredient", cn);  
            }
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@id",          lblID.Text);
            cmd.Parameters.AddWithValue("@ingrname",    txtinvname.Text);
            cmd.Parameters.AddWithValue("@weight",      txtweight.Text);
            cmd.Parameters.AddWithValue("@unit",        ddluints.SelectedValue);
            cmd.Parameters.AddWithValue("@stockqty",    txtqty.Text);
            cmd.Parameters.AddWithValue("@purchaseprice", txtpurchaseprice.Text);
            cmd.Parameters.AddWithValue("@vendor",      ddlvendor.SelectedValue);
             
         
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Done";
           // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Succeeded')", true);
            ListDataBind(); 

        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.MpeEditShow.Show();
        }

    }

    //ban / Inactive  popup
    protected void LinkbanCustomer_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblInactiveID.Text = gvrow.Cells[1].Text;
        lblInactiveCustName.Text = gvrow.Cells[2].Text;
        this.ModalPopupInactive.Show();
    }
    
    protected void btnInactive_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_Delete_ingredient", cn);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", lblInactiveID.Text);


            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Successfully Inactivated";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Done')", true);
            ListDataBind();
        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.ModalPopupInactive.Show();
        }
    }

    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_ingredients_Search", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@value", txtsearch.Text);
            cn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            grdvwList.DataSource = ds;
            grdvwList.EmptyDataText = "No Records Found";
            grdvwList.DataBind();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdvwList.Rows.Count) + " Results" + "<br />";
            cn.Close();

        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    protected void grdvwList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdvwList.PageIndex = e.NewPageIndex;
        ListDataBind();
    }
    
    protected void grdvwList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            if (Convert.ToDecimal(e.Row.Cells[5].Text) < 10)
            {
                e.Row.BackColor = System.Drawing.Color.Red;
                e.Row.ForeColor = System.Drawing.Color.White; 

            }
            if (Convert.ToDecimal(e.Row.Cells[5].Text) > 10 && Convert.ToDecimal(e.Row.Cells[5].Text) < 25)
            {
                e.Row.BackColor = System.Drawing.Color.Yellow;
                e.Row.ForeColor = System.Drawing.Color.Green;
                // e.Row.Cells[1].Font.Bold = true;

            } 
        }
    }
}