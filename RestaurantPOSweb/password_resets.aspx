<%@ Page Title="Reset password" Language="C#" MasterPageFile="MasterPage/Master_Ft_page.master" AutoEventWireup="true" CodeFile="password_resets.aspx.cs" EnableEventValidation="false" Inherits="password_resets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
 
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server"> 
         <asp:Label ID="lblalert"  runat="server"   Visible="False"   BackColor="#efeeef" Font-Bold="True" ForeColor="Red"></asp:Label>   <br />
        <h2> Forgot password</h2><br />  

        Enter your email and we will send you an email with a link to reset your password.<br /><br /> 
         <div  class="col-lg-6"> 
        <asp:Label ID="Label5" runat="server" Text="Email" Font-Size="15px" Font-Bold="True"></asp:Label><br />  
        <asp:TextBox ID="txtEmailaddr" placeholder="youremailaddress@mail.com" ValidationGroup="signupvalidation"  class="form-control"  runat="server"    ></asp:TextBox>  
       &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEmailaddr" Display="Dynamic" ErrorMessage="Please enter your Email" SetFocusOnError="true" ForeColor="Red" ValidationGroup="signupvalidation" />
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
        ErrorMessage="Invalid email address."    ControlToValidate="txtEmailaddr" ValidationGroup="signupvalidation"
        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"   Display="Dynamic" > </asp:RegularExpressionValidator><br />
            <asp:Button  ValidationGroup="signupvalidation" ID="btnSetpassword"  class="col-lg-4 btn btn-warning"    runat="server" Text="Reset my password" onclick="btnSetpassword_Click" />
     </div> 
</asp:Content>

