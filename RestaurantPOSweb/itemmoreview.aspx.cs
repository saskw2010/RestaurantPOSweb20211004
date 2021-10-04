using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using System.Text;

public partial class itemmoreview : System.Web.UI.Page
{
    String ConnectionString = ConfigurationManager.ConnectionStrings["PointofSaleConstr"].ConnectionString;
    DataTable tablePub = new DataTable();
    String sauceoptions;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                VatRate();
                pnlCartPanel.Visible = false;
                categoryeDDLDataBind();              
                loadItemList();
                txtSearch.Focus();

                if (Session["value"] != null)
                {
                    pnlCartPanel.Visible = true;
                    Panelallitemlist.CssClass = "col-md-7";
                    tablePub = (DataTable)Session["value"];
                    dtlistcartitems.DataSource = tablePub;
                    dtlistcartitems.DataBind();

                    decimal sum = 0; decimal qty2 = 0;
                    foreach (DataRow dr in tablePub.Rows)
                    {
                        sum += Convert.ToDecimal(dr["Total"]);
                        qty2 += Convert.ToDecimal(dr["Qty"]);
                    }
                    lblsubTotal.Text = sum.ToString();
                    decimal totalcost = sum + Convert.ToDecimal(lblshippingcost.Text);
                    lbltotal.Text = totalcost.ToString();
                    lblTotalQty.Text = qty2.ToString();
                }
                txtcustomername.Text = Request.Cookies["RPOSTKCookies"]["name"].ToString();
                txtphone.Text = Request.Cookies["RPOSTKCookies"]["phone"].ToString();
                txtAddress.Text = Request.Cookies["RPOSTKCookies"]["CustAddress"].ToString();
                lblcustomerid.Text = Request.Cookies["RPOSTKCookies"]["accountno"].ToString(); 

            }
            catch
            {

            }

        }
    }

    // Vat Rate from Terminal table its vary terminal to terminal Example ON rate 13% QC Rate 14.975
    public void VatRate()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_RestPOS_Databind_systeminfo", cn);
            cmd.CommandType = CommandType.StoredProcedure;
           // cmd.Parameters.AddWithValue("@InvoiceNo", "2");
            cn.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(sdr);
            lblVatRate.Text         = dt.Rows[0]["VatRate"].ToString();
            lblshippingcost.Text    = dt.Rows[0]["shippingcost"].ToString(); 
            cn.Close();
        }
        catch
        {
        }
    }
    

    // // Category Button Databind
    public void categoryeDDLDataBind()
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_CategoryDDL_public", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();

            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adpt.Fill(dt);


            dtlistcategory.DataSource = cmd.ExecuteReader();
            dtlistcategory.DataBind();
            cn.Close();

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }

    // Filter by category used same SP item_SR
    protected void lnkCategory_Onclick(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = sender as LinkButton;
            DataListItem item = (DataListItem)btn.NamingContainer;
            Label lblcategid = (Label)item.FindControl("lblcategid");
            LinkButton lblcategory = (LinkButton)item.FindControl("lnkCategory");

            txtSearch.Text = lblcategid.Text;
            // Categoryfilter(lblcategid.Text);

            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_SR", con);
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@category", lblcategid.Text); 

            dtlistgrid.Visible = true;
            dtlistgrid.DataSource = cmd.ExecuteReader();
            dtlistgrid.DataBind();
            con.Close();

        }
        catch
        {
        }

    }
    
    //Datalist  Item List
    protected void loadItemList()
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_public");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            dtlistgrid.DataSource = cmd.ExecuteReader();
            dtlistgrid.DataBind();
            con.Close();
        }
        catch
        {
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_DataBind_Item_public_search");
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@value", txtSearch.Text);

            //dtlistgrid.Visible = false;  
            //dtlisthoristyle.Visible = true;
            //dtlisthoristyle.DataSource = cmd.ExecuteReader();
            //dtlisthoristyle.DataBind(); 

            dtlistgrid.DataSource = cmd.ExecuteReader();
            dtlistgrid.DataBind();
            con.Close();
            txtSearch.Focus();
        }
        catch
        {
            // DTusers.Visible = true;
        }
    }

    // ///// Open Options Popup panel
    protected void btnPopuOptions_Goclick(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        DataListItem item = (DataListItem)btn.NamingContainer;
        Label Lblid = (Label)item.FindControl("LblID");
        Label Lblcode = (Label)item.FindControl("LblCode");
        Label Lblitemname = (Label)item.FindControl("lblitemname");
        Label LblQty = (Label)item.FindControl("LblQty");
        Label LblPrice = (Label)item.FindControl("LblPriceOnsale");
        Label LblDisc = (Label)item.FindControl("LblDisc");
        Label LblTotal = (Label)item.FindControl("LblTotal");
        Label Lbloptions = (Label)item.FindControl("Lbloptions");
        Label LblDescriptions = (Label)item.FindControl("lblDescriptions");
        Label Lblkditem = (Label)item.FindControl("Lblkditem");
        Image imgPhoto = (Image)item.FindControl("imgPhoto");

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


        //Session["Code"] = Lblpid.Text;
        //Session["ItemName"] = Lblitemname.Text ;
        //lblItemname.Text = Lblitemname.Text;
        //Session["kditem"] = Lblkditem.Text; // LblQty.Text;
        //Session["QtyStock"] = Convert.ToDecimal(LblQty.Text);
        //Session["Price"]  = LblPrice.Text;
        //Session["Disc"]  = LblDisc.Text;
        //Session["image"] = imgPhoto.ImageUrl; 

        //lblitemPrice.Text = LblPrice.Text;
        //lbldescriptionsPop.Text  = LblDescriptions.Text;       
        //chkoptionslist.SelectedIndex = -1;

        txtqty.Text = "1";
        Session["id"] = Lblid.Text;
        Session["Code"] = Lblcode.Text;
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
        this.ModalPopupOptions.Show();

        ////  Session.Add("value", table);
        //  // Session.Remove("value");
        //  System.Text.StringBuilder sb = new System.Text.StringBuilder();
        //  sb.Append(@"<script type='text/javascript'>");
        //  sb.Append("$('#detailsmodal').modal('show');");
        //  sb.Append(@"</script>");
        //  ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
    }

    //Click add to cart menu
    protected void btn_Goclick(object sender, EventArgs e)
    {

        pnlCartPanel.Visible = true;
        Panelallitemlist.CssClass = "col-md-6";
        pnlCartPanel.CssClass = "col-md-6";
        string Code = Session["Code"].ToString();
        string ItemName = Session["ItemName"].ToString();
        string Qty = txtqty.Text;
        decimal QtyStock = Convert.ToDecimal(Session["QtyStock"].ToString());
        string Price = Session["Price"].ToString();
        string Disc = Session["Disc"].ToString();
        string kditem = Session["kditem"].ToString(); 

        string s = string.Empty;
        string Options;
        for (int i = 0; i < chkoptionslist.Items.Count; i++)
        {
            if (chkoptionslist.Items[i].Selected)
            {
                s += chkoptionslist.Items[i].Value + ", ";
                sauceoptions = s.Substring(0, s.Length - 2);
            }
        }
        Options = sauceoptions;

        decimal Total = Math.Round((Convert.ToDecimal(Price) - (Convert.ToDecimal(Price) * Convert.ToDecimal(Disc) / 100)) * Convert.ToDecimal(Qty), 2);

        //// string Total = LblTotal.Text; 
        //decimal Total = Math.Round((Convert.ToDecimal(Price) - (Convert.ToDecimal(Price) * Convert.ToDecimal(Disc) / 100)) * Convert.ToDecimal(Qty), 2);

        //Check Item Quantity less than 1 
        if (Convert.ToDecimal(Qty) <= 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Out of stock')", true);
        }
        if (Convert.ToDecimal(Qty) > Convert.ToDecimal(QtyStock))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your given quantity is Greater than available Stock Quantity')", true);
        }
        else
        {
            if (Session["value"] != null)
            {
                tablePub = Session["value"] as DataTable;
            }
            else
            {
                //Add item from item list     
                tablePub.Columns.Add("Code", typeof(string));
                tablePub.Columns.Add("ItemName", typeof(string));
                tablePub.Columns.Add("Options", typeof(string));
                tablePub.Columns.Add("Qty", typeof(string));
                tablePub.Columns.Add("Price", typeof(string));
                tablePub.Columns.Add("Disc", typeof(string));
                tablePub.Columns.Add("Total", typeof(string));
                tablePub.Columns.Add("image", typeof(string));
                tablePub.Columns.Add("kditem", typeof(string));
                Session["valuePUB"] = tablePub;
            }
            tablePub.Rows.Add(Code, ItemName, Options, Qty, Price, Disc, Total, Session["image"].ToString(), kditem);
            Session.Add("value", tablePub);

            dtlistcartitems.DataSource = tablePub;
            dtlistcartitems.DataBind();
             
            decimal sum = 0; decimal qty2 = 0;
            foreach (DataRow dr in tablePub.Rows)
            {
                sum += Convert.ToDecimal(dr["Total"]);
                qty2 += Convert.ToDecimal(dr["Qty"]);
            }
            lblsubTotal.Text = sum.ToString();

            // double tex = (Convert.ToDouble(lblsubTotal.Text) * 5) / 100;
            double TAX = ((Convert.ToDouble(lblsubTotal.Text) * Convert.ToDouble(lblVatRate.Text)) / 100);
            // lbldisc.Text =  pricetotal - 
            lblVatAmount.Text = Math.Round(TAX, 2).ToString();
            //  lbltotal.Text = (Convert.ToDouble(lblsubTotal.Text) + Convert.ToDouble(lblVat.Text)).ToString();

            decimal totalcost = sum + Convert.ToDecimal(lblshippingcost.Text) + Convert.ToDecimal(lblVatAmount.Text);
            lbltotal.Text = totalcost.ToString();
            lblTotalQty.Text = qty2.ToString();
        }
        // OptionschkDataBind();        
        txtqty.Text = "1";
    }


    protected void btnsuspen_Click(object sender, EventArgs e)
    {
        Session.Remove("value");
        dtlistcartitems.DataSource = null;
        dtlistcartitems.DataBind();
        lblsubTotal.Text = "0";
        lblVatAmount.Text = "0";
        lbltotal.Text = "0";
        lblTotalQty.Text = "0"; 
        pnlCartPanel.Visible = false;
        Panelallitemlist.CssClass = "col-md-12";
    }
     

    // Open Payment Popup window - Checkout Button
    protected void btnPayment_Click(object sender, EventArgs e)
    {
        // Button Linkdetails = sender as Button;
        //  GridViewRow gvrow = (GridViewRow)Linkdetails.NamingContainer;

        if (lblsubTotal.Text == "0" || lblsubTotal.Text == "00" || lblsubTotal.Text == "0.00")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Add at least one item')", true);
        }
        else
        {
            //  txtPaid.Text = string.Empty;
            lbltotalpay.Text = lbltotal.Text;
            //txtPaid.Focus();
            this.ModalPopupPayment.Show();
        }
    }


    //Inset Multiple Row in single trXID  - Function method
    protected void SaveSaleItem()
    {
        try
        {
            tablePub = (DataTable)Session["valuePUB"];
            for (int i = 0; i < tablePub.Rows.Count; i++)
            {
                //   string datetime = DateTime.Now.ToString("yyyy-MM-dd"); 
                string Code     = tablePub.Rows[i].ItemArray[0].ToString(); //.Rows[i].Cells[1].Text;
                string ItemName = tablePub.Rows[i].ItemArray[1].ToString(); //grdSelectedItem.Rows[i].Cells[2].Text;
                string Options  = tablePub.Rows[i].ItemArray[2].ToString();
                string Qty      = tablePub.Rows[i].ItemArray[3].ToString();
                string Price    = tablePub.Rows[i].ItemArray[4].ToString();
                string Disc     = tablePub.Rows[i].ItemArray[5].ToString();
                string Total    = tablePub.Rows[i].ItemArray[6].ToString();
                string kditem   = tablePub.Rows[i].ItemArray[8].ToString(); 

                SqlConnection cn = new SqlConnection(ConnectionString);
                SqlCommand cmd = new SqlCommand("SP_POS_Insert_SalesItems", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();

                cmd.Parameters.AddWithValue("@Code", Code);
                cmd.Parameters.AddWithValue("@ItemName", ItemName);
                cmd.Parameters.AddWithValue("@Qty", Qty);
                cmd.Parameters.AddWithValue("@Price", Price);
                cmd.Parameters.AddWithValue("@Disc", Disc);
                cmd.Parameters.AddWithValue("@Total", Total);
                cmd.Parameters.AddWithValue("@Options", "web: " + Options);
                cmd.Parameters.AddWithValue("@kditem", kditem);

                cmd.Parameters.Add("@InvoiceNoOutPut", SqlDbType.BigInt).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                cn.Close();

                Session["InvoiceNoOutPut"] = cmd.Parameters["@InvoiceNoOutPut"].Value.ToString();
            }

        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }

    //Insert One Row sales payment info every one trXID
    protected void SaveSalePaymentInfo(string payType, string totalpayable, string paidAmount, string dueAmount, string CustName, string CustContact, string Custaddress, string tableno)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_POS_Insert_SRsalesPayment", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
             

            cmd.Parameters.AddWithValue("@SalesQty",    lblTotalQty.Text);
            cmd.Parameters.AddWithValue("@Subtotal",    lblsubTotal.Text);
            cmd.Parameters.AddWithValue("@vatrate",     lblVatRate.Text);
            cmd.Parameters.AddWithValue("@Vat",         lblVatAmount.Text);
            cmd.Parameters.AddWithValue("@totalpayable",  totalpayable);
            cmd.Parameters.AddWithValue("@payType",     payType );
            cmd.Parameters.AddWithValue("@paidAmount",  paidAmount);
            cmd.Parameters.AddWithValue("@changeAmount", "0");
            cmd.Parameters.AddWithValue("@dueAmount",   dueAmount );
            cmd.Parameters.AddWithValue("@note",        txtNote.Text);

            cmd.Parameters.AddWithValue("@ShopId",      "PUBLIC01");
            cmd.Parameters.AddWithValue("@CustID",      lblcustomerid.Text);
            cmd.Parameters.AddWithValue("@CustName",    CustName);
            cmd.Parameters.AddWithValue("@CustContact", CustContact);
            cmd.Parameters.AddWithValue("@Custaddress", Custaddress);
            cmd.Parameters.AddWithValue("@ServedBy",    "Web_system");
            cmd.Parameters.AddWithValue("@disamt",      "0");
            cmd.Parameters.AddWithValue("@ordertime",   DateTime.Now.ToString("HH:mm"));
            cmd.Parameters.AddWithValue("@tableno",     tableno);
            cmd.Parameters.AddWithValue("@tokenno",     DateTime.Now.ToString("HH-mmss"));
            cmd.ExecuteNonQuery();
            cn.Close(); 
        }
        catch
        {
            // lbtotalRow.Text = "No Records Found";
        }
    }

    protected void bntPay_Goclick(object sender, EventArgs e)
    {
        decimal totalpayable = Convert.ToDecimal(lbltotalpay.Text);
        SaveSaleItem();
        SaveSalePaymentInfo("Cash on Delivery", totalpayable.ToString(), "0", lbltotalpay.Text, txtcustomername.Text, txtphone.Text, txtAddress.Text, "WEB-ORDER");
        //  this.ModalPopupPayment.Show();
        Session["invoice"] = Session["InvoiceNoOutPut"].ToString();
        Session["custname"] = txtcustomername.Text;
        Session["custaddr"] = txtAddress.Text;
        Session["custphone"] = txtphone.Text;
        Session["comment"] = txtNote.Text;
        Session["VatRate"]  = lblVatRate.Text;
        Session["VatAmount"] = lblVatAmount.Text;
        Session["shippingcost"] = lblshippingcost.Text;

        Session.Remove("value");
        Response.Redirect("~/Order_Invoice.aspx");

    }
  

    protected void btnhereserve_Click(object sender, EventArgs e)
    {
        decimal totalpayable = Convert.ToDecimal(lbltotalpay.Text) - Convert.ToDecimal(lblshippingcost.Text);
        SaveSaleItem();
        SaveSalePaymentInfo("Counter_payment", totalpayable.ToString(), totalpayable.ToString(), "0", "Serve_here", "000001", "Serve_here", "WEB-ORDER");
       
        Session["invoice"] = Session["InvoiceNoOutPut"].ToString();
        Session["custname"] = "Serve_here";
        Session["custaddr"] = "Serve_here";
        Session["custphone"] = "000001";
        Session["comment"] = "Serve_here";
        Session["VatRate"] = lblVatRate.Text;
        Session["VatAmount"] = lblVatAmount.Text;
        Session["shippingcost"] = "0";

        Session.Remove("value");
        Response.Redirect("~/Order_Invoice.aspx");
    }

    protected void btnDeleteitem_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        DataListItem item = (DataListItem)btn.NamingContainer;

        int itemIndex = item.ItemIndex;
        tablePub = (DataTable)Session["value"];
        tablePub.Rows.RemoveAt(itemIndex);

        dtlistcartitems.DataSource = tablePub;
        dtlistcartitems.DataBind();

        decimal sum = 0; decimal qty = 0;
        foreach (DataRow dr in tablePub.Rows)
        {
            sum += Convert.ToDecimal(dr["Total"]);
            qty += Convert.ToDecimal(dr["Qty"]);
        }
        lblsubTotal.Text = sum.ToString();

        decimal TAX = ((Convert.ToDecimal(lblsubTotal.Text) * Convert.ToDecimal(lblVatRate.Text)) / 100);        
        lblVatAmount.Text = Math.Round(TAX, 2).ToString();

        decimal totalcost = sum + Convert.ToDecimal(lblshippingcost.Text) + Math.Round(TAX, 2);
        lbltotal.Text = totalcost.ToString();
        lblTotalQty.Text = qty.ToString();

        if (tablePub.Rows.Count == 0)
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
    }

}