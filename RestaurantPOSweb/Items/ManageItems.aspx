<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ManageItems.aspx.cs" Inherits="ManageItems" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-10 col-lg-offset-1"> 
            <div class="well well-sm" > 
                <div class="col-lg-6">  
                     <asp:Button ID="btnItems" ValidationGroup="likgp"   CssClass="btn btn-warning btn-xs" ToolTip="Add new Item"  runat="server" Text="Add new Item"   PostBackUrl="~/Items/AddItem.aspx" />  |            
                     <asp:Button ID="Button1"  ValidationGroup="likgp"    CssClass="btn btn-success btn-xs" ToolTip="Bulk Item upload"  runat="server" Text="Bulk Item upload"   PostBackUrl="~/Items/UploadItems.aspx" />  |
                    <asp:Button ID="btnprint"  ValidationGroup="likgp"    runat="server" ToolTip="Print Stock Report" Text="Print" class="btn btn-info btn-xs" PostBackUrl="~/Report/StockItemReport.aspx" />
                </div>
                
               
                   <asp:Button ID="btnveryLow"  ValidationGroup="likgp"    runat="server" ToolTip="Very Low Quantity Items" Text="Very Low" OnClick="btnveryLow_Click" class="btn btn-danger btn-xs" />
                    <asp:Button ID="btnLowqty"  ValidationGroup="likgp"    runat="server" ToolTip="Low Quantity Items" Text="Low Qty item" OnClick="btnLowqty_Click" class="btn btn-success btn-xs" />
                    <asp:Button ID="btnExpireitem"  ValidationGroup="likgp"    runat="server" ToolTip="Expired Items" Text="Expired Items" OnClick="btnExpireitem_Click" class="btn btn-primary btn-xs" />
                 
                    <asp:Button ID="btnExporttoExcel"  ValidationGroup="likgp"    runat="server" ToolTip="Export Items" Text="Export To Excel" OnClick="btnExporttoExcel_Click" class="btn btn-info btn-xs" />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional"    ViewStateMode="Enabled">
                         
                    <Triggers>  
                        <asp:PostBackTrigger ControlID="btnExporttoExcel" />   
                    </Triggers>
                    </asp:UpdatePanel>

                    <atk:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtsearch"
                    MinimumPrefixLength="1" EnableCaching="true"      CompletionSetCount="1" CompletionInterval="100" 
                    ServiceMethod="GetMDN" FirstRowSelected="True">
                    </atk:AutoCompleteExtender>   
                              
            </div>
        </div> 

<div class="col-lg-10 col-lg-offset-1"> 
        <div class="panel panel-default" > 
            <div class="panel-heading">
          <%--  <span  class="glyphicon glyphicon-list"> </span> Items/Products list --%>
             <div class="input-group">
               <span class="input-group-addon"> <span class="glyphicon glyphicon-search"> </span> </span>
               <asp:TextBox ID="txtsearch" class="form-control"   
                        ToolTip="Search by : Code, Item Name, Purchase Price, Retail Price,Category" 
                        Placeholder="Search" runat="server" AutoPostBack="True" 
                        ontextchanged="txtsearch_TextChanged"></asp:TextBox>
            </div>
        </div>
                  
                <div class="panel-body">
                        <div class="col-md-6">  
                            <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>
                        </div>                    
                        <div  class="col-md-6"> 
                            <asp:Label ID="Label1" runat="server" BackColor="Red" ForeColor="Red" Text="____:"></asp:Label> Very Low Qty Item 
                            <asp:Label ID="Label15" runat="server" BackColor="Yellow" ForeColor="Yellow" Text="____:"></asp:Label> Low Qty Item
                        </div>

                        <asp:Panel ID="Panel1"   class="col-md-12" runat="server" ScrollBars="Vertical" Height="400px">                   
                        <asp:GridView ID="grdItemList" runat="server"   class="table table-striped table-hover" 
                           OnRowDataBound="grdItemList_RowDataBound"  Font-Size="11px">
                          <Columns>
                              <asp:TemplateField HeaderText="Action" HeaderStyle-Width="180px">
                                    <ItemTemplate> 
                                      <asp:LinkButton    ID="LinkEdit" runat="server"  Font-Size="15px"   ToolTip="Edit" class="glyphicon glyphicon-edit"  OnClick="LinkEdit_Click" />  |
                                        <asp:LinkButton     ID="linkBarcode" runat="server" ForeColor="#FF6600"  Font-Size="15px"     ToolTip="Create Bar-code" class="glyphicon glyphicon-barcode" OnClick="LinkBarcode_Click"  /> |                                  
                                        <asp:LinkButton ID="lnkaddingredients" runat="server" ForeColor="#FF6600"   Font-Size="15px"   ToolTip="Add ingredients" class="glyphicon glyphicon-plus"  OnClick="lnkaddingredients_Click"  /> |
                                        <asp:LinkButton ID="btnDelete" runat="server" ForeColor="#FF6600"   Font-Size="15px"   ToolTip="Delete" class="glyphicon glyphicon-trash"  OnClick="LinkItemsDelete_Click"  />
                                      <%-- <asp:Image ID="imgItemPic"  Height="40px" Width="40px"  runat="server"  ImageUrl='<%# Eval("Photo")%>' /> --%>
  
                                     </ItemTemplate>
                                    <HeaderStyle Width="105px" />
                              </asp:TemplateField>                             
                              </Columns>                           
          
                        </asp:GridView>
                    </asp:Panel>
                </div>
         </div>
</div>

<%--<<<<<<<<<<<<<<<<<<<<< --------------- Edit Item Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
        <asp:Button ID="btnShowPopup" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MpeEditItemShow" runat="server" TargetControlID="btnShowPopup" 
        PopupControlID="pnlpopupEditItemView"  CancelControlID="btnClose" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:UpdatePanel ID="UpdatePanelImageUpload" runat="server"  UpdateMode="Conditional">
            <ContentTemplate> 

<asp:Panel ID="pnlpopupEditItemView"  class="panel panel-primary" runat="server" BackColor="White" style="display:none" DefaultButton="btnUpdate" > 
      <div class="panel-heading" style="text-align:left"> 
          <asp:Label ID="lblItemID" runat="server" Text="Label"></asp:Label>:     
            <asp:Label ID="lblitemName" runat="server" Text="Label"></asp:Label>                             
        </div>
               
    <div class="panel-body" style="text-align:left">        
               
               <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label> 
              <br />
            <asp:Panel ID="Panel2" runat="server" ScrollBars="Vertical" Height="400px">
                        <div class="col-lg-6">
                                <asp:Label ID="Label2" runat="server" Font-Size="12px" Text="Item Code"></asp:Label> 
                                <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtProductCode" runat="server"  ErrorMessage="*"    SetFocusOnError="True"></asp:RequiredFieldValidator>                  
                                <asp:TextBox  ReadOnly="true"  ID="txtProductCode"  ValidationGroup="vlpg43" CssClass="form-control" runat="server"></asp:TextBox> 

                                <asp:Label ID="Label3" runat="server" Font-Size="12px" Text="Item Name"></asp:Label> 
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemName" runat="server" ErrorMessage="*"    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtItemName"    ValidationGroup="vlpg43" CssClass="form-control"  runat="server"></asp:TextBox> 

                                <asp:Label ID="Label10" runat="server"  Font-Size="12px" Text="Description" ></asp:Label>                              
                                <asp:TextBox  placeholder="items Description" CssClass="form-control" ToolTip="Insert item description details"  ID="txtdescription" TextMode="MultiLine"   ValidationGroup="vlpg43" runat="server"></asp:TextBox>

                                <asp:Label ID="Label11" runat="server"  Font-Size="12px" Text="Options"></asp:Label>                            
                                <asp:TextBox  placeholder="Milk, Cream, Sugar" CssClass="form-control"  ToolTip="Insert Sizes with comma seperate"  ID="txtoptions"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                                
                                <br /> *<asp:Label ID="Label12" runat="server" Text="Insert with Comma seperate Like: Milk, Cream, Sugar" ForeColor="Red" Font-Size="9"></asp:Label>
                              
                                <asp:Label ID="Label7" runat="server"  Font-Size="12px" Text="Item Category"></asp:Label> <br />
                                <p><asp:DropDownList ID="DDLCategory" CssClass="form-control"     ValidationGroup="vlpg43" runat="server"></asp:DropDownList></p>
                             
                                <asp:Label ID="Label13" runat="server"  Font-Size="12px" Text="Manufacturing Date"></asp:Label> 
                                <atk:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtmdate" />
                                <asp:TextBox ID="txtmdate" runat="server" class="form-control" ToolTip="Manufacturing Date"  placeholder="yyyy-MM-dd"  ></asp:TextBox>
                            
                                <asp:Label ID="Label14" runat="server"  Font-Size="12px" Text="Expire Date"></asp:Label> 
                                <atk:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txtedate" />
                                <asp:TextBox ID="txtedate" runat="server" class="form-control" ToolTip="Expire Date"  placeholder="yyyy-MM-dd"  ></asp:TextBox>
                    
                        </div>
                        <div class="col-lg-6">  
                                <asp:Label ID="Label4" runat="server"  Font-Size="12px" Text="Purchase Price"></asp:Label> 
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtpurchasePrice" runat="server" ErrorMessage="*"    SetFocusOnError="True"></asp:RequiredFieldValidator>   
                                <asp:TextBox ID="txtPurchasePrice"  CssClass="form-control"  ValidationGroup="vlpg43"  runat="server"></asp:TextBox>             

                                <asp:Label ID="Label6" runat="server"  Font-Size="12px" Text="Retail Price"></asp:Label> 
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtRetailPrice" runat="server" ErrorMessage="*"    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtRetailPrice"  CssClass="form-control"   ValidationGroup="vlpg43" runat="server"></asp:TextBox> 

                                <asp:Label ID="Label9" runat="server"  Font-Size="12px" Text="Item Qutantity"></asp:Label> 
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemQty" runat="server" ErrorMessage="*"    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtItemQty"   CssClass="form-control"  ToolTip="add Item Qutantity e.g: 10"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                               
                                 
                                <asp:Label ID="Label5" runat="server"  Font-Size="12px" Text="Item Discount Rate"></asp:Label>  
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemDiscRate" runat="server" ErrorMessage="*"    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtItemDiscRate" CssClass="form-control"    ToolTip="Disc Rate without % sign" placeholder="Disc Rate without % sign"   ValidationGroup="vlpg43" Text="0.00"  runat="server"></asp:TextBox>
                                
                            <br />                          
                                <asp:CheckBox ID="chkkditem"  runat="server" Text="Is it kitchecn item?" /> <br />  
  
                            <asp:Image ID="imgItemPhoto" class="img-thumbnail" Height="120px" Width="150px"   runat="server"   /><br /> 
                            .jpg and .png  only 
                            <br />  <br />  <asp:FileUpload ID="FUpimg"   class="btn btn-success btn-sm"  runat="server"  Width="190px" />
                            <br />
                            <asp:Label ID="lblmsg" runat="server" Style="font-family: Arial; font-size: small;"></asp:Label>
                                                       
                         
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ErrorMessage="Please add decimal value e.g: 20.11 or 20" ForeColor="Red" 
                            ControlToValidate="txtpurchasePrice" ValidationGroup="vlpg43" 
                           ValidationExpression="^[0-9][\.\d]*(,\d+)?$"     SetFocusOnError="True"></asp:RegularExpressionValidator>  <br /> 

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                            ErrorMessage="Please add decimal value" ForeColor="Red"  ControlToValidate="txtRetailPrice" ValidationGroup="vlpg43" 
                            ValidationExpression="^[0-9][\.\d]*(,\d+)?$"    SetFocusOnError="True"></asp:RegularExpressionValidator>  <br /> 

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                            ErrorMessage="Please add decimal value" ForeColor="Red"  ControlToValidate="txtItemQty" ValidationGroup="vlpg43" 
                            ValidationExpression="^[0-9][\.\d]*(,\d+)?$"    SetFocusOnError="True"></asp:RegularExpressionValidator>  <br /> 

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                            ErrorMessage="Please  add  Item Discount Rate" ForeColor="Red"  ControlToValidate="txtItemDiscRate" ValidationGroup="vlpg43" 
                            Display="Dynamic" ValidationExpression="^[0-9][\.\d]*(,\d+)?$"    SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </div> 
            </asp:Panel>

    </div>
 
         <%-- <iframe style=" width:1240px; height:440px;" id="IframeUpdateItem" src="" runat="server"></iframe> --%>  

    <div class="panel-footer">     
      <asp:Button ID="btnUpdate" runat="server" class="btn btn-success btn-sm"   ValidationGroup="vlpg43"  Text="Update" onclick="btnUpdate_Click" />                            
        <asp:Button ID="btnClose" class="btn btn-danger btn-sm" runat="server" Text="Close" />
    </div>  
 </asp:Panel> 

   </ContentTemplate>   
                   <Triggers> <asp:PostBackTrigger   ControlID="btnUpdate"/></Triggers>                   
            </asp:UpdatePanel>

 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Edit Item Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>


 
 <%--<<<<<<<<<<<<<<<<<<<<< --------------- Inactive user  Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
        <asp:Button ID="btnShowPopupDeleteItem" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="ModalPopupDeleteItem" runat="server" TargetControlID="btnShowPopupDeleteItem" 
        PopupControlID="pnlpopupDeleteItem"  CancelControlID="btnCloseDeleteItem" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupDeleteItem"  class="panel panel-primary" runat="server" BackColor="White" style="display:none"  Width="300px"  DefaultButton="btnDeleteItem"> 
  <asp:Label ID="Label8" runat="server" class="label label-info" Text="Do you want to Delete this Item ?"> </asp:Label>   
  <hr /> 
   <asp:Label ID="lblCodeDeleteItem" runat="server" Text="0"></asp:Label>. 
    <asp:Label ID="lblDeleteItem_CustName" runat="server" Text="0"></asp:Label>  <br />
        <div class="panel-footer"> 
                <asp:Button ID="btnCloseDeleteItem" class="btn btn-danger btn-sm" runat="server" Text="No" />
                <asp:Button ID="btnDeleteItem" class="btn btn-success btn-sm" runat="server"   Text="Yes"   onclick="btnDeleteItem_Click"  />
        </div>
</asp:Panel>


        
 <%-- /////////////////////////// Start /////////////////////  Barcode creator ///////////////////////////////// ///////////////////// Start --%>
          <asp:Button ID="btnShowBarcodePopup" runat="server" style="display:none" />
         
        <atk:ModalPopupExtender ID="ModalPopupBarcodePanel" runat="server" TargetControlID="btnShowBarcodePopup" PopupControlID="popupBarcodePanel"
            CancelControlID="btnBarcodeCancel" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

 <asp:Panel ID="popupBarcodePanel"  class="panel panel-primary" runat="server" BackColor="White" style="display:none"  Width="760px" >
                <div class="panel-heading">                     
                    Barcode: <asp:Label ID="lblBarcodeID" Font-Bold="true"   runat="server" Text="0"></asp:Label>              
                   
                 </div>     
                 <div class="panel-body" style="text-align:left">
                <iframe style=" width: 740px; height: 470px;" id="Iframebarcode" src="" runat="server"></iframe> 
                </div>
        <div class="panel-footer">
          <asp:LinkButton ID="btnBarcodeCancel" runat="server"   class="btn btn-danger btn-sm"   >Close</asp:LinkButton> 
        </div>
 </asp:Panel>   
 


     <%-- /////////////////////////// Start /////////////////////  Ingredients  ///////////////////////////////// ///////////////////// Start --%>
  
        <asp:Button ID="btnShowIngredientsPopup" runat="server" style="display:none" />
         
        <atk:ModalPopupExtender ID="ModalPopupIngredientsPanel" runat="server" TargetControlID="btnShowIngredientsPopup" PopupControlID="popupIngredientsPanel"
            CancelControlID="btnIngredientsCancel" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

    <asp:Panel ID="popupIngredientsPanel"  class="panel panel-primary col-lg-6" runat="server" BackColor="White" style="display:none" >
                        <div class="panel-heading">                     
                         Add Ingredient: <asp:Label ID="lblItemIDingred" Font-Bold="true"   runat="server" Text="0"></asp:Label>    
                            <asp:Label ID="lblitemnamingred" Font-Bold="true"   runat="server" Text="0"></asp:Label>            
                   
                         </div>     
                         <div class="panel-body" >
                                <asp:Panel ID="Panel3" runat="server"  ScrollBars="Vertical" Height="200px"> 
                                <asp:GridView ID="grdIngredients" runat="server" data-search="true" class="table table-hover"
                                   Font-Size="11px"   >
                                  <Columns>
                                      <asp:TemplateField HeaderText="Action" >
                                            <ItemTemplate> 
                                                 <asp:LinkButton ID="LinkdeleteIngrad" runat="server" ForeColor="Red"  Font-Size="17px"   ToolTip="Delete this Address" class="glyphicon glyphicon-trash" OnClick="LinkdeleteIngrad_Click"  />                                 
                                            </ItemTemplate>
                                            <HeaderStyle Width="45" />
                                      </asp:TemplateField>   
                                      </Columns> 
                                    </asp:GridView>
                                </asp:Panel><hr />
                             Add Ingredient
                             <asp:DropDownList ID="ddlIngredients" runat="server"  CssClass="form-control" ValidationGroup="vlpgingredients" ></asp:DropDownList> 
                             <asp:TextBox ID="txtuseqty" runat="server" placeholder="Use Qty" CssClass="form-control" ValidationGroup="vlpgingredients" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7sd" ValidationGroup="vlpgingredients"   ForeColor="Red" 
                                 ControlToValidate="txtuseqty" runat="server" ErrorMessage="Please insert how many qty Deduct per package"    SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </div>
                <div class="panel-footer">
                  <asp:LinkButton ID="btnIngredientsCancel" runat="server"   class="btn btn-danger btn-sm"   >Close</asp:LinkButton> 
                  <asp:Button ID="btnIngredientsAddnew" class="btn btn-success btn-sm" runat="server"  ValidationGroup="vlpgingredients"   Text="Yes"   onclick="btnIngredientsAddnew_Click"  />
                </div>
         </asp:Panel>  

</asp:Content>

