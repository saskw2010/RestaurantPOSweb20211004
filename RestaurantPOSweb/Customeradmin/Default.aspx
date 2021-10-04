<%@ Page Title="Dashboard" Language="C#" MasterPageFile="../MasterPage/Master_Ft_page.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Customeradmin_Default" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
    
        <asp:Panel ID="Panel3" class="col-md-5 panel-body " runat="server" BorderColor="#CCCCCC">     
                
        <br /><asp:Label ID="Label37" Font-Bold="true"  runat="server" Text="Name*"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtname" ValidationGroup="vlpgDetailsUR"  
        ID="RequiredFieldValidator5" runat="server"   ErrorMessage="Please insert full name" SetFocusOnError="True"></asp:RequiredFieldValidator>  
        <asp:TextBox ID="txtname"  Placeholder="Full name"  class="form-control"  runat="server" > </asp:TextBox> <br />

        <asp:Label ID="Label3"  Font-Bold="true" runat="server" Text="Phone*"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtphone" ValidationGroup="vlpgDetailsUR"  
        ID="RequiredFieldValidator3" runat="server"   ErrorMessage="Please insert phone" SetFocusOnError="True"></asp:RequiredFieldValidator>  
        <asp:TextBox ID="txtphone"  Placeholder="*** *** ****"  class="form-control"  runat="server" > </asp:TextBox> <br />

        <asp:Label ID="Label12" runat="server"  Font-Bold="true" Text="Address*"></asp:Label>
        <asp:RequiredFieldValidator    ForeColor="Red" Font-Size="11px"    ControlToValidate="txtaddress" ValidationGroup="vlpgDetails"  
        ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Insert Address" SetFocusOnError="True"></asp:RequiredFieldValidator>  
        <asp:TextBox ID="txtaddress"  Placeholder="Address"  class="form-control"  runat="server" TextMode="MultiLine"></asp:TextBox> <br />
 

                     
        <asp:Label ID="Label2" Font-Bold="true"  runat="server" Text="Password:*"></asp:Label>                
        <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtPassoword" ValidationGroup="vlpgDetailsUR"  
        ID="RequiredFieldValidator12323" runat="server"      ErrorMessage="Please insert password" SetFocusOnError="True"></asp:RequiredFieldValidator>  
        <asp:TextBox ID="txtPassoword"     TextMode="Password" class="form-control"  runat="server" ></asp:TextBox>      <br />     

        <asp:Button ID="btnSave" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vlpgDetailsUR"   Text="Update profile" OnClick="btnsave_Click"   /><br />
  

        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="At least 8 Characters. And at least 1 number or Special symbol (!@#$&*^) " 
        ControlToValidate="txtPassoword"  ValidationExpression="^(?=.*\d{1})(?=.*[a-zA-Z]{1})(?=.*[!@#$&*^]{1}).{8,}$" Font-Size="9" ForeColor="Red" SetFocusOnError="True"></asp:RegularExpressionValidator>

        <br /> <asp:Label ID="lblmsg" runat="server"  ForeColor="Red" Text=""></asp:Label>
                 
    </asp:Panel>
    
</asp:Content>

