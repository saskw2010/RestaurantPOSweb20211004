<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ItemList.aspx.cs" Inherits="ItemList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">  <%--Item list is another format/Design of item   list--%>
 
<div class="col-lg-11 col-lg-offset-1">
    Item List <br />
                <div class="form-group">      
                    <div class="input-group">                               
                        <asp:TextBox ID="txtSearch" Font-Size="15px" class="form-control" 
                            placeholder="Search by item name..."  AutoPostBack="true" runat="server" 
                            ontextchanged="txtSearch_TextChanged" ></asp:TextBox>
                                <span class="input-group-btn">
                                        <asp:Button   class="btn btn-warning"   ID="btnGo" runat="server"  Text="Go" />          
                            </span>                                   
                    </div>  
                </div>
             
    <asp:Panel ID="Panel1" runat="server" > <br />
       <asp:DataList ID="DTusers" runat="server" Font-Names="Verdana" Font-Size="Small"   RepeatLayout="Flow"   RepeatDirection="Horizontal" CssClass="row">
            <ItemStyle ForeColor="Black"/>
            <ItemTemplate>
            <div class="col-md-2">
                <div id="pricePlans">
                    <ul id="plans">
                        <li class="plan" style="width:160px">
                            <ul class="planContainer"> 
                                <li class="title">
                                <asp:Label  Visible="false"  ID="Label2" Font-Size="14px" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                    <h5><asp:Label   ID="lblUserName" Font-Size="14px" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label></h5>
                                </li>
                                <li class="title">
                                    <asp:Image ID="imgPhoto" runat="server" class="img-circle"  Width="120px" Height="120px"   ImageUrl='<%# Eval("Photo")%>' />
                                </li>
                                <li>
                                     <ul class="options">                                      
                                       <li><span> Price: <asp:Label ID="Label9" runat="server" Text='<%# Bind("Total") %>'></asp:Label>   
                                           (<asp:Label ID="Label8" ForeColor="Black" Font-Size="10px" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>)</span>  </li>                                    
                                    </ul>
                                </li>
                               <%-- <a href="/Point_of_sale/ManageItems.aspx?ID=<%# Eval("ID")%>"    class="btn btn-primary btn-xs"  > Details </a>--%>
                             </ul>
                        </li>
                    </ul>
                </div>   
                </div>      
            </ItemTemplate>
        </asp:DataList>
   </asp:Panel>
        <br /><br /> 
</div>
</asp:Content>

