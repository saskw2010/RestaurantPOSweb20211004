<%@ Page Title="Home Page" Language="C#" MasterPageFile="MasterPage/Master_Front.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" enableEventValidation="false" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
 </asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 <div class="container">

        <header class="section-header">
          <h3 class="section-title">Our Items</h3>
        </header>


            <div class="col-md-12"> <br />  
                <div class="form-group">      
                    <div class="input-group"> 
                                                        
                        <asp:TextBox ID="txtSearch" Font-Size="15px" class="form-control" ToolTip="Search by item name, category... " 
                            placeholder="Search by item name,category..."  AutoPostBack="true" runat="server" 
                            ontextchanged="txtSearch_TextChanged" Visible="False"></asp:TextBox>
                                <span class="input-group-btn">
                                        <asp:Button   class="btn btn-warning"   ID="btnGo" runat="server"  Text="Go" Visible="False" />          
                            </span>                                   
                    </div>  
                </div>   
            </div> 


   
    <%--------------------------------    Product List ----------------------------Start----------%>
        <asp:Panel ID="Panelallitemlist"  class="col-md-12"  runat="server">  
            
            <asp:DataList ID="dtlistgrid" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow"   RepeatDirection="Horizontal" CssClass="row">
                <ItemStyle ForeColor="Black"/>
                <ItemTemplate>
                    <div class="col-sm-3"> 
                        <div id="pricePlansmsg">
                            <ul id="plans">
                                <li class="plan" style="width:225px">                                                             
                                        <ul class="planContainer"> 
                                            <li class="title">
                                                        <asp:Label  Visible="false"  ID="lblpid" runat="server" Text='<%# Bind("ID") %>'></asp:Label>  
                                                        <asp:Label ID="lblproductnameDetails" Visible="false" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label> 
                                                        <asp:Label ID="LblQty" Visible="false" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                                                        <asp:Label  Visible="false"  ID="lblcategoryid" runat="server" Text='<%# Bind("ItemCategory") %>'></asp:Label>
                                                        <asp:Label  Visible="false"  ID="Lbloptions" runat="server" Text='<%# Bind("options") %>' ></asp:Label>                                              
                                                        <asp:Label ID="lblDescriptions" Visible="false" runat="server" Text='<%# Eval("description") %>'></asp:Label>  
                                                        <asp:Label ID="Lblkditem" Visible="false" runat="server" Text='<%# Eval("kditem") %>'></asp:Label>   
                                                        <asp:HyperLink ID="HyperLink2" ToolTip="Show Details" Target="_blank"   runat="server" NavigateUrl='<%# string.Format("~/itemmoreview.aspx?Customerinquiry={0}&cid={1}", Eval("ItemName"),Eval("id")) %>'>       
                                                        <asp:Label   ID="lblitemname" Font-Size="14px" Font-Bold="true" runat="server" Text='<%# Bind("ItemName") %>' ForeColor="#ff3399"></asp:Label> 
                                                        </asp:HyperLink>
                                            </li>
                                            <li class="title">                      
                                                    <asp:HyperLink ID="HyperLink1" ToolTip="Show Details"   runat="server"  NavigateUrl='<%# string.Format("~/itemmoreview.aspx?Customerinquiry={0}&cid={1}", Eval("ItemName"),Eval("id"))  %>' >     
                                                    <asp:Image  ID="imgPhoto" ToolTip='<%# Bind("ItemName") %>' runat="server"  class="img-thumbnail2"   Width="96px" Height="96px"   ImageUrl='<%# Eval("Photo") %>' /> <br />
                                                   </asp:HyperLink>
                                                     
                                            </li>
                                            <li>
                                                 <ul class="options">                                      
                                                   <li>
                                                        <asp:Label ID="LblDisc"   ForeColor="#999999" runat="server" Text='<%# Eval("Disc") %>' Font-Size="11"></asp:Label>% OFF  
                                                       <asp:Label   ToolTip="Price"    Font-Bold="true" ID="LblPriceOnsale" runat="server" Text='<%# Bind("Price") %>' Font-Size="14"></asp:Label> 
                                                     
                                                   </li>   
                                                              
                                                </ul>
                                            </li>                                   
                                         </ul>                               
                                </li>
                            </ul>
                        </div> 
                     </div>                     
                </ItemTemplate>
            </asp:DataList>
            <center> <asp:Button ID="btnviewmore" class="btn btn-default btn-sm" runat="server"  Text="View More" OnClick="btnviewmore_click"  /> </center>           
        </asp:Panel>
<%--------------------------------    Product List ----------------------------END----------%>

  
</div>

</asp:Content>
