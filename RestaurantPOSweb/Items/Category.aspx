<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Category.aspx.cs" Inherits="Category" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
 <div class="col-lg-6 col-lg-offset-3">
       <div class="panel panel-default"  >
            <div class="panel-heading" >
            <asp:Button ID="btnCategoryLink" class="btn btn-success btn-xs"  runat="server"  ValidationGroup="vlgp123"  Text="Add Category" onclick="btnCategoryLink_Click" />     
           <span  style="padding-left:380px" class="glyphicon glyphicon-list"> </span> Category list  
           </div>
                <div class="panel-body">
                <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>
                     <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="390px">
                      <asp:GridView ID="grdCategoryList" runat="server" class="table table-striped table-hover" Font-Size="11px">
                      <Columns>
                          <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>                          
                                    <asp:LinkButton ID="LinkDelete" runat="server"  ForeColor="Red"   Font-Size="15px"   ToolTip="Delete" class="glyphicon glyphicon-trash"    OnClick="LinkDelete_Click"        />  
                                </ItemTemplate>
                          </asp:TemplateField>                     
                          </Columns>
                      </asp:GridView>
                  </asp:Panel>
                </div>
       </div>
     N:B: Sales Register and Front page Category dispay only those who has atleast one item in stock. <br />All categories will not show, Atleast one item need for that category in the stock. 
</div>


<%--<<<<<<<<<<<<<<<<<<<<< ---------------Add Category Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
<asp:Button ID="btnShowPopup" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MpeAddCategoryShow" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopupAddCategoryView"
            CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupAddCategoryView"  class="panel panel-primary"  runat="server" BackColor="White" style="display:none"  Width="200px" DefaultButton="btnSubmit"> 
      <div class="panel-heading"> 
             Add Category             
                <asp:LinkButton ID="btnCancel" runat="server"  ForeColor="#FFFFCC" class="btn btn-Default btn-xs" data-dismiss="alert" >X</asp:LinkButton>                              
       </div>
               
    <div class="panel-body">    
        
                      <asp:Label ID="Label2" runat="server" Font-Size="12px"  Text="Category Name"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtCategory" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox  ID="txtCategory" ToolTip="Please Enter Category Name" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                        <br /> 
                     <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Text="-"  Font-Size="11px"></asp:Label>        
                
    </div>
    <div class="panel-footer">              
            <asp:Button ID="btnSubmit" runat="server" ValidationGroup="vlpg43" class="btn btn-primary btn-sm"   Text="Save"  onclick="btnSubmit_Click"   />   
    </div>  
 </asp:Panel> 

</asp:Content>

