<%@ Page Title="Registration" Language="C#" MasterPageFile="MasterPage/Master_Ft_page.master" enableEventValidation="false" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="public_Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server"> 
    <div class="section-header">
        <h3>Open Account</h3>
        <p>Create free account - Place Order and Delivery</p>
    </div>

    <div class="row" style="text-align:left">
        <div class="col-md-7">               
                    <asp:Label ID="Label37"   runat="server" Text="Name*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red" Font-Size="12px"  ControlToValidate="txtname" ValidationGroup="vlpgDetailsUR"  
                    ID="RequiredFieldValidator5" runat="server"   ErrorMessage="Please insert full name" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtname"  Placeholder="Full name"  class="form-control"  runat="server" > </asp:TextBox>  

                    <asp:Label ID="Label3"    runat="server" Text="Phone*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"   Font-Size="12px" ControlToValidate="txtphone" ValidationGroup="vlpgDetailsUR"  
                    ID="RequiredFieldValidator3" runat="server"   ErrorMessage="Please insert phone" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtphone"  Placeholder="*** *** ****"  class="form-control"  runat="server" > </asp:TextBox> 

                    <asp:Label ID="Label1" runat="server"   Text="Username:*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  Font-Size="12px"  ControlToValidate="txtusernameo" ValidationGroup="vlpgDetailsUR"  
                    ID="RequiredFieldValidator323" runat="server"     ErrorMessage="Insert username" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="vlpgDetailsUR" ForeColor="Red" 
                    runat="server" ErrorMessage="Please insert valid email address"  Font-Size="12px"   ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    ControlToValidate="txtusernameo" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="txtusernameo" ToolTip="Insert username"  Placeholder="usernameemail@mail.com"  class="form-control"  runat="server"></asp:TextBox> 

            
                    <asp:Label ID="Label12" runat="server"  Font-Bold="true" Text="Address*"></asp:Label>
                    <asp:RequiredFieldValidator    ForeColor="Red" Font-Size="11px"    ControlToValidate="txtaddress" ValidationGroup="vlpgDetails"  
                    ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Insert Address" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtaddress"  Placeholder="Address"  class="form-control"  runat="server" TextMode="MultiLine"></asp:TextBox> <br />
                     
                    <asp:Label ID="Label2"   runat="server" Text="Password:*"></asp:Label>                
                    <asp:RequiredFieldValidator  ForeColor="Red"  Font-Size="12px"  ControlToValidate="txtPassoword" ValidationGroup="vlpgDetailsUR"  
                    ID="RequiredFieldValidator12323" runat="server"      ErrorMessage="Please insert password" SetFocusOnError="True"></asp:RequiredFieldValidator>  
                    <asp:TextBox ID="txtPassoword"     TextMode="Password" class="form-control"  runat="server" ></asp:TextBox>             
  
                    <asp:Label ID="Label5"   runat="server" Text="Confirm Password:*"></asp:Label>
                    <asp:RequiredFieldValidator  ForeColor="Red"  Font-Size="12px"  ControlToValidate="txtconfirmPassword" ValidationGroup="vlpgDetailsUR"  
                    ID="RequiredFieldValidator6" runat="server"      ErrorMessage="Please insert password" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtconfirmPassword"    TextMode="Password" class="form-control"  runat="server" ></asp:TextBox> 
                    <asp:Label ID="Label19" runat="server" Text="Example: P@ssword123" Font-Size="9"></asp:Label>  <br /> <br />

                <asp:Button ID="btnSave" class="btn btn-primary btn-sm" runat="server"  ValidationGroup="vlpgDetailsUR"   Text="Create Account" OnClick="btnsave_Click"   /> &nbsp; &nbsp; &nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login_customer.aspx" Font-Underline="True" Font-Size="14px">I have an Existing Account</asp:HyperLink>   <br />


                    <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="vlpgDetailsUR" ForeColor="Red" 
                    ErrorMessage="Don't Match Password" Font-Size="12px"  ControlToCompare="txtconfirmPassword"  ControlToValidate="txtPassoword" SetFocusOnError="True"></asp:CompareValidator>  <br /> 
                    
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Please enter at least 8 Characters." 
                    ControlToValidate="txtPassoword"  ValidationExpression="^(?=.*[a-z]{1}).{8,}$"  Font-Size="9" ForeColor="Red" SetFocusOnError="True"></asp:RegularExpressionValidator>

                  <br /> <asp:Label ID="lblmsg" runat="server"  ForeColor="Red" Text=""></asp:Label>
                  
        </div>

    <div class="col-md-5"> 
         <ul>
            <li><b>Purchase from our site</b></li> 
            <li><b>Manage Orders</b></li> 
            <li><b>Secure payment method</b></li>  
        </ul>
    </div>
</div>
</asp:Content>

