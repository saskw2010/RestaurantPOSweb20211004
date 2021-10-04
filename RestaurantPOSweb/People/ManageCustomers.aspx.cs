using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ManageCustomers : System.Web.UI.Page
{    
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CustomersListDataBind();
        }

    }
    public void CustomersListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Customers", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
           
            grdVcustomersList.DataSource = cmd.ExecuteReader();
            grdVcustomersList.EmptyDataText =  "No Records Found";
            grdVcustomersList.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdVcustomersList.Rows.Count) + " Records found" + "<br />";
             
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }

    protected void LinkEdit_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        btnSave.Text = "Save";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblID.Text = gvrow.Cells[1].Text;
        txtCustName.Text = gvrow.Cells[2].Text;
        txtContact.Text = gvrow.Cells[3].Text;
        txtEmail.Text = gvrow.Cells[4].Text;
        txtaddress.Text = gvrow.Cells[5].Text;
        txtCustType.Text = gvrow.Cells[6].Text;
        txtDiscount.Text = gvrow.Cells[7].Text;
        if (gvrow.Cells[8].Text == "Inactive")
        {
            btnSave.Text = "Save & Active";
        }
        this.MpeEditShow.Show();
    }

    protected void LinkbanCustomer_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        lblInactiveID.Text = gvrow.Cells[1].Text;
        lblInactiveCustName.Text = gvrow.Cells[2].Text;

        this.ModalPopupInactive.Show();
    }

    protected void btnSave_Click(object sender, EventArgs e) //Update Customer
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Update_Customer", cn);
            cmd.CommandType = CommandType.StoredProcedure; 
            
            cmd.Parameters.AddWithValue("@id",lblID.Text );
            cmd.Parameters.AddWithValue("@CustName",        txtCustName.Text);
            cmd.Parameters.AddWithValue("@CustPhone",       txtContact.Text);
            cmd.Parameters.AddWithValue("@CustEmail",       txtEmail.Text);
            cmd.Parameters.AddWithValue("@CustAddress",     txtaddress.Text);
            cmd.Parameters.AddWithValue("@CustType",        txtCustType.Text);
            cmd.Parameters.AddWithValue("@DiscountRate",    txtDiscount.Text);
            cmd.Parameters.AddWithValue("@passoword",       txtPassoword.Text);
            cmd.Parameters.AddWithValue("@Lastupdateby",    Request.Cookies["POSCookies"]["UserID"].ToString());
            
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Successfully Updated";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Successfully Updated')", true);
            CustomersListDataBind();
        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.MpeEditShow.Show();
        }

    }


    protected void btnInactive_Click(object sender, EventArgs e) 
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Inactive_Customer", cn);
            
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", lblInactiveID.Text);
            cmd.Parameters.AddWithValue("@Lastupdateby", Request.Cookies["POSCookies"]["UserID"].ToString());
            
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

            lblmsg.Visible = true;
            lblmsg.Text = "Successfully Inactivated";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Successfully Inactivated')", true);
            CustomersListDataBind();
        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.MpeEditShow.Show();
        }
    }
}