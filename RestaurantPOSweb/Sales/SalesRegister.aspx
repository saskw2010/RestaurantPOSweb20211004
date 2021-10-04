<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="SalesRegister.aspx.cs" Inherits="SalesRegister" %> 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="../Styles/style.css" rel="stylesheet" type="text/css" />    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">   <br />

    <%--/////////<div class="input-group input-group-sm">//// Item list --%>

<asp:Panel ID="panelItems" runat="server"    CssClass="col-lg-7"> 
    <div class="panel  panel-success"> 
      
<asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="445px">  <br /> 
       <asp:DataList ID="DataList1" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow"   RepeatDirection="Horizontal" CssClass="row">
            <ItemStyle ForeColor="Black"/>
            <ItemTemplate>
                <div class="col-sm-3"> 
                    <div id="pricePlansmsg">
                    <ul id="plans">
                        <li class="plan" >
                            <ul class="planContainer"  >
                                <li class="title">
                                    <asp:Label ID="LblID" Visible="false" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                    <asp:Label ID="LblCode" Visible="false" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                                     <asp:Label  Visible="false"  ID="Lbloptions" runat="server" Text='<%# Bind("options") %>' ></asp:Label>
                                     <asp:Label  Visible="false"  ID="Lbldescription" runat="server" Text='<%# Bind("description") %>' ></asp:Label>
                                    <asp:Label ID="LblItemName" Visible="false" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label> 
                                    <asp:Label ID="LblQty" Visible="false" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                                    <asp:Label ID="LblPrice" Visible="false" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                    <asp:Label ID="LblDisc" Visible="false" runat="server" Text='<%# Eval("Disc") %>'></asp:Label>
                                    <asp:Label ID="LblTotal" Visible="false" runat="server" Text='<%# Eval("Total") %>'></asp:Label> 
                                    <asp:Label ID="Lblkditem" Visible="false" runat="server" Text='<%# Eval("kditem") %>'></asp:Label>                                                                       

                                    <h5><asp:Label   ID="lblitemNametop" Font-Size="12px" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label></h5>
                                </li>
                                <li class="title">
                                    <asp:Image ID="imgPhoto" class="img-circle" runat="server" Width="80px" Height="80px"   ImageUrl='<%# Eval("Photo")%>' />
                                </li>
                                <li>
                                    <ul class="options">                                      
                                       <li><span> Price: <asp:Label ID="Label9" runat="server" Text='<%# Bind("Total") %>'></asp:Label>   
                                           (<asp:Label ID="Label8" ForeColor="Black" Font-Size="10px" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>)</span>  </li>                                    
                                    </ul>
                                </li> 
                                 <asp:Button ID="btnPopuOptions"  runat="server"  Text="Add to Cart"    ValidationGroup="vG2"  Font-Size="12px"  ToolTip="Add to Cart" class="btn btn-primary btn-xs" OnClick="btnPopuOptions_Goclick" />  <br />           
                            </ul>
                        </li>
                    </ul>
                </div>
          </div>
            </ItemTemplate>
        </asp:DataList> 
        </asp:Panel> 
   <%-----------------------------    Category --------------------------------Start--------- --%>
        <div class="panel-body">   
                        <asp:DataList ID="dtlistcategory" runat="server" RepeatLayout="Flow"    RepeatDirection="Horizontal" CssClass="row">
                         <ItemStyle ForeColor="Black"/>
                        <ItemTemplate>
                           <asp:LinkButton CssClass="btn btn-success" ID="lnkCategory" runat="server" Text='<%# Bind("ItemCategory") %>'  OnClick="lnkCategory_Onclick"  Font-Size="13" ForeColor="White" > </asp:LinkButton> 
                            <asp:Label   ID="lblcategid" Font-Size="13px" runat="server" Text='<%# Bind("ItemCategory") %>' Visible="False"></asp:Label> 
                        </ItemTemplate> 
                </asp:DataList>              
        </div> 
   <%----------------------------------------- Category END ---------------------------------------%>

    </div>
 </asp:Panel> 

<asp:Panel ID="paneCartlItemsFull" runat="server" CssClass="col-lg-5" >
            <div class="input-group">
            <span class="input-group-addon"> <span class="glyphicon glyphicon-barcode"> </span> </span>
            <asp:TextBox ID="txtItemSearch" runat="server" 
                placeholder="Search to Scan Products" class="form-control"  ToolTip="Search by item code or item name"
                ontextchanged="txtItemSearch_TextChanged" AutoPostBack="true"  ></asp:TextBox> 
                <span class="input-group-addon"><span class="glyphicon glyphicon-search"> </span> </span>
            </div>  
    <asp:Panel ID="paneCartlItems" runat="server" class="panel panel-default" ScrollBars="Vertical" Height="340px">    <%--  ScrollBars="Vertical" Height="340px"--%>  <%--Scroll Added cart Panel--%>
                
        <asp:DataList ID="dtlistgrid" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow"    RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                <ItemTemplate>
                    <div class="col-md-12">  
                        <div id="pricePlansmsg">
                            <ul id="plans">
                                <li class="panel-body plan">                             
                                        <ul class="planContainer">
                                            <div class="col-md-2" style="text-align:left"> 
                                                   <asp:Image ID="imgPhoto"   runat="server" class="img-circle"  Width="40px" Height="40px"   ImageUrl='<%# Bind("image") %>' /> <br />
                                                 
                                            </div> 
                                            <div class="col-lg-5" style="text-align:left">  
                                                        <asp:Label  Visible="false"  ID="lblid" runat="server" Text='<%# Bind("Code") %>'></asp:Label>  
                                                        <asp:Label ID="Lblkditem" Visible="false" runat="server" Text='<%# Eval("kditem") %>'></asp:Label>    
                                                       <asp:Label ForeColor="Black"  ToolTip="Item Quantity"    Font-Bold="true" ID="Label1" runat="server" Text='<%# Bind("Qty") %>'></asp:Label> -                                                   
                                                        <asp:Label   ID="lblitemname" Font-Size="13px" runat="server" Text='<%# Bind("ItemName") %>' ForeColor="#0084B4"></asp:Label> <br />
                                                         Price:<asp:Label ID="LblPrice"   runat="server" Text='<%# Eval("Price") %>'></asp:Label>                                                   
                                                        - Dis:<asp:Label ForeColor="Black"  ToolTip="Disc"  ID="lblDisc" runat="server" Text='<%# Bind("Disc") %>'></asp:Label>% 
                                                       <br /> <asp:Label ForeColor="Black"  ToolTip="Options"  ID="lblOptions" runat="server" Text='<%# Bind("Options") %>' Font-Size="8"></asp:Label> 
                                                
                                            </div>  
                                            <div class="col-md-3" > 
                                               <asp:Label ForeColor="Black"  ToolTip="Price"  ID="lblTotal"   runat="server" Text='<%# Bind("Total") %>' Font-Size="15px"></asp:Label>   
                                                 
                                            </div>  
                                            <div class="col-md-2" style="text-align:right"> 
                                                     <asp:LinkButton  ID="LinkDele" runat="server" ForeColor="Red"    Font-Size="20px"    ToolTip="Remove item" class="glyphicon glyphicon-trash" OnClick="btnDeleteitem_Click"   />                                                  
                                            </div>                                   
                                         </ul>                               
                                </li>
                            </ul>
                        </div> 
                     </div>                     
                </ItemTemplate>
            </asp:DataList>   <br />
      </asp:Panel> 
          <div class="panel panel-default">  
            <div class="panel-footer"  style="text-align:right">     
                Subtotal =  <asp:Label ID="lblsubTotal" runat="server" Font-Bold="true"  Text="0"></asp:Label><br />
                <asp:Label ID="Label1" Font-Size="11px" runat="server" Text="Vat ="></asp:Label>
                (<asp:Label ID="lblVatRate" Font-Size="9px" runat="server" Text="0"></asp:Label>)
                <asp:Label ID="lblVat"  Font-Size="11px"  runat="server" Text="0"></asp:Label><br />  
                Total =     <asp:Label ID="lbltotal" runat="server" Font-Bold="true" Text="0"></asp:Label> <br />

                <asp:Label ID="Label7" Font-Size="11px" runat="server" Text="Total Items"> </asp:Label>
                <asp:Label ID="lblTotalQty"  Font-Size="11px"  runat="server" Text="0"></asp:Label>  <br /><br />

                <asp:Label ID="lbltableno1" runat="server" Text="Table:Null"></asp:Label>
                <asp:Button ID="btnchangetable" runat="server" class="btn btn-info" Text="Change Table"  PostBackUrl="~/Sales/Tableview.aspx" />
                <asp:Button ID="btnsuspen" runat="server" class="btn btn-danger" Text="Suspen"   onclick="btnsuspen_Click" />
                <asp:Button ID="btnPayment" runat="server" class="btn btn-success"  Text="Payment" onclick="btnPayment_Click" />    
            </div>  
             </div> 
</asp:Panel>
 


    <%--<<<<<<<<<<<<<<<<<<<<< ---------------   Options view      Start --------------    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>    

   <!-- Modal -->
  <div class="modal fade in" id="detailsmodal"  role="dialog"  ><div class="modal-backdrop fade in" style="height:100%;"></div>
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content col-lg-12" >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">X</button>
          <h4 class="modal-title">              
               <asp:Label ID="Label14" runat="server" Font-Size="15px" Text="  Select your Options"></asp:Label><br />
              <asp:Label ID="Label10" runat="server" ForeColor="Black" Font-Size="12px" Text="Kitchen item:"></asp:Label>
              <asp:Label ID="lblkditem" runat="server" ForeColor="Black" Font-Size="12px" Text="NO"></asp:Label>  
           </h4>
        </div>
        <div class="modal-body">                      
                      <asp:Panel ID="Panel2"     runat="server" ScrollBars="Vertical"  Height="338px"> 
                                    <div class="col-md-7" style="text-align:left">       
                                        <asp:Label ID="lblItemname" Font-Bold="true" runat="server"  Text="-"></asp:Label> <br />
                                            <asp:Label ID="lbldescriptionsPop"   runat="server" ForeColor="#8e969d"  Text="-" Font-Size="9"></asp:Label> 
                                    </div> 
                                <div class="col-md-2">
                                    Quantity <br />
                                    <atk:NumericUpDownExtender ID="NumericUpDownExtender1" runat="server" 
                                    TargetControlID="txtqty" Minimum="1" Maximum="999" Width="70"  ViewStateMode="Enabled">  </atk:NumericUpDownExtender>
                                    <asp:TextBox ID="txtqty" runat="server" Font-Size="14px"  Text="1" Width="25px" ToolTip="Item Quantity" ></asp:TextBox> 
                                </div>
                                <div class="col-md-3" style="text-align:right"> <br />
                                            <asp:Label ID="lblitemPrice" Font-Bold="true" Font-Size="14px" runat="server"  Text="0"></asp:Label> 
                                </div> 
                                <div class="col-md-12" style="text-align:left">                            
                                    <br/>   Sauce Options<br/>
                                    <asp:CheckBoxList ID="chkoptionslist" class="table-hover" runat="server"  CellPadding="5" 
                                    CellSpacing="5"   Font-Size="12" Visible="False" />  
                                </div>
            </asp:Panel>
        </div>
        <div class="modal-footer">  
            <asp:Button ID="btncloseOptionsPopup" class="btn btn-danger btn-sm" runat="server"  data-dismiss="modal" Text="Close"    />  
           <asp:Button ID="btn_GoAddtocart" class="btn btn-primary btn-sm" runat="server"  Text="Add To cart" OnClick="btn_Goclick"  />  
            
        </div>
      </div>
      
    </div>
  </div>

 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Details view   Popup  END -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>  




 <%--<<<<<<<<<<<<<<<<<<<<< --------------- payment panel Popup -----------Start --- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
     <asp:Button ID="btnShowPopup" runat="server" style="display:none" />      
    <atk:ModalPopupExtender ID="ModalPopupPayment" runat="server" TargetControlID="btnShowPopup" 
    PopupControlID="pnlpopupPayment"  CancelControlID="btnClosePayment" BackgroundCssClass="modalBackground">
    </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupPayment"  class="panel panel-primary col-md-6" runat="server" BackColor="White" style="display:none;text-align:left"    DefaultButton="bntPay" > 
                        <center> 
                        <asp:Label ID="Label2" runat="server" Font-Size="19px" Text=" Payment"></asp:Label>  
           
                        <asp:Label ID="Label3" runat="server" ToolTip="Change to customer" Text="Change:"></asp:Label>                                 
                        <asp:Label ID="lblChange" runat="server" Font-Size="19px" Font-Bold="true" Text="0"></asp:Label> | 
                             
                        <asp:Label ID="Label4" runat="server" ToolTip="Receive from customer" Text="Due:"></asp:Label>                            
                        <asp:Label ID="lblDue" runat="server" Font-Size="19px" Font-Bold="true" Text="0"></asp:Label> <br />
                        Selected Table: <asp:Label ID="lbltableno" runat="server" Text="Table-001"></asp:Label>
                        </center>
                        <hr />     
        <asp:Panel ID="pnlpopupPaymentbody"  class="panel-body" runat="server" ScrollBars="Vertical" Height="430px" >
            <div class="col-md-5">                  
                        Total Payable:                                 
                        <asp:Label ID="lbltotalpay" runat="server" Font-Bold="true" Font-Size="15px"  Text="-"></asp:Label>  <br /> 
                                
                        Paid by:  
                        <asp:DropDownList ID="DDLPaidBy" runat="server" class="form-control">
                            <asp:ListItem>Cash</asp:ListItem>
                            <asp:ListItem>Cheque</asp:ListItem>
                            <asp:ListItem>Cradit Card</asp:ListItem>
                            <asp:ListItem>Paypal</asp:ListItem>
                            <asp:ListItem>Online</asp:ListItem>
                        </asp:DropDownList>   
                         
                         
                        <asp:Label ID="Label5" runat="server" ToolTip="Optional" Text="Note"></asp:Label>  
                        <asp:Label ID="Label6" runat="server" Font-Size="8px" ToolTip="Optional" Text="Optional"></asp:Label>                           
                        <asp:TextBox ID="txtNote" runat="server" ToolTip="Optional"  Height="60px" class="form-control" ></asp:TextBox> 
                            
                        Select Customer:           
                        <asp:DropDownList ID="DDLCustname" class="form-control" runat="server" AutoPostBack="True"  onselectedindexchanged="DDLCustname_SelectedIndexChanged">
                        </asp:DropDownList>
                                               
                        <asp:Label   Font-Size="6px" ID="lblCustID"        runat="server" Text="0001"></asp:Label>            
                        <asp:Label   Font-Size="6px" ID="lblCustContact"   runat="server" Text="121"></asp:Label> 
                        <asp:Label   Font-Size="6px" ID="lblcustaddress"   runat="server" Text="-"></asp:Label><br />
                        Token No:
                        <asp:TextBox ID="txttokenno" runat="server" ToolTip="Tokenno" Text="1"   class="form-control" ></asp:TextBox> 

                        Discount amount                       
                        <asp:TextBox ID="txtdiscountamount" ToolTip="Discount amount" Text="0" runat="server" class="form-control"
                         Placeholder="100"   AutoPostBack="True" ontextchanged="txtdiscountamount_TextChanged"></asp:TextBox> 
                        <asp:RegularExpressionValidator ForeColor="Red" ValidationGroup="vr12" 
                        ControlToValidate="txtdiscountamount" ID="RegularExpressionValidator2" 
                        runat="server" ErrorMessage="Numaric value only" ValidationExpression="[0-9]*\.?[0-9]*"    SetFocusOnError="True">
                        </asp:RegularExpressionValidator>   
                                
          </div>    
             <div class="col-md-7"> 
                  <div class="col-md-11">
                        Paid:
                        <asp:TextBox ID="txtPaid" ToolTip="Customer paid Amount" runat="server" class="form-control"   
                         Placeholder="100"  AutoPostBack="True" ontextchanged="txtPaid_TextChanged" ></asp:TextBox> 

                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtPaid" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Enter paid amount"   SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ForeColor="Red" Font-Size="11px" ValidationGroup="vr12" 
                        ControlToValidate="txtPaid" ID="RegularExpressionValidator1" 
                        runat="server" ErrorMessage="Numaric value only" ValidationExpression="[0-9]*\.?[0-9]*"   SetFocusOnError="True">
                        </asp:RegularExpressionValidator>              
                  </div> 
                 <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
               <p> 
                <asp:Button ID="btncoin1" runat="server"  class="btn btn-primary" Text="1" Font-Bold="True" Font-Size="20" Width="100"  OnClick="btnnum1_Click" />
                <asp:Button ID="btncoin2" runat="server"  class="btn btn-primary" Text="2" Font-Bold="True" Font-Size="20" Width="100"  OnClick="btnnum2_Click"/>
                <asp:Button ID="btnnum3" runat="server"  class="btn btn-primary" Text="3" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnnum3_Click"/>
               </p>

              <p> 
                 <asp:Button ID="btnnum4" runat="server"  class="btn btn-primary" Text="4" Font-Bold="True" Font-Size="20" Width="100"  OnClick="btnnum4_Click" />
                <asp:Button ID="btnnum5" runat="server"  class="btn btn-primary" Text="5" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnnum5_Click"/>
                <asp:Button ID="btnnum6" runat="server"  class="btn btn-primary" Text="6" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnnum6_Click" />
              </p> 

              <p>   
                <asp:Button ID="btnnum7" runat="server"  class="btn btn-primary" Text="7" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnnum7_Click"/>
                <asp:Button ID="btnnum8" runat="server"  class="btn btn-primary" Text="8" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnnum8_Click"/>
                <asp:Button ID="btnnum9" runat="server"  class="btn btn-primary" Text="9" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnnum9_Click" />
              </p> 

               <p>  
                <asp:Button ID="btndot" runat="server"  class="btn btn-success" Text="." Font-Bold="True" Font-Size="20" Width="100"    OnClick="btndot_Click"/>
                <asp:Button ID="btnZero" runat="server"  class="btn btn-primary" Text="0" Font-Bold="True" Font-Size="20" Width="100"   OnClick="btnZero_Click" />
                <asp:Button ID="btnClear" runat="server"  class="btn btn-warning" Text="Clear"   Font-Size="20" Width="100"             OnClick="btnClear_Click"/>
               </p> 

               <p> 
                <asp:Button ID="btnClosePayment" class="btn btn-danger btn-lg" runat="server" Text="Back" Width="150" />            
                <asp:Button ID="bntPay" class="btn btn-success btn-lg" runat="server" OnClick="bntPay_click" ValidationGroup="vr12"  Text="Pay" Width="153"  />
               </p>
             </div>
      </asp:Panel>           
         
</asp:Panel>

</asp:Content>

