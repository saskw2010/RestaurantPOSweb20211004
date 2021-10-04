using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Activationconfig;

public partial class SalesRegister : System.Web.UI.Page
{ 
    string ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    DataTable tableSR = new DataTable();
    String sauceoptions;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                // panelItems.CssClass = "col-lg-12";
                //  paneCartlItemsFull.Visible = false;
                txtItemSearch.Focus();
                CategoryDDLDataBind();
                CustomerNameDDLDataBind();
                VatRate();
                BindData("ALL");
                lbltableno.Text = Session["tableName"].ToString();
                lbltableno1.Text = Session["tableName"].ToString();

                if (Session["valuesr"] != null)
                {
                    panelItems.CssClass = "col-lg-7";
                    paneCartlItemsFull.Visible = true;

                    //  table = Session["valuesr"] as DataTable;
                    tableSR = (DataTable)Session["valuesr"];
                    dtlistgrid.DataSource = tableSR;
                    dtlistgrid.DataBind();

                    decimal sum = 0; decimal qty2 = 0;
                    foreach (DataRow dr in tableSR.Rows)
                    {
                        sum += Convert.ToDecimal(dr["Total"]);
                        qty2 += Convert.ToDecimal(dr["Qty"]);
                    }
                    lblsubTotal.Text = sum.ToString();

                    ////   double tex = (Convert.ToDouble(lblsubTotal.Text) * 5) / 100;
                    double tex = ((Convert.ToDouble(lblsubTotal.Text) * Convert.ToDouble(lblVatRate.Text)) / 100);
                    //// lbldisc.Text = pricetotal -
                    lblVat.Text = Math.Round(tex, 2).ToString();
                    lbltotal.Text = (Convert.ToDouble(lblsubTotal.Text) + Convert.ToDouble(lblVat.Text)).ToString();
                    lblTotalQty.Text = qty2.ToString();
                }  
            }
            catch
            {
                Response.Redirect("~/Sales/Tableview.aspx");
            }
            
        }    

    }
    
    // Vat Rate from Terminal table its vary terminal to terminal Example ON rate 13% QC Rate 14.975
    public void VatRate()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_terminalInfo", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ShopId", Request.Cookies["POSCookies"]["ShopID"].ToString());
            cn.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);
            lblVatRate.Text = dt.Rows[0].ItemArray[4].ToString();
            cn.Close();
        }
        catch
        {
        }
    }
    
    //Datalits Item List   
    protected void BindData(string category)
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_SR");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@category", category);
            con.Open();

            DataList1.DataSource = cmd.ExecuteReader();
            DataList1.DataBind();
            con.Close();
        }
        catch
        {
        }
    }
     
    // ///// Open Options Popup panel
    protected void btnPopuOptions_Goclick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        DataListItem item = (DataListItem)btn.NamingContainer;
        Label Lblpid = (Label)item.FindControl("LblID");
        Label LblCode = (Label)item.FindControl("LblCode");
        Label Lblitemname = (Label)item.FindControl("LblItemName");
        Label LblQty = (Label)item.FindControl("LblQty");
        Label LblPrice = (Label)item.FindControl("LblPrice");
        Label LblDisc = (Label)item.FindControl("LblDisc");
        Label LblTotal = (Label)item.FindControl("LblTotal");
        Label Lbloptions = (Label)item.FindControl("Lbloptions");
        Label LblDescriptions = (Label)item.FindControl("Lbldescription");
        Label Lblkditem = (Label)item.FindControl("Lblkditem");
        Image imgPhoto = (Image)item.FindControl("imgPhoto");
       // TextBox txtqty = (TextBox)item.FindControl("txtqty");
        // DropDownList txtqty = (DropDownList)item.FindControl("ddlQty"); 
      
        chkoptionslist.Items.Clear();
        var options = Lbloptions.Text;
        //if (options == null) return;
        if (options != null || options != "" || options != "NULL")
        {
            foreach (String o in options.ToString().Split(','))
            {
                chkoptionslist.Visible = true;
                chkoptionslist.Items.Add(o);
                //chkoptionslist.SelectedValue = "ONE-SIZE";
            }
        }
        else
        {
            chkoptionslist.Items.Clear();
            chkoptionslist.Visible = false;
        }


        txtqty.Text = "1";
        Session["id"] = Lblpid.Text;
        Session["Code"] = LblCode.Text;
        Session["ItemName"] = Lblitemname.Text;
        Session["kditem"] = Lblkditem.Text; // LblQty.Text;
        Session["QtyStock"] = Convert.ToDecimal(LblQty.Text);
        Session["Price"] = LblPrice.Text;
        Session["Disc"] = LblDisc.Text;
        Session["image"] = imgPhoto.ImageUrl;

        lblItemname.Text = Lblitemname.Text;
        lblitemPrice.Text = LblPrice.Text;
        lbldescriptionsPop.Text = LblDescriptions.Text;
        if (Lblkditem.Text == "3") { lblkditem.Text = "YES"; } else { lblkditem.Text = "NO"; }

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("$('#detailsmodal').modal('show');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
    }

    //Click add to cart menu
    protected void btn_Goclick(object sender, EventArgs e)
    {
        panelItems.CssClass = "col-lg-7";
        paneCartlItemsFull.Visible = true;
         
        string ID           = Session["id"].ToString();
        string Code         = Session["Code"].ToString();
        string ItemName     = Session["ItemName"].ToString();
        string Qty          = txtqty.Text; // LblQty.Text;
        decimal QtyStock    = Convert.ToDecimal(Session["QtyStock"].ToString());
        string Price        = Session["Price"].ToString();
        string Disc         = Session["Disc"].ToString();
        string kditem       = Session["kditem"].ToString(); 

        string s = string.Empty;
        string Options;
        for (int i = 0; i < chkoptionslist.Items.Count; i++)
        {
            if (chkoptionslist.Items[i].Selected)
            {
                s += chkoptionslist.Items[i].Value + ", ";
                sauceoptions = "Options:" + s.Substring(0, s.Length - 2);
            }
        }
        Options = sauceoptions;
        decimal Total = Math.Round((Convert.ToDecimal(Price) - (Convert.ToDecimal(Price) * Convert.ToDecimal(Disc) / 100)) * Convert.ToDecimal(Qty), 2);


        //Check Item Quantity less than 1 
        if (Convert.ToDecimal(Qty) <= 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Increase Item Qty')", true);
        }
        if (Convert.ToDecimal(Qty) > Convert.ToDecimal(QtyStock))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your given quantity is Greater than Stock Quantity')", true);
        }
        else
        {
            if (Session["valuesr"] != null)
            {
                tableSR = Session["valuesr"] as DataTable;
            }
            else
            {
                //Add item from item list 
                //  table = (DataTable)Session["valuesr"];
                tableSR.Columns.Add("Code", typeof(string));
                tableSR.Columns.Add("ItemName", typeof(string));
                tableSR.Columns.Add("Options", typeof(string));
                tableSR.Columns.Add("Qty", typeof(string));
                tableSR.Columns.Add("Price", typeof(string));
                tableSR.Columns.Add("Disc", typeof(string));
                tableSR.Columns.Add("Total", typeof(string));
                tableSR.Columns.Add("image", typeof(string));
                tableSR.Columns.Add("kditem", typeof(string));
                Session["valuesr"] = tableSR;
            }
            tableSR.Rows.Add(Code, ItemName, Options, Qty, Price, Disc, Total, Session["image"].ToString(), kditem);
            Session.Add("valuesr", tableSR);

            dtlistgrid.DataSource = tableSR;
            dtlistgrid.DataBind();

            decimal sum = 0; decimal qty2 = 0;
            foreach (DataRow dr in tableSR.Rows)
            {
                sum += Convert.ToDecimal(dr["Total"]);
                qty2 += Convert.ToDecimal(dr["Qty"]);
            }
            lblsubTotal.Text = sum.ToString();

            ////   double tex = (Convert.ToDouble(lblsubTotal.Text) * 5) / 100;
            double tex = ((Convert.ToDouble(lblsubTotal.Text) * Convert.ToDouble(lblVatRate.Text)) / 100);
            //// lbldisc.Text = pricetotal -
            lblVat.Text = Math.Round(tex, 2).ToString();
            lbltotal.Text = (Convert.ToDouble(lblsubTotal.Text) + Convert.ToDouble(lblVat.Text)).ToString();
            lblTotalQty.Text = qty2.ToString();
              
            txtItemSearch.Text = string.Empty;
            txtItemSearch.Focus();
        }

    }

    //Category Bind on dropdown list
    public void CategoryDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_CategoryDDL_SR", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            //DDLCategory.DataSource = dt;
            //DDLCategory.DataTextField = "ItemCategory";
            //DDLCategory.DataValueField = "ItemCategory";
            //DDLCategory.DataBind();
            //cn.Close();

            dtlistcategory.DataSource = cmd.ExecuteReader();
            dtlistcategory.DataBind();
            cn.Close();
        }
        catch
        {
            Response.Write("No Records Found");
        }
    }

    // Customer Name Data bind into dropdown list 
    public void CustomerNameDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Customers_name", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            DDLCustname.DataSource = dt;
            DDLCustname.DataTextField = "Name";
            DDLCustname.DataValueField = "Name";
            DDLCustname.DataBind();
            cn.Close();
        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }
     
    ////// Barcode scan search box  
    protected void txtItemSearch_TextChanged(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_ItemBarCodeSearch", cn);
            cmd.Parameters.AddWithValue("@ItemCode", txtItemSearch.Text);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();


            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dtable = new DataTable();
            dtable.Load(sdr);
           // cmd.ExecuteNonQuery();

            ////grdSelectedItem.DataSource = cmd.ExecuteReader();
            ////grdSelectedItem.EmptyDataText = "No Records Found";
            ////grdSelectedItem.DataBind();
 
                string Code = dtable.Rows[0].ItemArray[0].ToString();
                string ItemName = dtable.Rows[0].ItemArray[1].ToString();
                string Price = dtable.Rows[0].ItemArray[2].ToString();
                string Disc = dtable.Rows[0].ItemArray[3].ToString();
                string Total = dtable.Rows[0].ItemArray[4].ToString();
                string image = dtable.Rows[0].ItemArray[5].ToString();
                string Options = "";// dtable.Rows[0].ItemArray[6].ToString();
                string kditem   = dtable.Rows[0].ItemArray[7].ToString();

                if (Session["valuesr"] != null)
                {
                    tableSR = Session["valuesr"] as DataTable;
                }
                else
                {
                    //Add item from item list            
                    tableSR.Columns.Add("Code", typeof(string));
                    tableSR.Columns.Add("ItemName", typeof(string));
                    tableSR.Columns.Add("Options", typeof(string));
                    tableSR.Columns.Add("Qty", typeof(string));
                    tableSR.Columns.Add("Price", typeof(string));
                    tableSR.Columns.Add("Disc", typeof(string));
                    tableSR.Columns.Add("Total", typeof(string));
                    tableSR.Columns.Add("image", typeof(string));
                    tableSR.Columns.Add("kditem", typeof(string));
                    Session["valuesr"] = tableSR;
                }
                tableSR.Rows.Add(Code, ItemName, Options, "1", Price, Disc, Total, image, kditem);
                Session.Add("valuesr", tableSR);

                dtlistgrid.DataSource = tableSR;
                dtlistgrid.DataBind();
                cn.Close();

                decimal sum = 0; decimal qty2 = 0;
                foreach (DataRow dr in tableSR.Rows)
                {
                    sum += Convert.ToDecimal(dr["Total"]);
                    qty2 += Convert.ToDecimal(dr["Qty"]);
                }
                lblsubTotal.Text = sum.ToString();

                ////   double tex = (Convert.ToDouble(lblsubTotal.Text) * 5) / 100;
                double tex = ((Convert.ToDouble(lblsubTotal.Text) * Convert.ToDouble(lblVatRate.Text)) / 100);
                //// lbldisc.Text = pricetotal -
                lblVat.Text = Math.Round(tex, 2).ToString();
                lbltotal.Text = (Convert.ToDouble(lblsubTotal.Text) + Convert.ToDouble(lblVat.Text)).ToString();
                lblTotalQty.Text = qty2.ToString();

                txtItemSearch.Text = string.Empty;
                txtItemSearch.Focus();
        }
        catch
        {
            txtItemSearch.Text = string.Empty;
            txtItemSearch.Focus();
            //lbtotalRow.Text = "No Records Found";
        }    
    }

    // Clear all added items
    protected void btnsuspen_Click(object sender, EventArgs e)
    {
        Session.Remove("valuesr");
        dtlistgrid.DataSource = null;
        dtlistgrid.DataBind();
        lblsubTotal.Text = "0";
        lblVat.Text = "0";
        lbltotal.Text = "0";
        lblTotalQty.Text = "0";
        txtItemSearch.Text = string.Empty;
        txtItemSearch.Focus();
       //// panelItems.CssClass = "col-lg-12";
      //// paneCartlItemsFull.Visible = false;
    }
    
    // Delete single item from added cart
    protected void btnDeleteitem_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        DataListItem item = (DataListItem)btn.NamingContainer;

        int itemIndex = item.ItemIndex;
        tableSR = (DataTable)Session["valuesr"];
        tableSR.Rows.RemoveAt(itemIndex);

        dtlistgrid.DataSource = tableSR;
        dtlistgrid.DataBind();

        decimal sum = 0; decimal qty2 = 0;
        foreach (DataRow dr in tableSR.Rows)
        {
            sum += Convert.ToDecimal(dr["Total"]);
            qty2 += Convert.ToDecimal(dr["Qty"]);
        }
        lblsubTotal.Text = sum.ToString();

        ////   double tex = (Convert.ToDouble(lblsubTotal.Text) * 5) / 100;
        double tex = ((Convert.ToDouble(lblsubTotal.Text) * Convert.ToDouble(lblVatRate.Text)) / 100);
        //// lbldisc.Text = pricetotal -
        lblVat.Text = Math.Round(tex, 2).ToString();
        lbltotal.Text = (Convert.ToDouble(lblsubTotal.Text) + Convert.ToDouble(lblVat.Text)).ToString();
        lblTotalQty.Text = qty2.ToString();

        if (tableSR.Rows.Count == 0)
        {
            lblsubTotal.Text = "0";
            lbltotal.Text = "0";
            lblTotalQty.Text = "0";
            // lbldiscountamount.Text = "0";
            //  lbldistype.Text = "0";
        }
        else
        {
            // if (lbldistype.Text == "2") { lbldiscountamount.Text = "0"; }
            //  lbltotal.Text = (Convert.ToDecimal(lblsubTotal.Text) - Convert.ToDecimal(lbldiscountamount.Text)).ToString();
        }

        txtItemSearch.Text = string.Empty;
        txtItemSearch.Focus();
    }

    // Open Payment Popup window 
    protected void btnPayment_Click(object sender, EventArgs e)
    {
        if (lbltotal.Text == "0" || lbltotal.Text == "0.00" || lbltotal.Text == "00")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Add at least one item')", true);
          //  lbltotal.Text = "Record is empty";
        }
        else
        {
            txttokenno.Text = DateTime.Now.ToString("HH-mmss");
            lblChange.Text = "0";
            lblDue.Text = "0";
            txtdiscountamount.Text = "0";

            lbltotalpay.Text = lbltotal.Text;
       //     txtPaid.Text  = lbltotal.Text;
            txtPaid.Focus();
            this.ModalPopupPayment.Show();
        }
    }
    
    //// Paid Amount from customer   - Popup Panel
    protected void txtPaid_TextChanged(object sender, EventArgs e)
    {
        try
        {
            changeduecalculation(txtPaid.Text);
            this.ModalPopupPayment.Show();
            bntPay.Focus();
        }
        catch
        {
            txtPaid.Text = "0";
            this.ModalPopupPayment.Show();
        }
    }

    public void changeduecalculation(string paidamount)
    {
        double changeAmt = Convert.ToDouble(paidamount) - Convert.ToDouble(lbltotalpay.Text);
        lblChange.Text = changeAmt.ToString();
        if (Convert.ToDouble(lbltotalpay.Text) < Convert.ToDouble(paidamount))
        {
            lblChange.Text = Math.Round((Convert.ToDouble(paidamount) - Convert.ToDouble(lbltotalpay.Text)), 2).ToString();
            lblDue.Text = "0";
        }
        else
        {
            lblChange.Text = "0";
            lblDue.Text = Math.Round((Convert.ToDouble(lbltotalpay.Text) - Convert.ToDouble(paidamount)), 2).ToString();
        }
    }

    // Discount amount calculation
    protected void txtdiscountamount_TextChanged(object sender, EventArgs e)
    {
        try
        {
            double discountAmt = Convert.ToDouble(lbltotal.Text) - Convert.ToDouble(txtdiscountamount.Text);
            lbltotalpay.Text = discountAmt.ToString(); //after discount
            txtPaid.Text = discountAmt.ToString();

            this.ModalPopupPayment.Show();
            bntPay.Focus();
        }
        catch
        {
            txtdiscountamount.Text = "0";
            this.ModalPopupPayment.Show();
        }

    }
   
    //Inset Multiple Row in single trXID  - Function method
    protected void SaveSaleItem()
    {
        try
        {
            tableSR = (DataTable)Session["valuesr"];
            for (int i = 0; i < tableSR.Rows.Count; i++)
            {
                string Code     = tableSR.Rows[i].ItemArray[0].ToString();
                string ItemName = tableSR.Rows[i].ItemArray[1].ToString();
                string Options  = tableSR.Rows[i].ItemArray[2].ToString();
                string Qty      = tableSR.Rows[i].ItemArray[3].ToString();
                string Price    = tableSR.Rows[i].ItemArray[4].ToString();
                string Disc     = tableSR.Rows[i].ItemArray[5].ToString();
                string Total    = tableSR.Rows[i].ItemArray[6].ToString();
                string kditem   = tableSR.Rows[i].ItemArray[8].ToString(); 

                SqlConnection cn = new SqlConnection(ConnectionString);
                SqlCommand cmd = new SqlCommand("SP_POS_Insert_SalesItems", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open(); 
                cmd.Parameters.AddWithValue("@Code",        Code);
                cmd.Parameters.AddWithValue("@ItemName",    ItemName);
                cmd.Parameters.AddWithValue("@Options",     Options);
                cmd.Parameters.AddWithValue("@Qty",         Qty);
                cmd.Parameters.AddWithValue("@Price",       Price);
                cmd.Parameters.AddWithValue("@Disc",        Disc);
                cmd.Parameters.AddWithValue("@Total",       Total);
                cmd.Parameters.AddWithValue("@kditem",      kditem);

                cmd.Parameters.Add("@InvoiceNoOutPut", SqlDbType.Int).Direction = ParameterDirection.Output;             
                cmd.ExecuteNonQuery();
                cn.Close();

                Session["InvoiceNoOutPut"] = cmd.Parameters["@InvoiceNoOutPut"].Value.ToString();                
             } 
           
        }
        catch //(Exception ex)
        {
           // Response.Write(ex.Message);
            // lbtotalRow.Text = "No Records Found";
        }
    }
    
    //Insert One Row sales payment info every one trXID
    protected void SaveSalePaymentInfo()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Insert_SRsalesPayment", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            cmd.Parameters.AddWithValue("@SalesQty",    lblTotalQty.Text);
            cmd.Parameters.AddWithValue("@Subtotal",    lblsubTotal.Text);
            cmd.Parameters.AddWithValue("@Vat",         lblVat.Text);
            cmd.Parameters.AddWithValue("@totalpayable",lbltotalpay.Text);
            cmd.Parameters.AddWithValue("@payType",     DDLPaidBy.Text);
            cmd.Parameters.AddWithValue("@paidAmount",  txtPaid.Text);
            cmd.Parameters.AddWithValue("@changeAmount", lblChange.Text);
            cmd.Parameters.AddWithValue("@dueAmount",   lblDue.Text);            
            cmd.Parameters.AddWithValue("@note",        txtNote.Text);

            cmd.Parameters.AddWithValue("@ShopId",      Request.Cookies["POSCookies"]["ShopID"].ToString());
            cmd.Parameters.AddWithValue("@CustID",      lblCustID.Text);
            cmd.Parameters.AddWithValue("@CustName",    DDLCustname.Text);
            cmd.Parameters.AddWithValue("@CustContact", lblCustContact.Text);
            cmd.Parameters.AddWithValue("@Custaddress", lblcustaddress.Text);
            cmd.Parameters.AddWithValue("@ServedBy",    Request.Cookies["POSCookies"]["UserID"].ToString());
            cmd.Parameters.AddWithValue("@vatrate",     lblVatRate.Text);
            cmd.Parameters.AddWithValue("@disamt",      txtdiscountamount.Text);
            cmd.Parameters.AddWithValue("@ordertime",   DateTime.Now.ToString("HH:mm"));
            cmd.Parameters.AddWithValue("@tableno",     lbltableno.Text);
            cmd.Parameters.AddWithValue("@tokenno",     txttokenno.Text);
            cmd.ExecuteNonQuery();
            cn.Close(); 
        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }
    
    //END Point - Sales Completed and Move to ----------------- >>>>>>>>>>> Print Page
    protected void bntPay_click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(InvoicesManager.Activationvalue) <  Convert.ToInt32(DateTime.Now.ToString("yyyyMMdd"))) // Ep date > Crnt date     
        {  
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Successfully Place order')", true);                
        }
        else
        {
            SaveSaleItem();
            SaveSalePaymentInfo();

            Session["Subtotal"] = lblsubTotal.Text;
            Session["totalPayable"] = lbltotalpay.Text;
            Session["vat"] = lblVat.Text;
            Session["vatRate"] = lblVatRate.Text;
            Session["discountamount"] = txtdiscountamount.Text;
            Session["PaidBy"] = DDLPaidBy.Text;
            Session["PaidAmt"] = txtPaid.Text;
            Session["ChangeAmt"] = lblChange.Text;
            Session["DueAmt"] = lblDue.Text;
            Session["Note"] = txtNote.Text;

            Session["CustName"] = DDLCustname.Text;
            Session["CustID"] = lblCustID.Text;
            Session["Contact"] = lblCustContact.Text;
            Session["TotalQty"] = lblTotalQty.Text;
            Session["InvoiceNo"] = Session["InvoiceNoOutPut"].ToString();
            Session["servedby"] = Request.Cookies["POSCookies"]["UserID"].ToString();
            Session["ShopID"] = Request.Cookies["POSCookies"]["ShopID"].ToString();

            Session["ordertime"] = DateTime.Now.ToString("HH:mm");
            Session["tokenno"] = txttokenno.Text;
            Session["tableno"] = lbltableno.Text;

            DataTable POSprinttable = new DataTable();

            POSprinttable.Columns.Add("Code", typeof(string));
            POSprinttable.Columns.Add("Items", typeof(string));
            POSprinttable.Columns.Add("Options", typeof(string));
            POSprinttable.Columns.Add("Qty", typeof(string));
            POSprinttable.Columns.Add("Price", typeof(string));
            POSprinttable.Columns.Add("Disc", typeof(string));
            POSprinttable.Columns.Add("Total", typeof(string));
            POSprinttable.Columns.Add("kditem", typeof(string));

            // Select the all row  from the GridView control
            for (int i = 0; i < tableSR.Rows.Count; i++)
            {
                string Code = tableSR.Rows[i].ItemArray[0].ToString();
                string ItemName = tableSR.Rows[i].ItemArray[1].ToString();
                string Options = tableSR.Rows[i].ItemArray[2].ToString();
                string Qty = tableSR.Rows[i].ItemArray[3].ToString();
                string Price = tableSR.Rows[i].ItemArray[4].ToString();
                string Disc = tableSR.Rows[i].ItemArray[5].ToString();
                string Total = tableSR.Rows[i].ItemArray[6].ToString();
                string kditem = tableSR.Rows[i].ItemArray[8].ToString();
                POSprinttable.Rows.Add(Code, ItemName, Options, Qty, Price, Disc, Total, kditem);
            }
            POSprinttable.AcceptChanges();
            Session.Add("Stable", POSprinttable);
            Session.Remove("valuesr");
            Response.Redirect("~/Sales/POS_printPage.aspx");
        }

    }
    
    //Get customer information from customer table 
    protected void DDLCustname_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_CustomersEvent", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.AddWithValue("@CustName",    DDLCustname.Text);

            
            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);

            lblCustID.Text  =   dt.Rows[0].ItemArray[0].ToString();
            lblCustContact.Text = dt.Rows[0].ItemArray[1].ToString();
            lblcustaddress.Text = dt.Rows[0].ItemArray[2].ToString();
            cn.Close();

            this.ModalPopupPayment.Show();
            bntPay.Focus();
        }
        catch
        {
            lblCustContact.Text = "";
            lblCustID.Text = "";             
        }
    }
    
    //Items filter by category  | Categoy list from store items Table
    protected void lnkCategory_Onclick(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = sender as LinkButton;
            DataListItem item = (DataListItem)btn.NamingContainer;
            Label lblcategid = (Label)item.FindControl("lblcategid");
            BindData(lblcategid.Text);
            txtItemSearch.Text = string.Empty;
            txtItemSearch.Focus();
        }
        catch
        {
        }
    }

    #region Currency shotcut button
    
    private void NumaricKeypad(string Numvalue)
    {

        try
        {
            txtPaid.Text += Numvalue;
            changeduecalculation(txtPaid.Text);
            this.ModalPopupPayment.Show();
            txtPaid.Focus();
        }
        catch
        {

        }
    }
 

    protected void btnnum1_Click(object sender, EventArgs e)
    {
        NumaricKeypad("1");
    }

    protected void btnnum2_Click(object sender, EventArgs e)
    {
        NumaricKeypad("2");
    }

    protected void btnnum3_Click(object sender, EventArgs e)
    {
        NumaricKeypad("3");
    }
    protected void btnnum4_Click(object sender, EventArgs e)
    {
        NumaricKeypad("4");
    }
    protected void btnnum5_Click(object sender, EventArgs e)
    {
        NumaricKeypad("5");
    }
    protected void btnnum6_Click(object sender, EventArgs e)
    {
        NumaricKeypad("6");
    }
    protected void btnnum7_Click(object sender, EventArgs e)
    {
        NumaricKeypad("7");
    }
    protected void btnnum8_Click(object sender, EventArgs e)
    {
        NumaricKeypad("8");
    }
    protected void btnnum9_Click(object sender, EventArgs e)
    {
        NumaricKeypad("9");
    }
    protected void btndot_Click(object sender, EventArgs e)
    {
        NumaricKeypad(".");
    }
    protected void btnZero_Click(object sender, EventArgs e)
    {
        NumaricKeypad("0");
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtPaid.Text = "";
        this.ModalPopupPayment.Show();
    }

    #endregion

    ////////////////////////////////// Plesae Rate Us  ***** http://codecanyon.net/downloads ///
}