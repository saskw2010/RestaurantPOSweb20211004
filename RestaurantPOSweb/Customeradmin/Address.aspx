<%@ Page Title="Address" Language="C#" MasterPageFile="../MasterPage/Master_Ft_page.master" enableEventValidation="false" AutoEventWireup="true" CodeFile="Address.aspx.cs" Inherits="Addressbooks_Address" %>
 <%@ Register Src="MenuUserControl.ascx" TagName="Name" TagPrefix="uc" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>   
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .modalBackground
        {
        background-color: Gray;
        filter: alpha(opacity=80);
        opacity: 0.8;
        z-index: 10000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<uc:Name ID="ucName" runat="server" /> <br /><br />
<div class="col-lg-12"> 
          
        <div class="panel panel-info">       
                <div class="panel-body">
                    
            <asp:Button ID="btnAddAddress"  ValidationGroup="vlg656766" CssClass="btn btn-primary btn-sm"
                 runat="server" Text="Add Address"  OnClick="btnAddnew_Click" />  
                       <asp:DropDownList        ID="ddlpagesize" runat="server"  AutoPostBack="True" 
                                onselectedindexchanged="ddlpagesize_SelectedIndexChanged"> 
                                <asp:ListItem Value="5" Selected="True" >5</asp:ListItem>    
                                <asp:ListItem Value="10">10</asp:ListItem>   
                                <asp:ListItem Value="20">20</asp:ListItem>   
                                <asp:ListItem Value="30">30</asp:ListItem> 
                                <asp:ListItem Value="50">50</asp:ListItem>        
                                </asp:DropDownList> records per page  | <asp:Label ID="lbtotalRow" runat="server" Text=""></asp:Label>
                                 <asp:Label ID="lblNoRecords" runat="server" Text=""></asp:Label>  <br />   
     
                                   
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" > 
                    <asp:GridView ID="grdvwAddressList" runat="server" data-search="true" class="table table-striped"
                       Font-Size="11px" AllowPaging="True" 
                        onpageindexchanging="grdvwAddressList_PageIndexChanging"  >
                      <Columns>
                          <asp:TemplateField HeaderText="Action" >
                                <ItemTemplate>
                                   <%--<asp:LinkButton ID="lnkView" runat="server"  Font-Size="15px"  ForeColor="Red"   ToolTip="View Details" class="fa   fa-bullseye"     OnClick="Linkdtview_Click"   />  |--%>
                                    <asp:LinkButton ID="btnEdit" runat="server"  Font-Size="19px"  ForeColor="Red"    ToolTip="Edit" class="fa fa-edit "     OnClick="LinkEdit_Click"   />  |   
                                     <asp:LinkButton ID="Linkban" runat="server" ForeColor="Red"  Font-Size="21px"   OnClick="LinkbanCustomer_Click"  ToolTip="Delete this Address" class="fa fa-times"  />                                 
                                </ItemTemplate>
                                <HeaderStyle Width="85" />
                          </asp:TemplateField>                       
                
                          </Columns>
                            <PagerSettings      FirstPageText="First" LastPageText="Last" 
                            Mode="NumericFirstLast" NextPageText="Next" PageButtonCount="10" PreviousPageText="Previous" />                                 
                            <PagerStyle Font-Bold="true" Font-Size="Large"    HorizontalAlign="Center"   />  
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
    
    <asp:Panel ID="pnlpopupEditView"  runat="server" BackColor="White" style="display:none"  DefaultButton="btnSave">  
           
           <div class="panel-heading" style="text-align:center">
                <asp:Label ID="lblID" runat="server" Text="0"></asp:Label>
                <asp:Label ID="lbllabelName" runat="server" Text="Edit Address"></asp:Label>                                           
            </div>                 
            <asp:Panel ID="Panel3" class="-panel-body" runat="server" ScrollBars="Vertical" Height="400px"  > 
                
                  <div class="container">           
                       <asp:Label ID="Label37" runat="server" Text="Contact person*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red" Font-Size="11px"  ControlToValidate="txtattentionFROM" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator5" runat="server"   ErrorMessage="Insert Contact person"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtattentionFROM"  Placeholder="Person name"  class="form-control"  runat="server" > </asp:TextBox> <br />

                    <div class="row">   
                          <div  class="col-md-6">    
                            <asp:Label ID="Label12" runat="server" Text="Address 1*"></asp:Label>
                            <asp:RequiredFieldValidator    ForeColor="Red" Font-Size="11px"    ControlToValidate="txtaddress1FROM" ValidationGroup="vlpgDetails"  
                            ID="RequiredFieldValidator12323" runat="server"   ErrorMessage="Insert Address"></asp:RequiredFieldValidator>  
                            <asp:TextBox ID="txtaddress1FROM"  Placeholder="Address"  class="form-control"  runat="server" ></asp:TextBox>   

                            <asp:Label ID="Label13" runat="server" Text="Address 2"></asp:Label><br />
                            <asp:TextBox ID="txtaddress2FROM"  Placeholder="Address"   class="form-control"  runat="server" ></asp:TextBox>                      
 

                            <asp:Label ID="Label15" runat="server" Text="City*"></asp:Label>
                            <asp:RequiredFieldValidator    ForeColor="Red" Font-Size="11px"    ControlToValidate="txtcityFROM" ValidationGroup="vlpgDetails"  
                            ID="RequiredFieldValidator13" runat="server"   ErrorMessage="Please Insert City" ></asp:RequiredFieldValidator>  
                            <asp:TextBox ID="txtcityFROM"  Placeholder="City"   class="form-control"  runat="server" ></asp:TextBox> 
                    
                            <asp:Label ID="Label2" runat="server" Text="Country*"></asp:Label>
                            <asp:RequiredFieldValidator    ForeColor="Red" Font-Size="11px"    ControlToValidate="txtCountry" ValidationGroup="vlpgDetails"  
                            ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Insert Country" ></asp:RequiredFieldValidator>  
                            <asp:TextBox ID="txtCountry"  Placeholder="Country"   class="form-control"  runat="server" ></asp:TextBox>   
                                                           
                        </div>

                        <div  class="col-md-6"> 
                            <asp:Label ID="Label16" runat="server" Text="Phone*"></asp:Label>
                            <asp:RequiredFieldValidator    ForeColor="Red" Font-Size="11px"    ControlToValidate="txtphoneFROM" ValidationGroup="vlpgDetails"  
                            ID="RequiredFieldValidator7" runat="server"   ErrorMessage="Insert Phone Number"></asp:RequiredFieldValidator>  
                            <asp:TextBox ID="txtphoneFROM"   Placeholder="*** *** ****"  class="form-control"   runat="server" ></asp:TextBox>  

                            <asp:Label ID="Label17" runat="server" Text="Email:*"></asp:Label>                   
                            <asp:TextBox ID="txtemailFROM"   Placeholder="senderemail@mail.com"    class="form-control"  runat="server" ></asp:TextBox>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="vlpgDetails"   ForeColor="Red" Font-Size="11px"   
                            runat="server" ErrorMessage="Enter valid Email address"   ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                            ControlToValidate="txtemailFROM"></asp:RegularExpressionValidator> <br />

                     
                            <asp:Label ID="Label1" runat="server" Text="ZIP / Postal"></asp:Label>                     
                            <asp:TextBox ID="txtpostalcode"   class="form-control" runat="server"> </asp:TextBox>                   

                            <asp:Label ID="lblmsg" runat="server" Font-Size="11px"   ForeColor="Red"   Text="-"></asp:Label><br />
                            
                            <asp:Button ID="btnClose" class="btn btn-danger btn-sm" runat="server" Text="Close" />
                            <asp:Button ID="btnSave" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vlpgDetails"   Text="Save"   onclick="btnSave_Click"  />
                       
                        </div>     
                    </div>
                  </div>               
        </asp:Panel>    
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
            <asp:Label ID="Label7" runat="server"   Text="Do you want to delete this address?"></asp:Label> <br />
    </div>
    <div class="panel-footer">
           <asp:Button ID="btnCloseInactive" class="btn btn-danger btn-sm" runat="server" Text="No" /> 
           <asp:Button ID="btnInactive" class="btn btn-success btn-sm" runat="server"   Text="Yes"   onclick="btnInactive_Click"  />
            
     </div>
    </asp:Panel>
 </div>

 <%--<<<<<<<<<<<<<<<<<<<<< --------------- Details view    Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
    

   <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content"  style="width:750px" >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">   <asp:Label ID="lblcustid" runat="server" Text="-"></asp:Label> | <u>      Customer Details </u>  
                  <br /> 
           </h4>
        </div>
        <div class="modal-body">          
            <div  class="col-lg-4"> 
                    <div class="panel panel-info" style="text-align:left">   
                            <div class="panel-heading"> 
                                    Basic info                                            
                            </div>    
                        <asp:Label ID="lblcusname" runat="server" Font-Size="20px" Text="-"></asp:Label> <br />                         
                        <asp:Label ID="lblEmail" runat="server" Text="-"></asp:Label> <br />
                         <asp:Label ID="lblphone" runat="server" Text="-"></asp:Label> <br />
                    </div>
             </div>
            <div  class="col-lg-8">      
                      <div class="panel panel-warning" style="text-align:left">   
                            <div class="panel-heading"> 
                                   Sold to  <asp:Label ID="lblcname" Font-Size="14px" runat="server" Text="-"></asp:Label>                                          
                            </div>    
                            <asp:Panel ID="Panel2" runat="server" Height="300px" ScrollBars="Vertical">                          
                                <asp:GridView ID="grdviewSoldhistory" runat="server"   class="table table-striped table-hover" Font-Size="11px">  </asp:GridView>
                            </asp:Panel>
                    </div>
             </div>

        </div>
        <div class="modal-footer">		 
          <button type="button" class="btn btn-danger btn-sm"  data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Details view   Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>

</asp:Content>


