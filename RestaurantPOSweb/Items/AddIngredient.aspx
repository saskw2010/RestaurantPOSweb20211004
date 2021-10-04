<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="AddIngredient.aspx.cs" Inherits="Items_AddIngredient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-lg-10 col-lg-offset-1" style="text-align:left"> 
        <div class="well well-sm"   >
            <asp:Button ID="btnAdd"  ValidationGroup="vlg656766" CssClass="btn btn-primary btn-xs" runat="server" Text="Add New Ingredient"  OnClick="btnAddnew_Click" />
        </div>
 
        <div class="panel panel-default"> 
        <div class="panel-heading"> 
             <div class="input-group">
               <span class="input-group-addon"> <span class="glyphicon glyphicon-search"> </span> </span>
               <asp:TextBox ID="txtsearch" class="form-control"   
                        ToolTip="Search by : Name"  Placeholder="Search" runat="server" AutoPostBack="True" 
                        ontextchanged="txtsearch_TextChanged"></asp:TextBox>                   
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button">Go</button>
                        </span>
            </div>
        </div>

            
                <div class="panel-body">
                        <div class="col-md-6">  
                            <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>
                        </div>                    
                        <div  class="col-md-6"> 
                            <asp:Label ID="Label6" runat="server" BackColor="Red" ForeColor="Red" Text="____:"></asp:Label> Very Low Qty Item 
                            <asp:Label ID="Label15" runat="server" BackColor="Yellow" ForeColor="Yellow" Text="____:"></asp:Label> Low Qty Item
                        </div>  
                     
                                   
                <asp:Panel ID="Panel1" runat="server"   class="col-md-12 box-body table-responsive no-padding"> 
                    <asp:GridView ID="grdvwList" runat="server" data-search="true" class="table table-hover"
                       Font-Size="11px" AllowPaging="True"  OnRowDataBound="grdvwList_RowDataBound"
                        onpageindexchanging="grdvwList_PageIndexChanging"  >
                      <Columns>
                          <asp:TemplateField HeaderText="Action" >
                                <ItemTemplate> 
                                    <asp:LinkButton ID="btnEdit" runat="server"  Font-Size="19px"  ForeColor="#FF5050"    ToolTip="Edit" class="glyphicon glyphicon-edit "     OnClick="LinkEdit_Click"   />  |   
                                     <asp:LinkButton ID="Linkban" runat="server" ForeColor="#FF5050"  Font-Size="17px"   OnClick="LinkbanCustomer_Click"  ToolTip="Delete this Address" class="glyphicon glyphicon-trash"  />                                 
                                </ItemTemplate>
                                <HeaderStyle Width="65" />
                          </asp:TemplateField>                       
                
                          </Columns>
                            <PagerSettings      FirstPageText="First" LastPageText="Last" 
                            Mode="NumericFirstLast" NextPageText="Next" PageButtonCount="10" PreviousPageText="Previous" Position="Top" />                                 
                            <PagerStyle Font-Bold="true" Font-Size="Large"    HorizontalAlign="Center" CssClass="pagination-ys"   />  
                        </asp:GridView>
                    </asp:Panel>
                </div>
         </div>
  
</div> 

<%--<<<<<<<<<<<<<<<<<<<<< --------------- Add / Edit  Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
        <asp:Button ID="btnShowPopup" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MpeEditShow" runat="server" TargetControlID="btnShowPopup" 
        PopupControlID="pnlpopupEditView"  CancelControlID="btnClose" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>
 
<asp:Panel ID="pnlpopupEditView"  class="panel panel-primary col-lg-4" runat="server" BackColor="White" style="display:none"  DefaultButton="btnSave"> 
  
              <div class="panel-heading">
                <asp:Label ID="lblID" runat="server" Text="0"></asp:Label>
                <asp:Label ID="lbllabelName" runat="server" Text="Edit  "></asp:Label>                                           
            </div>               
            <asp:Panel ID="Panel3" class="panel-body" runat="server"  style="text-align:left" >                
                    <asp:Label ID="Label16" runat="server" Text="Inventory Name*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtinvname" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator7" runat="server"   ErrorMessage="Please Insert item Name" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtinvname"   Placeholder="Name"  class="form-control"   runat="server" ></asp:TextBox>   

                    <asp:Label ID="Label17" runat="server" Text="Weight:"></asp:Label> 
                    <asp:Label ID="Label4" runat="server" Font-Size="10px" Text="Recipe weight per package "></asp:Label> 
                  <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtweight" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Please Insert Weight"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtweight"   Placeholder="Weight"    class="form-control"  runat="server" ></asp:TextBox> 

                     
                    <asp:Label ID="Label1" runat="server" Text="Unit*"></asp:Label>
                     <asp:DropDownList ID="ddluints" runat="server" class="form-control">
                        <asp:ListItem Value="KG"        Text="KG"></asp:ListItem>
                        <asp:ListItem Value="GM"        Text="Grams"></asp:ListItem>
                        <asp:ListItem Value="Litter"    Text="Litter"></asp:ListItem>
                        <asp:ListItem Value="Tonne"     Text="Tonne"></asp:ListItem>
                        <asp:ListItem Value="Ton"       Text="Ton"></asp:ListItem>
                        <asp:ListItem Value="Milligram" Text="Milligram"></asp:ListItem>
                        <asp:ListItem Value="Pound" Text="Pound"></asp:ListItem>
                        <asp:ListItem Value="Ounce" Text="Ounce"></asp:ListItem>
                        <asp:ListItem Value="Gallon" Text="Gallon"></asp:ListItem>
                        <asp:ListItem Value="Tea Spoon" Text="Tea Spoon"></asp:ListItem>
                        <asp:ListItem Value="Table Spoon" Text="Table Spoon"></asp:ListItem>
                        <asp:ListItem Value="Piece" Text="Piece"></asp:ListItem>
                        <asp:ListItem Value="Dozens" Text="Dozens"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:Label ID="Label37" runat="server" Text="Total Qty*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtqty" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator5" runat="server"   ErrorMessage="Please Insert Total Qty" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtqty"    class="form-control"  runat="server" > </asp:TextBox> 
                     
                   <asp:Label ID="Label2" runat="server" Text="Purchase Price*"></asp:Label>
                    <asp:Label ID="Label5" runat="server" Font-Size="10px" Text="Inventory price per package "></asp:Label> 
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtpurchaseprice" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator2" runat="server"   ErrorMessage="Please Insert Purchase price" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtpurchaseprice"    class="form-control"  runat="server" > </asp:TextBox> 
                    
                    <asp:Label ID="Label3" runat="server" Text="Vendor*"></asp:Label>
                     <asp:DropDownList ID="ddlvendor" runat="server" class="form-control"> 
                    </asp:DropDownList>

                    <asp:Label ID="lblmsg" runat="server" Font-Size="11px" ForeColor="Red" Text="-"></asp:Label><br />
                          
        </asp:Panel>   
        <div class="panel-footer">    
            <asp:Button ID="btnClose" class="btn btn-danger btn-sm" runat="server" Text="Close" />
            <asp:Button ID="btnSave" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vlpgDetails"   Text="Save"   onclick="btnSave_Click"  />
         
        </div>   
</asp:Panel>  
  
 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Edit   Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>


 <%--<<<<<<<<<<<<<<<<<<<<< --------------- Delete  Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
        <asp:Button ID="btnShowPopupInAct" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="ModalPopupInactive" runat="server" TargetControlID="btnShowPopupInAct" 
        PopupControlID="pnlpopupInactive"  CancelControlID="btnCloseInactive" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>
<div class="col-md-2">  
    <asp:Panel ID="pnlpopupInactive"  class="panel panel-danger" runat="server" BackColor="White" style="display:none"   DefaultButton="btnInactive"> 
        <div class="panel-heading" style="text-align:center">
            <asp:Label ID="lblInactiveID" runat="server" Text="0"></asp:Label>. 
            <asp:Label ID="lblInactiveCustName" runat="server" Text="-"></asp:Label>           
         </div>
                  
    <div  class="panel-body" >
            <asp:Label ID="Label7" runat="server"   Text="Do you want to delete?"></asp:Label> <br />
    </div>
    <div class="panel-footer">
           <asp:Button ID="btnCloseInactive" class="btn btn-danger btn-sm" runat="server" Text="No" /> 
           <asp:Button ID="btnInactive" class="btn btn-success btn-sm" runat="server"   Text="Yes"   onclick="btnInactive_Click"  />
            
     </div>
    </asp:Panel>
 </div>
</asp:Content>


