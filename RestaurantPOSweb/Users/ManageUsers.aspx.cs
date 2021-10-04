using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class User_Adduser : System.Web.UI.Page
{
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UserListDataBind();
            ShopLocationDDLDataBind();
           // imgUserPhoto.ImageUrl = AsyncFileUpload1.FileName;   
            
        }

    }

    public void ShopLocationDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_ShoplocationDDL", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            ddllocation.DataSource = dt;
            ddllocation.DataTextField = "Location";
            ddllocation.DataValueField = "TerminalID";
            ddllocation.DataBind();
            cn.Close();

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }


    public void UserListDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Users", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
           
            grdUserList.DataSource = cmd.ExecuteReader();
            grdUserList.EmptyDataText =  "No Records Found";
            grdUserList.DataBind();
            cn.Close();
            lbtotalRow.Text = "Total : " + Convert.ToString(grdUserList.Rows.Count) + " Users" + "<br />";
             
        }
        catch
        {
            lbtotalRow.Text = "No Records Found";
        }
    }


    //Load Data detail and Edit Part
    public void LoadDetailsData(string ID)
    { 

        SqlConnection cn = new SqlConnection(ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_POS_DataBind_UsersDetails", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cn.Open();
        cmd.Parameters.AddWithValue("@ID", ID);

        SqlDataReader sdr = cmd.ExecuteReader();
        DataTable dt = new DataTable();
        dt.Load(sdr); 
     

        //Edit Part //////////////////
        txtuserid.Text  = dt.Rows[0].ItemArray[7].ToString();
        lblIDView.Text  = dt.Rows[0].ItemArray[0].ToString();
        txtFName.Text   = dt.Rows[0].ItemArray[1].ToString();
        txtLName.Text   = dt.Rows[0].ItemArray[2].ToString();
        txtDesignation.Text     = dt.Rows[0].ItemArray[10].ToString();        
        txtContact.Text         = dt.Rows[0].ItemArray[3].ToString();
        txtAddress.Text         = dt.Rows[0].ItemArray[5].ToString();
        txtPassword.Text        = dt.Rows[0].ItemArray[8].ToString();

        txtEmail.Text           = dt.Rows[0].ItemArray[4].ToString();
        string DOB              = dt.Rows[0].ItemArray[12].ToString();
        txtDOB.Text             = DOB.Substring(0, 11);
        ddllocation.SelectedValue = dt.Rows[0].ItemArray[18].ToString();
        txtSupervisor.Text      = dt.Rows[0].ItemArray[6].ToString();
        cn.Close();
    }


    public void PageDataBind(string UserID)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_PageDatabind", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserName", UserID);
            cn.Open();

            grdviewUserPageAccess.DataSource = cmd.ExecuteReader();
            grdviewUserPageAccess.EmptyDataText = "No Records Found";
            grdviewUserPageAccess.DataBind();
            cn.Close();
           // lbtotalRow.Text = "Total : " + Convert.ToString(grdUserList.Rows.Count) + " Records found" + "<br />";
        }
        catch
        {
            //lbtotalRow.Text = "No Records Found";
        }
    }

    


    // ////// Open Edit popup window 
    protected void LinkEdit_Click(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;
       

        //Call Function
        LoadDetailsData(gvrow.Cells[1].Text);
       
        this.MpeEditShow.Show();
    }

    // ////// Open User privilege popup window
    protected void LinkUserRole_Click(object sender, EventArgs e)
    {
        LinkButton Linkdetails = sender as LinkButton;
        GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;
        
        lblURUserID.Text =  gvrow.Cells[1].Text;
        lblUserName.Text =  gvrow.Cells[2].Text;

        PageDataBind(gvrow.Cells[2].Text);

         // Select the checkboxes from the GridView control
        for (int i = 0; i < grdviewUserPageAccess.Rows.Count; i++)
        {
            if (grdviewUserPageAccess.Rows[i].Cells[3].Text == "Allow")
            {
                GridViewRow row = grdviewUserPageAccess.Rows[i];
                bool isChecked = ((CheckBox)row.FindControl("chkAllow")).Checked;
               ((CheckBox)row.FindControl("chkAllow")).Checked = true ;
            }
        }        
        this.MPEUserRole.Show();
    }


  

    //Update user info
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            
            SqlCommand cmd = new SqlCommand("SP_POS_Update_User", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id",          lblIDView.Text);
            cmd.Parameters.AddWithValue("@Fname",       txtFName.Text);
            cmd.Parameters.AddWithValue("@LName",       txtLName.Text);
            cmd.Parameters.AddWithValue("@UserPhone",   txtContact.Text );
            cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text  );
            cmd.Parameters.AddWithValue("@Supervisor",  txtSupervisor.Text);
            cmd.Parameters.AddWithValue("@UserAddress", txtAddress.Text );
            cmd.Parameters.AddWithValue("@Lastupdateby", Request.Cookies["POSCookies"]["UserID"].ToString());
            cmd.Parameters.AddWithValue("@Password",    txtPassword.Text);       

            cmd.Parameters.AddWithValue("@DOB",         txtDOB.Text);
            cmd.Parameters.AddWithValue("@ShopID",      ddllocation.SelectedValue);
            cmd.Parameters.AddWithValue("@Email",       txtEmail.Text);
            
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            this.MpeEditShow.Show();
            lblmsg.Visible = true;
            lblmsg.Text = "Successfully Updated";           
            UserListDataBind();          
        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
            this.MpeEditShow.Show();
        }
 
    }

    // Set user page Privilege
    protected void btnUserRoleSave_click(object sender, EventArgs e)
    {
        try
        {             
             // Select the checkboxes from the GridView control
            for (int i = 0; i < grdviewUserPageAccess.Rows.Count; i++)
            {
                GridViewRow row = grdviewUserPageAccess.Rows[i];
                bool isChecked = ((CheckBox)row.FindControl("chkAllow")).Checked;              

                if (isChecked)
                {
                    SqlConnection cn = new SqlConnection(ConnectionString);
                    
                    SqlCommand cmd = new SqlCommand("SP_POS_UserRole_UpdateAccess", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserName", lblUserName.Text);
                    cmd.Parameters.AddWithValue("@PageID", grdviewUserPageAccess.Rows[i].Cells[1].Text);
                    cmd.Parameters.AddWithValue("@status", 1);             
                    
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    cn.Close();                    
                 }

                else
                {
                    SqlConnection cn = new SqlConnection(ConnectionString);
                    
                    SqlCommand cmd = new SqlCommand("SP_POS_UserRole_UpdateAccess", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserName", lblUserName.Text);
                    cmd.Parameters.AddWithValue("@PageID", grdviewUserPageAccess.Rows[i].Cells[1].Text);
                    cmd.Parameters.AddWithValue("@status", 0);
                    
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    cn.Close();
                    
                } 
                    
                     
            }
            PageDataBind(lblUserName.Text);

            // Select the checkboxes from the GridView control
            for (int i = 0; i < grdviewUserPageAccess.Rows.Count; i++)
            {
                if (grdviewUserPageAccess.Rows[i].Cells[3].Text == "Allow")
                {
                    GridViewRow row = grdviewUserPageAccess.Rows[i];
                    bool isChecked = ((CheckBox)row.FindControl("chkAllow")).Checked;
                    ((CheckBox)row.FindControl("chkAllow")).Checked = true;
                }
            }
            this.MPEUserRole.Show();

        }
        catch// (Exception ex)
        {
          
        }
    }
    
    
}