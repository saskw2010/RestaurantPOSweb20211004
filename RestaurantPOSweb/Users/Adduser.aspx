<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Adduser.aspx.cs" Inherits="Adduser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-8 col-lg-offset-2">
        <div class="well well-sm"  >             
            <asp:HyperLink ID="hlnkManageItems" Font-Size="20px" ForeColor="Black" ToolTip="Manage Users"  class="glyphicon glyphicon-th-list" NavigateUrl="~/Users/ManageUsers.aspx"  ValidationGroup="vlpg11" runat="server"></asp:HyperLink>
            Manage Users
        </div>
    </div>

  <div class="col-lg-8 col-lg-offset-2">
       <div class="panel panel-primary" style="text-align:left">     
          <div class="panel-body">            
                <asp:Label ID="Label8" class="label label-warning" Font-Size="12px" runat="server" Text="Add New User"></asp:Label> 
                <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Please enter user details below"></asp:Label>  <br /> 
           <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label> <br />
            
              <div class="col-lg-5">
           
                    <asp:Label ID="Label2" runat="server" Font-Size="12px"  Text="First Name"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtFname" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                    <asp:TextBox ID="txtFname" placeholder="User Name" ToolTip="Please Enter User Name" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                           
                    <asp:Label ID="Label3" runat="server" Font-Size="12px"  Text="Last Name"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtLname" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtLName" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                    <asp:Label ID="Label4" runat="server" Font-Size="12px"  Text="Phone"></asp:Label>  
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtPhone" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtPhone" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                    <asp:Label ID="Label5" runat="server" Font-Size="12px"  Text="Email Address"></asp:Label> 
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtEmailaddr" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                    <asp:TextBox ID="txtEmailaddr" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                    <asp:Label ID="Label12" runat="server" Font-Size="12px"  Text="Designation"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtDesignation" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                              
                    <asp:TextBox ID="txtDesignation"  ToolTip="User Designation " class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>


                    <asp:Label ID="Label6" runat="server" Font-Size="12px"  Text="Supervisor"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtSupervisor" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                              
                    <asp:TextBox ID="txtSupervisor"  ToolTip="Please Enter Supervisor/Line Manager Name" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>

                 
              </div>
               <div class="col-lg-6">
                        <asp:Label ID="Label13" runat="server" Font-Size="12px" Text="Date of Birth"></asp:Label>
                        <asp:TextBox ID="txtDOB" Text="1993-02-09"   class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>


                       <asp:Label ID="Label14" runat="server" Font-Size="12px" Text="Address"></asp:Label>
                        <asp:TextBox ID="txtAddress"     class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                     
                    
                        <asp:Label ID="Label10" runat="server" Font-Size="12px" Text="Shop ID"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="ddllocation" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                            
                        <asp:DropDownList ID="ddllocation" runat="server" class="form-control" ValidationGroup="vlpg43" ></asp:DropDownList>
                      
                        <asp:Label ID="Label11" runat="server" Font-Size="12px" Text="User ID"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtUserID" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                            
                        <asp:TextBox ID="txtUserID" ToolTip="User Id for login Please omit space" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>


                        <asp:Label ID="Label7" runat="server" Font-Size="12px" Text="Password"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtPassword" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                            
                        <asp:TextBox ID="txtPassword" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>

                        <asp:Label ID="Label9" runat="server" Font-Size="12px" Text="Comfirm Password"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtPassword" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                        <asp:TextBox ID="txtComfirmPassword" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>

                       
                        <br />   
                        <asp:Button ID="btnSubmit" runat="server" ValidationGroup="vlpg43"  
                        class="btn btn-primary btn-sm"   Text="Save" onclick="btnSubmit_Click" /> <br /><br />
                        
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="vlpg43" ForeColor="Red" 
                        runat="server" ErrorMessage="Please Enter valid Email address"  
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        ControlToValidate="txtEmailaddr"></asp:RegularExpressionValidator><br />

                        <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="vlpg43" ForeColor="Red" 
                        ErrorMessage="Don't Match Password" ControlToCompare="txtComfirmPassword" 
                        ControlToValidate="txtPassword"></asp:CompareValidator>       
                    
               </div>
          </div>
      </div>
   </div>
</asp:Content>

