using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Addressbooks_Address : System.Web.UI.Page
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
            grdvwAddressList.PageSize = Convert.ToInt32(ddlpagesize.SelectedValue);
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_DataBind_address", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@accountno", Request.Cookies["RPOSTKCookies"]["accountno"].ToString()); 

            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            grdvwAddressList.DataSource = ds;
            grdvwAddressList.EmptyDataText = "No Records Found";
            grdvwAddressList.DataBind();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdvwAddressList.Rows.Count) + " Records found" + "<br />";
            con.Close();
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    public void addressdetails(string id)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_DataBind_Details_address", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@value", id);

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dtable = new DataTable();
            dtable.Load(sdr);

            txtCountry.Text         = dtable.Rows[0]["country"].ToString();
            txtaddress1FROM.Text    = dtable.Rows[0]["address1"].ToString();
            txtaddress2FROM.Text    = dtable.Rows[0]["address2"].ToString();
            txtpostalcode.Text      = dtable.Rows[0]["postalcode"].ToString();
            txtcityFROM.Text        = dtable.Rows[0]["city"].ToString();
            txtphoneFROM.Text       = dtable.Rows[0]["phone"].ToString();
            txtemailFROM.Text       = dtable.Rows[0]["email"].ToString();
            txtattentionFROM.Text   = dtable.Rows[0]["contactname"].ToString();
        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }

    //Add New Address Popup
    protected void btnAddnew_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        btnSave.Text = "Save";
        //  Button Linkdetails = sender as Button;
        // GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblID.Text = "1";
        lbllabelName.Text = "Add New Address";
        txtattentionFROM.Text = string.Empty;
        txtcityFROM.Text = string.Empty;
        txtphoneFROM.Text = string.Empty;       
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
        addressdetails(gvrow.Cells[1].Text);
        lbllabelName.Text = "Edit Address"; 
        this.MpeEditShow.Show();
    }

    //ADD Update Address
    protected void btnSave_Click(object sender, EventArgs e) 
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd;
            if (lblID.Text == "1")
            {
                cmd = new SqlCommand("SP_Add_address", cn);
            }
            else
            {
                cmd = new SqlCommand("SP_Update_address", cn);                
            }

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@id", lblID.Text);
            cmd.Parameters.AddWithValue("@address1",    txtaddress1FROM.Text);
            cmd.Parameters.AddWithValue("@address2",    txtaddress2FROM.Text);
            cmd.Parameters.AddWithValue("@city",        txtcityFROM.Text);
            cmd.Parameters.AddWithValue("@country",     txtCountry.Text);          
            cmd.Parameters.AddWithValue("@postalcode",  txtpostalcode.Text);
            cmd.Parameters.AddWithValue("@phone",       txtphoneFROM.Text);
            cmd.Parameters.AddWithValue("@email",       txtemailFROM.Text);
            cmd.Parameters.AddWithValue("@contactname", txtattentionFROM.Text);
            cmd.Parameters.AddWithValue("@accountno",   Request.Cookies["RPOSTKCookies"]["accountno"].ToString()); 
        

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Done";
           // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Succeeded')", true);
            AddressListDataBind();
            //this.MpeEditShow.Show();

        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.MpeEditShow.Show();
        }

    }

    //ban / Inactive address
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
            SqlCommand cmd = new SqlCommand("SP_Inactive_address", cn);

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
        grdvwAddressList.PageIndex = e.NewPageIndex;
        AddressListDataBind();
    }

    protected void ddlpagesize_SelectedIndexChanged(object sender, EventArgs e)
    {
        //txtsearch.Text = string.Empty;
        AddressListDataBind();
    }  
    
    // Details View
    protected void Linkdtview_Click(object sender, EventArgs e)
    {
        //lblmsg.Text = "";
        //LinkButton Linkdetails = sender as LinkButton;
        //GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        //lblcustid.Text = gvrow.Cells[1].Text;
        //lblcusname.Text = gvrow.Cells[2].Text;
        //lblcname.Text = gvrow.Cells[2].Text;
        //lblEmail.Text = gvrow.Cells[4].Text;
        //lblphone.Text = gvrow.Cells[3].Text;
        //DataBindcustomersales(lblcustid.Text);

        //System.Text.StringBuilder sb = new System.Text.StringBuilder();
        //sb.Append(@"<script type='text/javascript'>");
        //sb.Append("$('#myModal').modal('show');");
        //sb.Append(@"</script>");
        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
        //// this.MpedtviewShow.Show();
    }

    // ///////     Details sales to customer  transactions databind 
    public void DataBindcustomersales(string custid)
    {
        //try
        //{
        //    SqlConnection cn = new SqlConnection(ConnectionString);
        //    SqlCommand cmd = new SqlCommand("SP_INV_DataBind_SoldListToCustomer", cn);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@custid", custid);
        //    cn.Open();

        //    grdviewSoldhistory.DataSource = cmd.ExecuteReader();
        //    grdviewSoldhistory.EmptyDataText = "No Records Found";
        //    grdviewSoldhistory.DataBind();
        //    cn.Close();
        //    // lbtotalRow.Text = "Total : " + Convert.ToString(grdItemList.Rows.Count) + " Records found" + "<br />";

        //}
        //catch
        //{
        //    //lbtotalRow.Text = "No Records Found";
        //}
    }

}