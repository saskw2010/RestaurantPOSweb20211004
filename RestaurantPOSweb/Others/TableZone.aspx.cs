using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Other_TableZone : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString; 
    protected void Page_Load(object sender, EventArgs e)
    { 
        try
        {
            if (!IsPostBack)
            {
                AddressListDataBind();              
            }
        }
        catch
        {
        }
    }

   
    public void AddressListDataBind()
    {
        try
        { 
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RPOS_DataBind_Tables", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            grdvwList.DataSource = ds;
            grdvwList.EmptyDataText = "No Records Found";
            grdvwList.DataBind();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdvwList.Rows.Count) + " Records found" + "<br />";
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

        lblID.Text = "1";
        lbllabelName.Text = "Add New Table";
        txttablename.Text = string.Empty;
        txtfillcolor.Text = string.Empty; 
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
        lblID.Text = gvrow.Cells[1].Text;
        txttablename.Text = gvrow.Cells[2].Text;
        txtzone.Text = gvrow.Cells[3].Text;
        txtseatqty.Text = gvrow.Cells[4].Text;
        txtorderno.Text = gvrow.Cells[5].Text;
        txtfillcolor.Text = gvrow.Cells[6].Text;
        lbllabelName.Text = "Edit Table"; 
        this.MpeEditShow.Show();
    }

    //ADD Update Table
    protected void btnSave_Click(object sender, EventArgs e) 
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd;
            if (lblID.Text == "1")
            {
                cmd = new SqlCommand("SP_RPOS_Insert_RTable", cn);
                cmd.Parameters.AddWithValue("@fillcolor", "#" + txtfillcolor.Text); 
            }
            else
            {
                cmd = new SqlCommand("SP_RPOS_Update_RTable", cn);
                cmd.Parameters.AddWithValue("@fillcolor",  txtfillcolor.Text); 
            }
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@id", lblID.Text);
            cmd.Parameters.AddWithValue("@tablename",   txttablename.Text);
            cmd.Parameters.AddWithValue("@zonenam",     txtzone.Text);
            cmd.Parameters.AddWithValue("@seatqty",     txtseatqty.Text);
            cmd.Parameters.AddWithValue("@orderno",     txtorderno.Text);
             
         
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Done";
           // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Succeeded')", true);
            AddressListDataBind(); 

        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.MpeEditShow.Show();
        }

    }

    //ban / Inactive  
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
            SqlCommand cmd = new SqlCommand("SP_RPOS_Inactive_Table", cn);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", lblInactiveID.Text);


            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Successfully Inactivated";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Done')", true);
            AddressListDataBind();
        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.ModalPopupInactive.Show();
        }
    }

    protected void grdvwAddressList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdvwList.PageIndex = e.NewPageIndex;
        AddressListDataBind();
    } 

}