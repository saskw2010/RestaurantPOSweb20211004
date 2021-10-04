<%@ Page Title="Login" Language="C#" MasterPageFile="MasterPage/Master_Ft_page.master" AutoEventWireup="true" CodeFile="Login_customer.aspx.cs" EnableEventValidation="false" Inherits="Login_customer"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

 <div class=" col-md-4" >
  
      
            <h5 class="form-signin-heading">Please sign in</h5> 
        
            <asp:Label ID="lblLogMsg" runat="server"   ForeColor="Red" Text="---------"></asp:Label>

            <asp:TextBox ID="txtuser" runat="server" type="text" class="form-controlTK" placeholder="User ID"  ></asp:TextBox> <br /> 
            <asp:TextBox ID="txtpass" runat="server" class="form-controlTK" placeholder="Password" required TextMode="Password"></asp:TextBox>
         
            <br />   <input type="checkbox" value="remember-me"> Remember me
            <asp:HyperLink ID="hylnkforgpass" runat="server"  Text="Forgot password?" NavigateUrl="/password_resets.aspx"></asp:HyperLink>       <br />  

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ErrorMessage="*" ControlToValidate="txtuser" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:Button ID="btnSubmit" runat="server" Text="Sign in"  class="btn btn-lg btn-primary btn-block btn-sm" onclick="btnSubmit_Click" />                 
                  
            <br />  
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="/Registration.aspx"   class="btn btn-lg btn-navypub btn-block btn-sm"  ForeColor="White">Create Free Account  </asp:HyperLink>    
      
    
</div>

</asp:Content>

