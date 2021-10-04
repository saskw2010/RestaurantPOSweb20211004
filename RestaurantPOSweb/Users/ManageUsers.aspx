<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="User_Adduser" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-lg-10 col-lg-offset-1">
    <div class="well well-sm" >
     <asp:Button ID="btnAdduser" CssClass="btn btn-warning btn-xs" runat="server" Text="Add new user"  ToolTip="Create New User"      PostBackUrl="~/Users/Adduser.aspx" />
     <asp:Button ID="btnAddTask" CssClass="btn btn-success btn-xs" runat="server" Text="Add Task" ToolTip="Add new task"   PostBackUrl="~/Others/AddTask.aspx" />
    </div>
</div>

<div class="col-lg-10 col-lg-offset-1">
        <div class="panel panel-primary"  > 
         <div class="panel-heading" ><span  class="glyphicon glyphicon-list"> </span> Users list </div>
          <div class="panel-body">
              <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>
              <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="370px">
                  
                  <asp:GridView ID="grdUserList" runat="server" class="table table-striped table-hover" Font-Size="11px">
                  <Columns>
                      <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>                               
                               <asp:LinkButton ID="LinkEdit" runat="server"   Font-Size="13px"   Font-Bold="true"    ToolTip="Edit User Info | And Show  Details" class="glyphicon glyphicon-pencil "     OnClick="LinkEdit_Click"        />  |  
                                <asp:LinkButton ID="linkUserRole" runat="server"   Font-Size="13px"   Font-Bold="true"    ToolTip="User privilege" class="glyphicon glyphicon-check" OnClick="LinkUserRole_Click"  /> 
                           </ItemTemplate>
                      </asp:TemplateField>                     
                      </Columns>
                  </asp:GridView>

              </asp:Panel>
          </div>
         </div>
</div>


 

   
  <%-- ///////////////////////Edit Panel ////////////////////   --%>    
 <asp:Button ID="btnEditShowPopup" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MpeEditShow" runat="server" TargetControlID="btnEditShowPopup" PopupControlID="pnlpopupEditView"
            CancelControlID="btnEditCancel" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupEditView"  class="panel panel-primary col-lg-6" runat="server" BackColor="White" style="display:none"   DefaultButton="btnSave">
   
    <div class="panel-heading" style="text-align:left"> 
        <asp:Label ID="lblIDView" runat="server"   Text="ID"></asp:Label>:Edit View
                        
    </div> 

    <asp:Panel ID="pnlenbody" runat="server" ScrollBars="Vertical"  Height="350px" CssClass="panel-body" style="text-align:left">
            <div class="col-lg-6">                             
            <asp:Label ID="Label1" runat="server" Font-Size="11px"   Text="First Name"></asp:Label> 
            <asp:TextBox ID="txtFName" class="form-control" runat="server"></asp:TextBox> 

            <asp:Label ID="Label2" runat="server" Font-Size="11px" Text="Last Name"></asp:Label> 
            <asp:TextBox ID="txtLName"  class="form-control" runat="server"></asp:TextBox> 

            <asp:Label ID="Label10" runat="server" Font-Size="11px" Text="Date of Birth"></asp:Label> 
            <asp:TextBox ID="txtDOB" class="form-control"  runat="server" ToolTip="Date of birth sample : 1993-02-09"></asp:TextBox> 

            <asp:Label ID="Label3" runat="server" Font-Size="11px" Text="Contact"></asp:Label> 
            <asp:TextBox ID="txtContact" class="form-control"   runat="server"></asp:TextBox>    
            
            <asp:Label ID="Label8" runat="server" Font-Size="11px" Text="Email"></asp:Label> 
            <asp:TextBox ID="txtEmail" class="form-control"   runat="server"></asp:TextBox>    
                
            <asp:Label ID="Label4" runat="server" Font-Size="11px" Text="Userid"></asp:Label> 
            <asp:TextBox ID="txtuserid" ReadOnly="true" class="form-control"   runat="server"></asp:TextBox>       
 
             
        </div>
        <div class="col-lg-6">    
            
            <asp:Label ID="Label6"     runat="server" Font-Size="11px" Text="Designation"></asp:Label> 
            <asp:TextBox ID="txtDesignation" class="form-control"   runat="server"></asp:TextBox> 

            <asp:Label ID="Label9" runat="server" Font-Size="11px" Text="Supervisor"></asp:Label> 
            <asp:TextBox ID="txtSupervisor" runat="server"  class="form-control"   ></asp:TextBox>  
 

             <asp:Label ID="Label11" runat="server" Font-Size="11px" Text="Shop ID"></asp:Label> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" ValidationGroup="vlpg43"  
                 ControlToValidate="ddllocation" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                            
            <asp:DropDownList ID="ddllocation" runat="server" class="form-control" ValidationGroup="vlpg43" ></asp:DropDownList>

            <asp:Label ID="Label5" runat="server" Font-Size="11px"  Text="Address"></asp:Label> 
            <asp:TextBox ID="txtAddress" TextMode="MultiLine"  class="form-control"   runat="server"></asp:TextBox>

              <asp:Label ID="Label7" runat="server" Font-Size="11px"  Text="Password"></asp:Label> 
            <asp:TextBox ID="txtPassword"   runat="server"  class="form-control"   ></asp:TextBox>
       
        </div>
                           
    </asp:Panel>
    
     <div class="panel-footer"> <asp:Label ID="lblmsg" ForeColor="Red" runat="server" Text=""></asp:Label><br />
            <asp:Button ID="btnSave" class="btn btn-primary btn-sm" runat="server" Text="Save" OnClick="btnSave_Click"   />         
            <asp:Button ID="btnEditCancel" class="btn btn-danger btn-sm" runat="server" Text="Close" />

     </div>
                 
</asp:Panel>



<%--///////////////////////////////////  Popup User Role Page Access  //////////////////////////  --%>
        <asp:Button ID="btnRoleShow" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MPEUserRole" runat="server" TargetControlID="btnRoleShow" PopupControlID="pnlpopupUserRole"
        CancelControlID="btnUserRoleCancel" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupUserRole"  class="panel panel-primary col-lg-4" runat="server" BackColor="White" style="display:none"  >
        <div class="panel-heading" style="text-align:left"> 
             <asp:Label ID="lblURUserID" runat="server"   Text="ID"></asp:Label>
             <asp:Label ID="lblUserName" runat="server"   Text=""></asp:Label>
              :Page Access                       
        </div> 

        <div class="panel-body" style="text-align:left"> 
            <asp:Panel ID="Panel2" runat="server"  ScrollBars="Vertical" Height="350px" >             
            <asp:GridView ID="grdviewUserPageAccess" Font-Size="11px"  class="table table-striped table-hover"  runat="server">
                   <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                <asp:CheckBox ID="chkAllow"   runat="server"  ValidationGroup="vG2" Font-Size="17px"  ToolTip="Allow "    />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                </asp:GridView>
            </asp:Panel>  
        </div>
      <div class="panel-footer"> <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Text=""></asp:Label><br />
      <asp:Button ID="btnUserRoleSave"  OnClick="btnUserRoleSave_click" class="btn btn-success btn-sm"  runat="server" Text="Save" />
            <asp:Button ID="btnUserRoleCancel"  class="btn btn-danger btn-sm"  runat="server" Text="Close" />
      </div>
</asp:Panel>

</asp:Content>

