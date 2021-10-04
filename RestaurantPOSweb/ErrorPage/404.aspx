<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="404.aspx.cs" Inherits="ErrorPage_404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> <br />
    <asp:Label ID="Label1" ForeColor="Red" Font-Size="22px" runat="server" Text="We're sorry, but the page you're looking for can't be found!!!"></asp:Label> <br />
    

     <center>  <br /> <br />            
            <asp:Label ID="Label3" runat="server" Font-Size="19px" ForeColor="Red" Text="Access Deny | Please Contact to the system Administrator"></asp:Label><br />  
             <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Dashboard/Default.aspx" runat="server">X</asp:HyperLink> 
             <hr />   <hr /> 
        </center>
</asp:Content>

