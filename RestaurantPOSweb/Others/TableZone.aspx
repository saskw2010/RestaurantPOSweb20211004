<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="TableZone.aspx.cs" Inherits="Other_TableZone" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-lg-8 col-lg-offset-2" style="text-align:left"> 
        <div class="well well-sm"   >
            <asp:Button ID="btnAddAddress"  ValidationGroup="vlg656766" CssClass="btn btn-primary btn-xs" runat="server" Text="Add New Table"  OnClick="btnAddnew_Click" />
        </div>
 
        <div class="panel panel-success"> 
            <div class="panel-heading"    style="text-align:center" ><span  class="fa fa-list"> </span> Table list </div>
                <div class="panel-body">
                    <asp:Label ID="lbtotalRow" runat="server" Text=""></asp:Label>  <br />   
                     
                                   
                <asp:Panel ID="Panel1" runat="server"  class="box-body table-responsive no-padding"> 
                    <asp:GridView ID="grdvwList" runat="server" data-search="true" class="table table-hover"
                       Font-Size="11px" AllowPaging="True" 
                        onpageindexchanging="grdvwAddressList_PageIndexChanging"  >
                      <Columns>
                          <asp:TemplateField HeaderText="Action" >
                                <ItemTemplate> 
                                    <asp:LinkButton ID="btnEdit" runat="server"  Font-Size="19px"  ForeColor="Red"    ToolTip="Edit" class="glyphicon glyphicon-edit "     OnClick="LinkEdit_Click"   />  |   
                                     <asp:LinkButton ID="Linkban" runat="server" ForeColor="Red"  Font-Size="17px"   OnClick="LinkbanCustomer_Click"  ToolTip="Delete this Address" class="glyphicon glyphicon-trash"  />                                 
                                </ItemTemplate>
                                <HeaderStyle Width="65" />
                          </asp:TemplateField>                       
                
                          </Columns>
                            <PagerSettings      FirstPageText="First" LastPageText="Last" 
                            Mode="NumericFirstLast" NextPageText="Next" PageButtonCount="10" PreviousPageText="Previous" />                                 
                            <PagerStyle Font-Bold="true" Font-Size="Large"    HorizontalAlign="Center"   CssClass="pagination-ys"   />  
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
                <asp:Label ID="lbllabelName" runat="server" Text="Edit Address"></asp:Label>                                           
            </div>               
            <asp:Panel ID="Panel3" class="panel-body" runat="server"  style="text-align:left" >                
                    <asp:Label ID="Label16" runat="server" Text="Table Name*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txttablename" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator7" runat="server"   ErrorMessage="Please Insert Table Name"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txttablename"   Placeholder="TAB-001"  class="form-control"   runat="server" ></asp:TextBox>   

                    <asp:Label ID="Label17" runat="server" Text="Zone:"></asp:Label> 
                  <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txttablename" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Please Insert Zone Name"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtzone"   Placeholder="Zone Name"    class="form-control"  runat="server" ></asp:TextBox> 

                     
                    <asp:Label ID="Label1" runat="server" Text="Seat Qty*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtseatqty" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator1222" runat="server"   ErrorMessage="Please enter Seat Quantity" > </asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtseatqty" class="form-control"  Placeholder="6"   runat="server"  > </asp:TextBox>

                    <asp:Label ID="Label37" runat="server" Text="Table order*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtorderno" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator5" runat="server"   ErrorMessage="Please Insert Order No"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtorderno"    class="form-control"  runat="server" > </asp:TextBox> 
                     
                   <asp:Label ID="Label2" runat="server" Text="Table Color*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtfillcolor" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator2" runat="server"   ErrorMessage="Please Insert Table Color"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtfillcolor"    class="form-control"  runat="server" > </asp:TextBox> 
                    <atk:ColorPickerExtender       ID="txtCardColor_ColorPickerExtender"  TargetControlID="txtfillcolor"   Enabled="True"   runat="server">
                    </atk:ColorPickerExtender>

                    <asp:Label ID="lblmsg" runat="server" Font-Size="11px" ForeColor="Red" Text="-"></asp:Label><br />
                          
        </asp:Panel>   
        <div class="panel-footer">    
            <asp:Button ID="btnClose" class="btn btn-danger btn-sm" runat="server" Text="Close" />
            <asp:Button ID="btnSave" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vlpgDetails"   Text="Save"   onclick="btnSave_Click"  />
         
        </div>   
</asp:Panel>  
  
 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Edit   Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>


 <%--<<<<<<<<<<<<<<<<<<<<< --------------- Inactive user  Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
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
            <asp:Label ID="Label7" runat="server"   Text="Do you want to delete this Table?"></asp:Label> <br />
    </div>
    <div class="panel-footer">
           <asp:Button ID="btnCloseInactive" class="btn btn-danger btn-sm" runat="server" Text="No" /> 
           <asp:Button ID="btnInactive" class="btn btn-success btn-sm" runat="server"   Text="Yes"   onclick="btnInactive_Click"  />
            
     </div>
    </asp:Panel>
 </div>
</asp:Content>


