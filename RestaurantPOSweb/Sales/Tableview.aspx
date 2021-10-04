<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Tableview.aspx.cs" Inherits="Sales_Tableview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <link href="../Styles/style.css" rel="stylesheet" type="text/css" /> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><br /> 
<asp:Panel ID="panelItems" runat="server"    CssClass="col-lg-12"> 
    <div class="panel  panel-success">      
            <asp:Panel ID="Panel1" runat="server"  >  
                   <asp:DataList ID="dtlistTableview" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow"   RepeatDirection="Horizontal" CssClass="row">
                        <ItemStyle ForeColor="Black"/>
                        <ItemTemplate>
                            <div class="col-sm-2"> 
                                <div id="pricePlansmsg">
                                <ul id="plans">
                                    <asp:Panel ID="Panel2" class="plan"  runat="server"  BackColor='<%# System.Drawing.Color.FromName(DataBinder.Eval(Container.DataItem,"fillcolor").ToString()) %>'>
                                    <li>
                                        <ul class="planContainer"  >
                                            <li class="title">
                                                <asp:Label ID="LblID" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>     
                                                <h5><asp:Label   ID="LbltableName"  Font-Size="12px" runat="server" Text='<%# Bind("tablename") %>' Font-Bold="True"></asp:Label></h5>
                                            </li>
                                            <li class="title">
                                                <asp:ImageButton ID="imgmoveclick"  runat="server"   ImageUrl="~/images/restaurant-table.png" OnClick="imgmoveclick_Click" />
                                            </li>
                                            <li>
                                                <ul class="options">     
                                                           Seat: <asp:Label ID="Label1" ToolTip="Seat Quantity" runat="server" Text='<%# Bind("seatqty") %>'></asp:Label>                          
                                                   <li><span><asp:Label ID="lblzonenam" ToolTip="Table Zone " runat="server" Text='<%# Bind("zonenam") %>'></asp:Label>  </span>  </li>                                    
                                                </ul>
                                            </li>           
                                        </ul>
                                    </li></asp:Panel>
                                </ul>
                            </div>
                      </div>
                        </ItemTemplate>
                    </asp:DataList> 
                    </asp:Panel> 
         
    </div>
 </asp:Panel> 

</asp:Content>

