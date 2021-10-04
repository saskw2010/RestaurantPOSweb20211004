<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Master_Ft_page.master" AutoEventWireup="true" CodeFile="itemmoreview.aspx.cs" Inherits="itemmoreview" enableEventValidation="false" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
 </asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 <div class="container"> 
        <header class="section-header">
          <h3 class="section-title">Our Items</h3>
        </header>  


  <%-----------------------------    Category --------------------------------Start--------- --%>
        <div class="col-lg-12">  
            <asp:DataList ID="dtlistcategory" runat="server" Font-Names="Verdana" Font-Size="Small" RepeatLayout="Flow"    RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                   <ItemTemplate>
                    <div class="col-sm-1"> 
                        <div id="pricePlanmsg">
                            <ul id="plans">
                                <li class="plan" >                                                             
                                        <ul class="planContainer"> 
                                            <li class="title">
                                                <asp:LinkButton CssClass="btn btn-success" ID="lnkCategory" runat="server" Text='<%# Bind("ItemCategory") %>'  OnClick="lnkCategory_Onclick"  Font-Size="11" ForeColor="White" > </asp:LinkButton> 
                                                <asp:Label   ID="lblcategid" Font-Size="13px" runat="server" Text='<%# Bind("ItemCategory") %>' Visible="False"></asp:Label> 
                                            </li>
                                        </ul>                               
                                </li>
                            </ul>
                        </div> 
                     </div>                   
                </ItemTemplate>
            </asp:DataList>             
        </div> 
   <%----------------------------------------- Category END ---------------------------------------%>
<div class="row">
            <div class="col-md-12"> <br />  
                <div class="form-group">      
                    <div class="input-group"> 
                                                        
                        <asp:TextBox ID="txtSearch" Font-Size="15px"  class="form-control" ToolTip="Search by item name, category... " 
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
                                <li class="plan" style="width:225px">                                                             
                                        <ul class="planContainer"> 
                                            <li class="title">
                                                        <asp:Label ID="LblID" Visible="false" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                                        <asp:Label ID="LblCode" Visible="false" runat="server" Text='<%# Eval("Code") %>'></asp:Label>                                                         
                                                        <asp:Label ID="lblproductnameDetails" Visible="false" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label> 
                                                        <asp:Label ID="LblQty" Visible="false" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                                                        <asp:Label  Visible="false"  ID="lblcategoryid" runat="server" Text='<%# Bind("ItemCategory") %>'></asp:Label>
                                                        <asp:Label  Visible="false"  ID="Lbloptions" runat="server" Text='<%# Bind("options") %>' ></asp:Label>                                              
                                                        <asp:Label ID="lblDescriptions" Visible="false" runat="server" Text='<%# Eval("description") %>'></asp:Label>  
                                                        <asp:Label ID="Lblkditem" Visible="false" runat="server" Text='<%# Eval("kditem") %>'></asp:Label>   
                                                        <asp:HyperLink ID="HyperLink2" ToolTip="Show Details" Target="_blank"   runat="server" NavigateUrl='<%# string.Format("DetailsView.aspx?pid={0}&cid={1}", Eval("id"),Eval("ItemCategory")) %>'>       
                                                        <asp:Label   ID="lblitemname" Font-Size="14px" Font-Bold="true" runat="server" Text='<%# Bind("ItemName") %>' ForeColor="#ff3399"></asp:Label> 
                                                        </asp:HyperLink>
                                            </li>
                                            <li class="title">                      
                                                    <asp:HyperLink ID="HyperLink1" ToolTip="Show Details"   runat="server"  NavigateUrl='<%# string.Format("DetailsView.aspx?pid={0}&cid={1}", Eval("id"),Eval("ItemCategory")) %>' >     
                                                    <asp:Image  ID="imgPhoto" ToolTip='<%# Bind("ItemName") %>' runat="server"  class="img-thumbnail2"   Width="96px" Height="96px"   ImageUrl='<%# Eval("Photo") %>' /> <br />
                                                   </asp:HyperLink>
                                                     
                                            </li>
                                            <li>
                                                 <ul class="options">                                      
                                                   <li>
                                                        <asp:Label ID="LblDisc"   ForeColor="#999999" runat="server" Text='<%# Eval("Disc") %>' Font-Size="11"></asp:Label>% OFF  
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
          
        </asp:Panel>
<%--------------------------------    Product List ----------------------------END----------%>

<%----------------------------------   Cart item   ---------------------------- Start ----------%> 
 <asp:Panel ID="pnlCartPanel"  class="col-md-6"  runat="server">  
        <div class="panel panel-default">  
            <div class="panel-heading"> 
                <h4>Your Order </h4>
            </div> 
        <div class="panel-body">  
                       
        <asp:DataList ID="dtlistcartitems" runat="server" Font-Names="Verdana" Font-Size="Small"   RepeatLayout="Flow"   RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                <ItemTemplate>                     
                    <div class="col-md-12">  
                        <div id="pricePlansmsgaa">                    
                            <ul id="plans"> 
                                <li class="plan">                                                                 
                                        <ul class="planContainer"> 
                                            <div class="row">  
                                                <div class="col-md-2"> <br />                                          
                                                       <asp:Image ID="imgPhoto" ToolTip='<%# Bind("ItemName") %>' runat="server" class="img-circle"  Width="40px" Height="40px"   ImageUrl='<%# Bind("image") %>' /> <br />
                                           
                                                </div> 
                                                <div class="col-md-5" style="text-align:left"> <br />
                                                           <asp:Label  Visible="false"  ID="lblpid" runat="server" Text='<%# Bind("Code") %>'></asp:Label> 
                                                            <asp:Label ID="Lblkditem" Visible="false" runat="server" Text='<%# Eval("kditem") %>'></asp:Label> 
                                                            <asp:Label ID="LblPrice" Visible="false" runat="server" Text='<%# Eval("Price") %>'></asp:Label> 
                                                            <asp:Label ID="LblDescriptions" Visible="false" runat="server" Text='<%# Eval("Total") %>'></asp:Label>                                                
                                                            <asp:Label ForeColor="Black"  ToolTip="Qty"    Font-Bold="true" ID="Label1" runat="server" Text='<%# Bind("Qty") %>'></asp:Label> -
                                                           <asp:Label   ID="lblitemname" Font-Size="12px" runat="server" Text='<%# Bind("ItemName") %>' ForeColor="#0084B4"></asp:Label> <br />
                                                            Options:<asp:Label ForeColor="Black"  ToolTip="Size"    Font-Bold="true" ID="Label3" runat="server" Text='<%# Bind("Options") %>'></asp:Label>    <br /> 
                                                
                                                </div>  
                                                <div class="col-md-4" style="text-align:right">  <br />  
                                                    <asp:Label ID="Label16" runat="server" Text=" OFF" Font-Size="5"></asp:Label> 
                                                    <asp:Label ForeColor="Silver"   ID="Label15" runat="server" Text='<%# Bind("Disc") %>' Font-Size="9"></asp:Label>%    
                                            
                                                  <asp:Label ForeColor="Black"  ToolTip="Price"    Font-Bold="true" ID="Label9" runat="server" Text='<%# Bind("Total") %>' Font-Size="13px"></asp:Label>   
                                              
                                                </div>  
                                                <div class="col-md-1" style="text-align:right"> <br /> <br />  
                                                <asp:LinkButton  ID="LinkDele" runat="server" ForeColor="Red"    Font-Size="19px"    ToolTip="Remove item" class="fa fa-times" OnClick="btnDeleteitem_Click"     />                                                  
                                                  
                                                 </div>                                  
                                        </div><hr /> 
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
                        (<asp:Label ID="lblVatRate" Font-Size="9px" runat="server" Text="0"></asp:Label>% ) =
                        <asp:Label ID="lblVatAmount"  Font-Size="12px"  runat="server" Text="0"></asp:Label><br /> 
                         Shipping = <asp:Label ID="lblshippingcost" runat="server"  Text="0"></asp:Label><br /> 
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
 
 <%--<<<<<<<<<<<<<<<<<<<<< --------------- Options  panel Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>  ScrollBars="Vertical" Height="440px" >>>>>--%>
    <asp:Button ID="btnshowOptins" runat="server" style="display:none"   />      
    <atk:ModalPopupExtender ID="ModalPopupOptions" runat="server" TargetControlID="btnshowOptins"  BehaviorID="mdlpopup"   PopupControlID="pnloptionspopup"  CancelControlID="btncloseOptionsPopup" BackgroundCssClass="modalBackground" >
    </atk:ModalPopupExtender>
<asp:Panel ID="pnloptionspopup"  class="panel panel-default" runat="server" BackColor="White" style="display:none;text-align:left; overflow: hidden"   > 
     
            <div class="panel-heading" style="text-align:left"> 
                    <span class="fa fa-check" style="font-size: 25px"></span> 
                    <asp:Label ID="Label14" runat="server" Font-Size="15px" Text="  Select your Options"></asp:Label>  |  
                    <asp:Label ID="Label4" runat="server"   Font-Size="12px" Text="Kitchen item:"></asp:Label>
                    <asp:Label ID="lblkditem" runat="server"   Font-Size="12px" Text="NO"></asp:Label>
            </div>
            <asp:Panel ID="Panel2"  CssClass="panel-body row"    runat="server" ScrollBars="Vertical"  Height="430px"> 
                                   
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
                                <div class="col-md-12 panel-body">                            
                                    <br/>   Sauce Options<br/>
                                    <asp:CheckBoxList ID="chkoptionslist" class="table-hover" runat="server"  CellPadding="5" 
                                    CellSpacing="5"   Font-Size="13" />  
                                </div>       
                    </asp:Panel>
    <div class="panel-footer" style="text-align:center">  

                <asp:Button ID="btncloseOptionsPopup" class="btn btn-danger btn-sm" runat="server"  data-dismiss="modal" Text="Keep Browsing"    />  
           <asp:Button ID="btn_GoAddtocart" class="btn btn-primary btn-sm" runat="server"  Text="Add To cart" OnClick="btn_Goclick"  /> 
    </div> 
</asp:Panel>
    
               
               
    
 <%--<<<<<<<<<<<<<<<<<<<<< --------------- payment panel Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
     <asp:Button ID="btnShowPopup" runat="server" style="display:none" />      
    <atk:ModalPopupExtender ID="ModalPopupPayment" runat="server" TargetControlID="btnShowPopup" 
    PopupControlID="pnlpopupPayment"  CancelControlID="btnClosePayment" BackgroundCssClass="modalBackground">
    </atk:ModalPopupExtender>

<div class="col-md-8">
    <asp:Panel ID="pnlpopupPayment"   runat="server" class="panel panel-primary "  BackColor="White" style="display:none;text-align:left"  DefaultButton="bntPay" > 
         <div class="panel-heading" style="text-align:left"> 
             <asp:Label ID="Label2" runat="server" Font-Size="19px" Text="  Payment"></asp:Label> 
             <asp:Label ID="lblcustomerid"  runat="server" Font-Size="1"   Text="0000"></asp:Label> 
        </div>
        <asp:Panel ID="pnBody" CssClass="panel-body row"  runat="server" >  
                    
                    <div class="col-md-6"> 
                            <asp:Label ID="Label3" runat="server"   Text="Order info"></asp:Label>    <br />
                     
                            Total Payable:                               
                            <asp:Label ID="lbltotalpay" runat="server" Font-Bold="true" Font-Size="15px"  Text="-"></asp:Label>  <br />
                        
                        <br />
                            <asp:Label ID="Label5" runat="server" ToolTip="Optional" Text="Note/Condition "></asp:Label>  
                                <asp:Label ID="Label6" runat="server" Font-Size="10px" ToolTip="Optional" Text="Optional"></asp:Label>
                        <br />
                        <asp:TextBox ID="txtNote"  placeholder="Note"   runat="server" ToolTip="Optional"  Height="140px"  class="form-controlTK"  TextMode="MultiLine"></asp:TextBox>                 
                     </div>

                    <div class="col-md-6"> 
                        <asp:Label ID="Label10" runat="server"   Text="Customer Address"></asp:Label>    <br />

                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtcustomername" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Add Customer name" SetFocusOnError="true"></asp:RequiredFieldValidator>       <br />                   
                        <asp:Label ID="Label11" runat="server" Font-Size="12px" ToolTip="Add Customer name" Text="Customer name"></asp:Label>     
                        <asp:TextBox ID="txtcustomername"  placeholder="name"   runat="server" ToolTip="Customer name"   class="form-controlTK" ></asp:TextBox>  

                        <asp:Label ID="Label13" runat="server" Font-Size="12px"  ToolTip="Add Customer Phone" Text="Phone"></asp:Label>    
                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtphone" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator2" runat="server"   ErrorMessage="Please add Customer Phone" SetFocusOnError ="true"></asp:RequiredFieldValidator>       <br />                  
                        <asp:TextBox ID="txtphone"  placeholder="Phone"   runat="server" ToolTip="Customer Phone"    class="form-controlTK" ></asp:TextBox> 
                     

                        <asp:Label ID="Label12" runat="server" Font-Size="12px"  ToolTip="Delivery Address" Text="Address: "></asp:Label> 
                        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtAddress" ValidationGroup="vr12"  Font-Size="11px" 
                        ID="RequiredFieldValidator3" runat="server"   ErrorMessage="Please add address" SetFocusOnError ="true"></asp:RequiredFieldValidator>                  
                        <asp:TextBox ID="txtAddress"  placeholder="Delivery address "   runat="server" ToolTip="Optional"    class="form-control"  Height="70px"  TextMode="MultiLine"></asp:TextBox>  
                          
                    </div>   
                 
           </asp:Panel>
        <div class="panel-footer" style="text-align:center">  
            <asp:Button ID="btnClosePayment" class="btn btn-danger btn-sm" runat="server" Text="Back" />     
            <asp:Button ID="btnhereserve" class="btn btn-navypub btn-sm" runat="server"  ValidationGroup="vlgrphere"  Text="Serve here" OnClick="btnhereserve_Click" />   
            <asp:Button ID="bntPay" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vr12"  Text="Proceed to Checkout" OnClick="bntPay_Goclick" />                       
        </div>    
</asp:Panel>
    </div>
</div>
</div>
</asp:Content>

