<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MenuUserControl.ascx.cs" Inherits="MenuUserControl" %>
  
    <div class="container-fluid">         
      <nav id="nav-menu-container"  style="background-color:chocolate">
            <ul class="nav-menu">
                <li>  <a  href="/Customeradmin/Default.aspx"> Profile</a> </li>
                <li><a  href="/Customeradmin/Orders.aspx"> Orders</a> </li>
                <li> <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Customeradmin/Address.aspx">Address</asp:HyperLink> </li>           
            </ul>
      </nav><!-- #nav-menu-container -->
    </div>
 

