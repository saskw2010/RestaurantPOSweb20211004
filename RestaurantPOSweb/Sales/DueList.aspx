<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="DueList.aspx.cs" Inherits="Sales_module_Sales_history" %>

 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
                  
                   <atk:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtsearch"
                    MinimumPrefixLength="1" EnableCaching="true"      CompletionSetCount="1" CompletionInterval="100" 
                    ServiceMethod="GetMDN" FirstRowSelected="True">
                    </atk:AutoCompleteExtender>   
                              
         

<div class="col-lg-10 col-lg-offset-1"> 
        <div class="panel panel-default" > 
             <div class="panel-heading" ><span  class="glyphicon glyphicon-list"> </span> Due List  </div>
             <div class="input-group">
               <span class="input-group-addon"> <span class="glyphicon glyphicon-search"> </span> </span>
               <asp:TextBox ID="txtsearch" class="form-control"   
                        ToolTip="Search by : Invoice No , Customer name"   Placeholder="Search" runat="server" AutoPostBack="True" 
                        ontextchanged="txtsearch_TextChanged"></asp:TextBox>
            </div>
       
                <div class="panel-body">
                           
                    <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>
                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="350px">
                        <asp:GridView ID="grdItemList" runat="server"   
                            class="table table-striped table-hover" Font-Size="11px" 
                            onrowdatabound="grdItemList_RowDataBound">
                          <Columns>
                              <asp:TemplateField HeaderText="Action" HeaderStyle-Width="280px">
                                    <ItemTemplate> 
                                      <asp:LinkButton    ID="linkTakeDue" runat="server"  Font-Size="15px" Text=" Take Due "   ToolTip="Take Due Payment"  class="btn btn-primary btn-xs"  OnClick="linktakepayment_Click" />   
                                      
                                   </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                              </asp:TemplateField>                             
                              </Columns>                           
                                              
                        </asp:GridView>
                    </asp:Panel>
                </div>
       
        </div>
</div>
 

</asp:Content>


