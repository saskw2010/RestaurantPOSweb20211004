<%@ Page Title="Orders" Language="C#" MasterPageFile="../MasterPage/Master_Ft_page.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Customeradmin_Orders" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  
        <div class="panel panel-default">  <br />
            <span style="padding-left:15px" >         
               <asp:TextBox ID="txtsearch"  
                        ToolTip="Search by : Order No "  Placeholder="Search" runat="server" AutoPostBack="True" 
                        ontextchanged="txtsearch_TextChanged"></asp:TextBox>

                          <asp:DropDownList        ID="ddlpagesize" runat="server"  AutoPostBack="True" 
                                onselectedindexchanged="ddlpagesize_SelectedIndexChanged"> 
                                <asp:ListItem Value="5" Selected="True" >5</asp:ListItem>    
                                <asp:ListItem Value="10">10</asp:ListItem>   
                                <asp:ListItem Value="20">20</asp:ListItem>   
                                <asp:ListItem Value="30">30</asp:ListItem> 
                                <asp:ListItem Value="50">50</asp:ListItem>        
                                </asp:DropDownList> records per page  
                </span>
                <div class="panel-body">
                           
                    <asp:Label ID="lbtotalRow" runat="server" Text=""></asp:Label>
                    <asp:Panel ID="Panel1" runat="server" class="box-body table-responsive no-padding"> 
                        <div id="wrapper"> 
                            <asp:GridView ID="grdItemList" runat="server"   class="table table-striped table-hover" Font-Size="11px"
                             AllowPaging="True"  onpageindexchanging="grdItemList_PageIndexChanging">
                              <Columns>
                                  <asp:TemplateField HeaderText="Action" HeaderStyle-Width="250px">
                                        <ItemTemplate> 
                                          <asp:LinkButton    ID="linkViewInvoice" runat="server"    ToolTip=" View Order Details"   class="fa fa-bullseye"  OnClick="linkViewInvoice_Click" ForeColor="Red" Font-Size="17px" />    
                                   
                                       </ItemTemplate>
                                        <HeaderStyle Width="10px" />
                                  </asp:TemplateField>                             
                                  </Columns>    
                                    <PagerSettings      FirstPageText="First" LastPageText="Last" 
                                    Mode="NumericFirstLast" NextPageText="Next" PageButtonCount="10" PreviousPageText="Previous" Position="Bottom" />                                 
                                    <PagerStyle Font-Bold="true" Font-Size="Large"    HorizontalAlign="Center"        CssClass="pagination-ys"    BackColor="White" />  
                                    <AlternatingRowStyle BackColor="#E0E0E0" BorderColor="Gray" BorderWidth="1"   />
                                    <HeaderStyle BackColor="#E0E0E0" Font-Bold="True" ForeColor="#003300"       BorderStyle="Solid" BorderColor="#E0E0E0" />                                         
                            </asp:GridView>
                        </div>
                    </asp:Panel>
                </div>
         </div>
 
    
<%--<<<<<<<<<<<<<<<<<<<<< ---------------   Details view      Start --------------    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>    

   <!-- Modal -->
  <div class="modal fade" id="detailsmodal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content"  >
        <div class="modal-header">
          <h4 class="modal-title">   
              <asp:Label ID="lblid" runat="server" Text="-" Font-Size="10"></asp:Label>              
           </h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">                       
            <asp:Panel ID="Panel2" class="panel-body" runat="server"  ScrollBars="Vertical"    Height="420px">                
                <div id="wrapper"> 
                    <asp:Label ID="lblcontactpersion" runat="server" Text=""></asp:Label><br />
                     <asp:Label ID="lbladdress1" runat="server" Text=""></asp:Label><br />
                   <%--  <asp:Label ID="lbladdress2" runat="server" Text=""></asp:Label> <br />
                     <asp:Label ID="lblcity" runat="server" Text=""></asp:Label>,  
                    <asp:Label ID="lblpostalcode" runat="server" Text=""></asp:Label>,  
                    <asp:Label ID="lblcounrty" runat="server" Text=""></asp:Label> <br />--%>
                     <asp:Label ID="lblphone" runat="server" Text=""></asp:Label> <hr />
                    <asp:GridView ID="grddetails" runat="server"   class="table table-striped table-hover"
                         ShowFooter="true"   onrowdatabound="grddetails_RowDataBound"  Font-Size="11px">  
                                                                             
                    </asp:GridView>
                </div>
        
            </asp:Panel>   
        </div>
        <div class="modal-footer">          
          <button type="button" class="btn btn-danger btn-xs"  data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Details view   Popup  END -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>  
</asp:Content>
