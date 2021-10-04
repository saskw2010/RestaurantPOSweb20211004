<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="AddCustomer.aspx.cs" Inherits="AddCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-lg-8 col-lg-offset-2">
    <div class="well well-sm"  >
         <%--<asp:Button ID="btnAdduser" CssClass="btn btn-info btn-xs" runat="server" ValidationGroup="vlpg11"   Text="Manage Customers" PostBackUrl="~/ManageCustomers.aspx" />--%>
            <asp:HyperLink ID="hlnkManageItems" Font-Size="20px" ForeColor="Black" ToolTip="Manage Customers" ValidationGroup="vlpg11"   class="glyphicon glyphicon-th-list" NavigateUrl="~/People/ManageCustomers.aspx"    runat="server"></asp:HyperLink>
            Manage Customers
    </div>
</div>

   <div class="col-lg-8 col-lg-offset-2">
       <div class="panel panel-primary" style="text-align:left">       
          <div class="panel-body">
             <asp:Label ID="Label8" class="label label-warning" Font-Size="13px" runat="server" Text="Add New Customer"></asp:Label> 
              <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Please enter customer details below"></asp:Label> 
              <asp:Label ID="lblMessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label>           
              <hr />
               <div class="col-lg-6">
                        <asp:Label ID="Label2" runat="server" Font-Size="12px"  Text="Name*"></asp:Label>
                        <asp:TextBox ID="txtCustName" class="form-control"  ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                        <asp:Label ID="Label4" runat="server" Font-Size="12px"  Text="Phone*"></asp:Label>    
                        <asp:TextBox ID="txtCustPhone" class="form-control"   ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                        <asp:Label ID="Label3" runat="server" Font-Size="12px"  Text="Email Address*"></asp:Label>
                        <asp:TextBox ID="txtCustEmail" class="form-control"  ValidationGroup="vlpg43"  runat="server"></asp:TextBox>              

                        
                    <asp:Label ID="Label7"   runat="server" Text="Password:*"></asp:Label>                
                    <asp:TextBox ID="txtPassoword"     class="form-control"  runat="server" ></asp:TextBox>             
                    <asp:RequiredFieldValidator  ForeColor="Red"  Font-Size="12px"  ControlToValidate="txtPassoword" ValidationGroup="vlpg43"  
                    ID="RequiredFieldValidator12323" runat="server"      ErrorMessage="Please insert password"      SetFocusOnError="True"></asp:RequiredFieldValidator> 
  
                   
 
                </div>
               <div class="col-lg-6">

                    <asp:Label ID="Label6" runat="server" Font-Size="12px"   Text="Customer type [optional]"></asp:Label> 
                   <asp:DropDownList ID="DDLCustType" class="form-control" runat="server">
                        <asp:ListItem>Power Elite *****</asp:ListItem>
                        <asp:ListItem>Elite ****</asp:ListItem>
                        <asp:ListItem>Ultra ***</asp:ListItem>
                        <asp:ListItem>Diamond **</asp:ListItem>
                        <asp:ListItem>Exclusive *</asp:ListItem>
                   </asp:DropDownList>
                    <p></p>
                     
                    <asp:Label ID="Label5" runat="server" Font-Size="12px"   Text="Address [optional]"></asp:Label> 
                    <asp:TextBox ID="txtCustAddress" TextMode="MultiLine" class="form-control"  ValidationGroup="vlpg43"   runat="server"></asp:TextBox>
                    <p></p>
                    <asp:Button ID="btnSubmit" runat="server"  ValidationGroup="vlpg43"  
                        class="btn btn-primary btn-sm" Text="Submit" onclick="btnSubmit_Click" />
                    <br /> <asp:RequiredFieldValidator ValidationGroup="vlpg43" ForeColor="Red" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCustName" ErrorMessage="Please Fill Name" SetFocusOnError="True"></asp:RequiredFieldValidator> 
                    <br /> <asp:RequiredFieldValidator  ValidationGroup="vlpg43" ForeColor="Red" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCustPhone" ErrorMessage="Please Fill Phone" SetFocusOnError="True"></asp:RequiredFieldValidator> 
                    <br />
                    <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtCustEmail" ValidationGroup="vlpg43"  
                    ID="RequiredFieldValidator323" runat="server"     ErrorMessage="Insert email as username"  SetFocusOnError="True"></asp:RequiredFieldValidator> 
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="vlpg43" ForeColor="Red" 
                    runat="server" ErrorMessage="Please Enter valid Email address"  
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    ControlToValidate="txtCustEmail" SetFocusOnError="true"></asp:RegularExpressionValidator>
               </div>
          </div>
      </div>
</div>
</asp:Content>

