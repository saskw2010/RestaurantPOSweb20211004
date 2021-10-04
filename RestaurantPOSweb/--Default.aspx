<%@ Page Title="" Language="C#" MasterPageFile="MasterPage/Master_Front.master" AutoEventWireup="true" CodeFile="--Default.aspx.cs" Inherits="Report_Default" EnableEventValidation="false"  %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  
        <!--==========================
      Portfolio Section
    ============================-->
   
<div class="container">

        <header class="section-header">
          <h3 class="section-title">Our Items</h3>
        </header>
  <%-----------------------------    Category --------------------------------Start--------- --%>
        <div class="col-lg-12">  
            <asp:DataList ID="dtlistcategory" runat="server" RepeatLayout="Flow"    RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                    <ItemTemplate>
                        <asp:LinkButton CssClass="btn btn-success" ID="lnkCategory" runat="server" Text='<%# Bind("ItemCategory") %>'  OnClick="lnkCategory_Onclick"  Font-Size="13" ForeColor="White" > </asp:LinkButton> 
                        <asp:Label   ID="lblcategid" Font-Size="13px" runat="server" Text='<%# Bind("ItemCategory") %>' Visible="False"></asp:Label> 
                    </ItemTemplate> 
            </asp:DataList>             
        </div> 
   <%----------------------------------------- Category END ---------------------------------------%>

        <div class="col-md-12"> <br />  
            <div class="form-group">      
                <div class="input-group"> 
                    <span class="input-group-addon"><span class="fa fa-search"></span></span>                               
                    <asp:TextBox ID="txtSearch" Font-Size="15px" class="form-control" ToolTip="Search by item name, category... " 
                        placeholder="Search by item name,category..."  AutoPostBack="true" runat="server" 
                        ontextchanged="txtSearch_TextChanged" ></asp:TextBox>
                        <span class="input-group-btn">
                            <asp:Button   class="btn btn-warning"   ID="btnGo" runat="server"  Text="Go" />          
                        </span>                                   
                </div>  
            </div>   
        </div> 

 
    <%--------------------------------    Product List ----------------------------Start----------%>
        <asp:Panel ID="Panelallitemlist"  class="col-md-12"  runat="server">  
            
            <asp:DataList ID="dtlistgrid" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow"   RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                <ItemTemplate>
                    <div class="col-sm-3"> 
                        <div id="pricePlansmsg">
                            <ul id="plans">
                                <li class="plan" style="width:215px">                                                             
                                        <ul class="planContainer">     
                                            <li class="title">
                                                        <asp:Label ID="lblproductnameDetails" Visible="false" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label> 
                                                        <asp:Label  Visible="false"  ID="lblid" runat="server" Text='<%# Bind("ID") %>'></asp:Label>  
                                                        <asp:Label  Visible="false"  ID="lblcategoryid" runat="server" Text='<%# Bind("ItemCategory") %>'></asp:Label>                                              
                                                        <asp:Label ID="LblDescriptions" Visible="false" runat="server" Text='<%# Eval("description") %>'></asp:Label>  
                                                        <asp:HyperLink ID="HyperLink2" ToolTip="Show Details" Target="_blank"   runat="server" NavigateUrl='<%# string.Format("DetailsView.aspx?pid={0}&cid={1}", Eval("id"),Eval("ItemCategory")) %>'>       
                                                        <asp:Label   ID="lblitemname" Font-Size="14px" Font-Bold="true" runat="server" Text='<%# Bind("ItemName") %>' ForeColor="#ff3399"></asp:Label> 
                                                        </asp:HyperLink>
                                            </li>
                                            <li class="title">                      
                                                    <asp:HyperLink ID="HyperLink1" ToolTip="Show Details"   runat="server"  NavigateUrl='<%# string.Format("DetailsView.aspx?pid={0}&cid={1}", Eval("id"),Eval("ItemCategory")) %>' >     
                                                    <asp:Image  ID="imgPhoto" ToolTip='<%# Bind("ItemName") %>' runat="server"  class="img-thumbnail2"   Width="200px" Height="200px"   ImageUrl='<%# Eval("Photo") %>' /> <br />
                                                   </asp:HyperLink>
                                                     
                                            </li>
                                            <li>
                                                 <ul class="options">                                      
                                                   <li>
                                                        <asp:Label ID="Label2"   ForeColor="#999999" runat="server" Text='<%# Eval("Disc") %>' Font-Size="11"></asp:Label>% OFF  
                                                       <asp:Label   ToolTip="Price"    Font-Bold="true" ID="LblPriceOnsale" runat="server" Text='<%# Bind("Price") %>' Font-Size="14"></asp:Label> 
                                                     
                                                   </li>   
                                                    <asp:Button ID="btnPopuOptions"  runat="server"  Text="Add to Cart"   
                                                         ValidationGroup="vG2"  Font-Size="12px"   ToolTip="Add to Cart"  class="btn btn-primary btn-xs"  OnClick="btnPopuOptions_Goclick"   /> <br />              
                                                </ul>
                                            </li>                                   
                                         </ul>                               
                                </li>
                            </ul>
                        </div> 
                     </div>                     
                </ItemTemplate>
            </asp:DataList>
            <center> <asp:Button ID="btnviewmore" class="btn btn-default btn-sm" runat="server"  Text="View More" OnClick="btnviewmore_click"  /> </center>           
        </asp:Panel>
  <%--------------------------------    Product List ----------------------------END----------%>

  <%----------------------------------   Cart item   ---------------------------- Start ----------%>
 <asp:Panel ID="pnlCartPanel"  class="col-md-4"  runat="server"> <br /><br /> 
    <div class="panel panel-default">  
        <div class="panel-heading"> 
           <h4>Your Order </h4>
        </div> 
    <div class="panel-bodyss">                   
        <asp:DataList ID="dtlistcartitems" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow"    RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                <ItemTemplate>
                    <div class="col-md-12">  
                        <div id="pricePlansmsg">
                            <ul id="plans">
                                <li class="plan" >                             
                                        <ul class="planContainer">  
                                            <div class="col-lg-2"> <br />                                          
                                                   <asp:Image ID="imgPhoto" ToolTip='<%# Bind("ItemName") %>' runat="server" class="img-circle"  Width="40px" Height="40px"   ImageUrl='<%# Bind("image") %>' /> <br />
                                           
                                            </div> 
                                            <div class="col-md-5" style="text-align:left"> <br />
                                                        <asp:Label  Visible="false"  ID="lblid" runat="server" Text='<%# Bind("Code") %>'></asp:Label> 
                                                        <asp:Label ID="LblPrice" Visible="false" runat="server" Text='<%# Eval("Price") %>'></asp:Label> 
                                                        <asp:Label ID="LblDescriptions" Visible="false" runat="server" Text='<%# Eval("Total") %>'></asp:Label>                                                
                                                        <asp:Label ForeColor="Black"  ToolTip="Qty"    Font-Bold="true" ID="Label1" runat="server" Text='<%# Bind("Qty") %>'></asp:Label> -
                                                       <asp:Label   ID="lblitemname" Font-Size="12px" runat="server" Text='<%# Bind("ItemName") %>' ForeColor="#0084B4"></asp:Label> <br />
                                                        Options:<asp:Label ForeColor="Black"  ToolTip="Size"    Font-Bold="true" ID="Label3" runat="server" Text='<%# Bind("Options") %>'></asp:Label>    <br /> 
                                                
                                            </div>  
                                            <div class="col-md-3"  > <br />  
                                                <asp:Label ID="Label16" runat="server" Text=" OFF" Font-Size="5"></asp:Label> 
                                                <asp:Label ForeColor="Silver"   ID="Label15" runat="server" Text='<%# Bind("Disc") %>' Font-Size="9"></asp:Label>%    
                                            
                                              <asp:Label ForeColor="Black"  ToolTip="Price"    Font-Bold="true" ID="Label9" runat="server" Text='<%# Bind("Total") %>' Font-Size="13px"></asp:Label>   
                                              
                                            </div>  
                                            <div class="col-lg-2" style="text-align:right"> <br /> <br />  
                                            <asp:LinkButton  ID="LinkDele" runat="server" ForeColor="Red"    Font-Size="19px"    ToolTip="Remove item" class="fa fa-times" OnClick="btnDeleteitem_Click"     />                                                  
                                                  
                                             </div>                                   
                                         </ul> 
                               
                                </li>
                            </ul>
                        </div> 
                     </div>                     
                </ItemTemplate>
            </asp:DataList>
        </div> 
                     <div class="panel-footer"  style="text-align:right">     
                        Subtotal =  <asp:Label ID="lblsubTotal" runat="server" Font-Bold="true"  Text="0"></asp:Label><br /> 
                            <asp:Label ID="Label1" Font-Size="11px" runat="server" Text="Vat"></asp:Label>
                        (<asp:Label ID="lblVatRate" Font-Size="9px" runat="server" Text="0"></asp:Label>% )
                        <asp:Label ID="lblVat"  Font-Size="11px"  runat="server" Text="0"></asp:Label><br /> 
                         Shipping = <asp:Label ID="lblshippingcost" runat="server" Font-Bold="true"  Text="10"></asp:Label><br /> 
                        Total =     <asp:Label ID="lbltotal" runat="server" Font-Bold="true" Text="0"></asp:Label> <br />
                          
                        <asp:Label ID="Label7" Font-Size="11px" runat="server" Text="Total Items"> </asp:Label>
                        <asp:Label ID="lblTotalQty"  Font-Size="11px"  runat="server" Text="0"></asp:Label> <br /> <br /> 
                            <div >           
                            <asp:Button ID="btnsuspen" runat="server" class="btn btn-danger btn-lg" Text="Close"      onclick="btnsuspen_Click" />
                            <asp:Button ID="btnPayment" runat="server" class="btn btn-warning btn-lg"            Text="Checkout" OnClick="btnPayment_Click"  />
                            </div>                
                    </div>
            </div>  
    </asp:Panel>  
<%----------------------------------   Cart item   ---------------------------- END  ----------%>

    <%--<<<<<<<<<<<<<<<<<<<<< ---------------   Options view      Start --------------    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>    

   <!-- Modal -->
  <div class="modal fade" id="detailsmodal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content"  >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">X&times;</button>
          <h4 class="modal-title">  
              <span class="fa fa-check" style="font-size: 25px"></span> 
               <asp:Label ID="Label14" runat="server" Font-Size="15px" Text="  Select your Options"></asp:Label>
                  
           </h4>
        </div>
        <div class="modal-body">                      
                      <asp:Panel ID="Panel2"     runat="server" ScrollBars="Vertical"  Height="430px"> 
                                    <div class="col-md-7">       
                                        <asp:Label ID="lblItemname" Font-Bold="true" runat="server"  Text="-"></asp:Label> <br />
                                            <asp:Label ID="lbldescriptionsPop"   runat="server" ForeColor="#8e969d"  Text="-"></asp:Label> 
                                    </div> 
                                <div class="col-md-3">
                                    Quantity <br />
                                    <atk:NumericUpDownExtender ID="NumericUpDownExtender1" runat="server" 
                                    TargetControlID="txtqty" Minimum="1" Maximum="999" Width="70"  ViewStateMode="Enabled">  </atk:NumericUpDownExtender>
                                    <asp:TextBox ID="txtqty" runat="server" Font-Size="14px"  Text="1" Width="25px" ToolTip="Item Quantity" ></asp:TextBox> 
                                </div>
                                <div class="col-md-2" style="text-align:right"> <br />
                                            <asp:Label ID="lblitemPrice" Font-Bold="true" Font-Size="14px" runat="server"  Text="0"></asp:Label> 
                                </div>
                                <div class="col-md-12">                            
                                    <br/>   Sauce Options<br/>
                                    <asp:CheckBoxList ID="chkoptionslist" class="table-hover" runat="server"  CellPadding="5" 
                                    CellSpacing="5"   Font-Size="13" />  
                                </div>
            </asp:Panel>
        </div>
        <div class="modal-footer">  
            <asp:Button ID="btncloseOptionsPopup" class="btn btn-danger btn-sm" runat="server"  data-dismiss="modal" Text="Keep Browsing"    />  
           <asp:Button ID="btn_GoAddtocart" class="btn btn-primary btn-sm" runat="server"  Text="Add To cart" OnClick="btn_Goclick"  />  
            
        </div>
      </div>
      
    </div>
  </div>

 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Details view   Popup  END -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>  


    
 <%--<<<<<<<<<<<<<<<<<<<<< --------------- payment panel Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
     <asp:Button ID="btnShowPopup" runat="server" style="display:none" />      
    <atk:ModalPopupExtender ID="ModalPopupPayment" runat="server" TargetControlID="btnShowPopup" 
    PopupControlID="pnlpopupPayment"  CancelControlID="btnClosePayment" BackgroundCssClass="modalBackground">
    </atk:ModalPopupExtender>

<div class="col-md-12">
    <asp:Panel ID="pnlpopupPayment"   runat="server" class="panel panel-primary"  BackColor="White" style="display:none;text-align:left"  DefaultButton="bntPay" > 
        <div class="panel-heading" style="text-align:left"> 
             <asp:Label ID="Label2" runat="server" Font-Size="19px" Text="  Payment"></asp:Label>
        </div>
        <asp:Panel ID="pnBody" class="panel-body"    runat="server" >          
                    <div class="col-md-6"> 
                            <asp:Label ID="Label3" runat="server" Font-Size="16px" Text="Order info"></asp:Label>    <br />
                     
                            Total Payable:                               
                            <asp:Label ID="lbltotalpay" runat="server" Font-Bold="true" Font-Size="15px"  Text="-"></asp:Label>  <br />
                        
                        <br />
                            <asp:Label ID="Label5" runat="server" ToolTip="Optional" Text="Note/Condition "></asp:Label>  
                                <asp:Label ID="Label6" runat="server" Font-Size="8px" ToolTip="Optional" Text="Optional"></asp:Label>
                        <br />
                        <asp:TextBox ID="txtNote"  placeholder="Note"   runat="server" ToolTip="Optional"  Height="140px" class="form-control" TextMode="MultiLine"></asp:TextBox>                 
                     </div>

                    <div class="col-md-6"> 
                        <asp:Label ID="Label10" runat="server" Font-Size="16px" Text="Customer Address"></asp:Label>    <br />

                        <asp:Label ID="Label11" runat="server" ToolTip="Add Customer name" Text="Customer name"></asp:Label>    
                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtcustomername" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Please add Customer name"></asp:RequiredFieldValidator>       <br />                   
                        <asp:TextBox ID="txtcustomername"  placeholder="name"   runat="server" ToolTip="Customer name"  class="form-control" ></asp:TextBox> <br /> 

                        <asp:Label ID="Label13" runat="server" ToolTip="Add Customer Phone" Text="Phone"></asp:Label>    
                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtphone" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator2" runat="server"   ErrorMessage="Please add Customer Phone"></asp:RequiredFieldValidator>       <br />                   
                        <asp:TextBox ID="txtphone"  placeholder="Phone"   runat="server" ToolTip="Customer Phone"  class="form-control" ></asp:TextBox> <br /> 
                     

                        <asp:Label ID="Label12" runat="server" ToolTip="Delivery Address" Text="Address: "></asp:Label> 
                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtAddress" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator3" runat="server"   ErrorMessage="Please add address"></asp:RequiredFieldValidator>                  
                        <asp:TextBox ID="txtAddress"  placeholder="Delivery address "   runat="server" ToolTip="Optional"  class="form-control"   Height="70px"  TextMode="MultiLine"></asp:TextBox>  
                          
                    </div>   
                
           </asp:Panel>
        <div class="panel-footer" style="text-align:center">  
            <asp:Button ID="btnClosePayment" class="btn btn-danger btn-sm" runat="server" Text="Back" />      
            <asp:Button ID="bntPay" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vr12"  Text="Proceed to Checkout" OnClick="bntPay_Goclick" />                       
        </div>    
</asp:Panel>
</div>
    </div>
           
</asp:Content>

