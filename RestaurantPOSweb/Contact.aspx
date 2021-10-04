<%@ Page Title="Contact" Language="C#" MasterPageFile="MasterPage/Master_Ft_page.master"  enableEventValidation="false" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="row">
     <div class="col-lg-6"> 
        <h2>Our Contacts</h2>
        
        <h3 style="color:#1073b8;"><b>ADDRESS</b></h3>
      <span  style="font-size: larger; color: #000000;">  8-586 Milliken blivabilliowa  <br/> 
        kinstob, ON Canada, M2V 3H4    <p></p>
        Phone:555 555 5555  </span> 

     </div>   
    <div class="col-lg-6">              
   
        <h4><b>SALES</b></h4>
        <a href="mailto:sales@citputer.com"  style="font-size: larger; color: #1073b8;">  sales@citputer.com </a><hr />   

        <h4><b>CUSTOMER SERVICE</b></h4>
        <a href="mailto:customercare@citputer.com"  style="font-size: larger; color: #1073b8;">  customercare@citputer.com </a>  

       
   
     </div> 

 <div  class="col-lg-8 col-lg-offset-4">   <br /><br /> <h3>Need some more information?  Send us a message!</h3> <br /></div>  <hr />
 <div class="panel-body row col-lg-12"  style=" background-color:#C0C0C0">     
     <div  class="col-lg-6">
         <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red" ControlToValidate="txtname" ValidationGroup="vlpgcontactinfo"  
        ID="RequiredFieldValidator4" runat="server"   ErrorMessage="Please Enter Full Name"  > </asp:RequiredFieldValidator>  
         <asp:TextBox ID="txtname" CssClass="form-control"  placeholder="Enter Full Name" runat="server" ValidationGroup="vlpgcontactinfo"  ></asp:TextBox><br />

        <asp:Label ID="Label3" runat="server" Text="Company"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red" ControlToValidate="txtcompanyname" ValidationGroup="vlpgcontactinfo"  
        ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Please Enter Company Name"  > </asp:RequiredFieldValidator>  
        <asp:TextBox ID="txtcompanyname" CssClass="form-control"  placeholder="Enter company name" ValidationGroup="vlpgcontactinfo"   runat="server"></asp:TextBox><br />

        <asp:Label ID="Label4" runat="server" Text="Email"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red" ControlToValidate="txtemail" ValidationGroup="vlpgcontactinfo"  
        ID="RequiredFieldValidator2" runat="server"   ErrorMessage="Please Enter a valid email"  > </asp:RequiredFieldValidator> 
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="vlpgcontactinfo" ForeColor="Red" 
        runat="server" ErrorMessage="Enter a valid Email"   ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
        ControlToValidate="txtemail"></asp:RegularExpressionValidator> 
        <asp:TextBox ID="txtemail" CssClass="form-control"  placeholder="Enter a valid email"  ValidationGroup="vlpgcontactinfo"  runat="server"></asp:TextBox><br />

        <asp:Label ID="Label5" runat="server" Text="Phone Number"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red" ControlToValidate="txtphoneno" ValidationGroup="vlpgcontactinfo"  
        ID="RequiredFieldValidator3" runat="server"   ErrorMessage="Please Enter Phone Number"  > </asp:RequiredFieldValidator> 
        <asp:TextBox ID="txtphoneno" CssClass="form-control"  placeholder="Enter Phone Number" runat="server"></asp:TextBox><br /> 
     </div>
    
     <div  class="col-lg-6" >
         <asp:Label ID="Label2" runat="server" Text="Message"></asp:Label>
        <asp:RequiredFieldValidator  ForeColor="Red" ControlToValidate="txtmsgbody" ValidationGroup="vlpgcontactinfo"  
        ID="RequiredFieldValidator5" runat="server"   ErrorMessage="Please Enter your message"  > </asp:RequiredFieldValidator> 
         <asp:TextBox ID="txtmsgbody" CssClass="form-control"  placeholder="Write ..."  TextMode="MultiLine" runat="server" Height="180"></asp:TextBox>
         <br /> 
         <asp:Button ID="btnsend" CssClass="btn btn-primary" runat="server"  ValidationGroup="vlpgcontactinfo"  OnClick="btnsend_Click"  Text="Send" />
        <asp:Label ID="lblalert"  runat="server"   Visible="False"    Font-Bold="True" ForeColor="Red"></asp:Label>   <br />
     </div>
</div>
</div>
</asp:Content>
