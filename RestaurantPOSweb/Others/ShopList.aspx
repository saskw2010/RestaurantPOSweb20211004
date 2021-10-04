<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ShopList.aspx.cs" Inherits="Settings_ShopList" %>
 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <br />
 <div class="col-lg-9 col-lg-offset-1">
       <div class="panel panel-warning"  >
            <div class="panel-heading" >
            <asp:Button ID="btnAddShopNameLink" class="btn btn-info btn-xs"  runat="server"  ValidationGroup="vlgp12144"  Text="Add New Terminal" onclick="btnShopLink_Click" />     
           <span  style="padding-left:380px" class="fa fa-list"> </span> Terminal list  
           </div>
                <div class="panel-body">
                <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>
                     <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="390px">
                      <asp:GridView ID="grdShopList" runat="server" class="table table-striped table-hover" Font-Size="11px">
                      <Columns>
                          <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>                          
                                    <asp:LinkButton ID="LinkDelete" runat="server"  ForeColor="Red"   Font-Size="15px"   ToolTip="Delete" class="glyphicon glyphicon-remove"    OnClick="LinkDelete_Click"        />  
                                </ItemTemplate>
                          </asp:TemplateField>                     
                          </Columns>
                      </asp:GridView>
                  </asp:Panel>
                </div>
       </div>
</div>


<%--<<<<<<<<<<<<<<<<<<<<< ---------------Add Category Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
<asp:Button ID="btnShowPopup" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MpeAddCategoryShow" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopupAddCategoryView"
            CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupAddCategoryView"  class="panel panel-primary"  runat="server" BackColor="White" style="display:none"  Width="400px" DefaultButton="btnSubmit"> 
      <div class="panel-heading"> 
             Add Terminal             
                <asp:LinkButton ID="btnCancel" runat="server"  ForeColor="#FFFFCC" class="btn btn-Default btn-xs" data-dismiss="alert" >X</asp:LinkButton>                              
       </div>
               
    <div class="panel-body" style="text-align:left">    
        
                        <asp:Label ID="Label2" runat="server" Font-Size="12px"   Text="Terminal ID"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtTerminalID" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox  ID="txtTerminalID" placeholder="Ex: QCMT02" ToolTip="Please Enter Terminal ID" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 

                        <asp:Label ID="Label1" runat="server" Font-Size="12px"  Text="Location"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtLocation" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox  ID="txtLocation" ToolTip="Please Enter Location" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 

                        <asp:Label ID="Label3" runat="server" Font-Size="12px"  Text="Phone No"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtPhone" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox  ID="txtPhone" ToolTip="Please Enter Phone NO" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 

                        <asp:Label ID="Label4" runat="server" Font-Size="12px"  Text="Email Address"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtEmailAddress" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="vlpg43" ForeColor="Red" 
                        runat="server" ErrorMessage="Please Enter valid Email address"  
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        ControlToValidate="txtEmailAddress"></asp:RegularExpressionValidator><br />
                        <asp:TextBox  ID="txtEmailAddress" placeholder="yourmail@gmail.com" ToolTip="Please Enter Email Address" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 

                        <asp:Label ID="Label6" runat="server" Font-Size="12px"  Text="VAT Rate %"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtVATRate" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox  ID="txtVatRate" placeholder="13%" ToolTip="Please Enter VAT Rate" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 

                        <asp:Label ID="Label5" runat="server" Font-Size="12px"  Text="VAT NO"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtVATRegistration" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox  ID="txtVATRegistration" ToolTip="Please Enter VAT NO" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 
 
                     <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Text="-"  Font-Size="11px"></asp:Label>        
                
    </div>
    <div class="panel-footer">              
            <asp:Button ID="btnSubmit" runat="server" ValidationGroup="vlpg43" class="btn btn-primary btn-sm"   Text="Save"  onclick="btnSubmit_Click"   />   
    </div>  
 </asp:Panel> 

</asp:Content>



