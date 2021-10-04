<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="KitchenDisplay.aspx.cs" Inherits="Sales_KitchenDisplay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
     <link href="../Styles/primefacesdesign.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">     
                        <p></p>
                        <asp:Label ID="Label10" runat="server" Font-Size="12px" Text="Shop Location"></asp:Label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="ddllocation" runat="server" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>                            
                        <asp:DropDownList ID="ddllocation" runat="server" CssClass="TKinput  TKinputwidth-med TKinput-layout TKinput-focus"
                           OnSelectedIndexChanged="ddllocation_SelectedIndexChanged"   ValidationGroup="vlpg43" AutoPostBack="True"></asp:DropDownList>
                                       
<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional"    ViewStateMode="Enabled">
        <ContentTemplate>
            <asp:Panel ID="panelItems" runat="server"    CssClass="col-lg-12"> 
                <div class="panel-panel-success-">      
                        <asp:Panel ID="Panel1" runat="server"  >  <br />
                               <asp:DataList ID="dtlistview" runat="server" Font-Names="Verdana" Font-Size="Small"  RepeatLayout="Flow" OnItemDataBound="dtlistview_ItemDataBound" 
                                     RepeatDirection="Horizontal" CssClass="row">
                                    <ItemStyle ForeColor="Black"/>
                                    <ItemTemplate>
                                        <div class="col-sm-3"> 
                                            <div id="pricePlansmsg">
                                            <ul id="plans">
                                                <asp:Panel ID="Panel2" class="plan panel  panel-success"  runat="server"  >
                                                  <div class="panel-heading" > Order No:
                                                      <asp:Label ID="lblinvoiceno"  runat="server" Text='<%# Eval("Invoiceno") %>'></asp:Label>
                                                      | <asp:Label ID="Label3" runat="server" Text='<%# Eval("ServedBy") %>'></asp:Label> 
                                                  </div>

                                                    <li  class="panel-body" style="text-align:left">                                           
                                                        <asp:Label ID="Label42" runat="server" Text="Date:"></asp:Label>
                                                        <asp:Label ID="lbldateTKW" runat="server" Text='<%# Eval("Date") %>'></asp:Label><br />
                                                        <asp:Label ID="Label1" runat="server" Text="Time:"></asp:Label>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("ordertime") %>'></asp:Label><br />
                                                        <asp:Label ID="Label46" runat="server" Text="Table:"></asp:Label>
                                                        <asp:Label ID="lbltablenoTKW" runat="server" Text='<%# Eval("tableno") %>'></asp:Label><br />
                                                        <asp:Label ID="Label49" runat="server" Text="Invoice:"></asp:Label>
                                                        <asp:Label ID="lblinvoiceTKW" runat="server" Text='<%# Eval("Invoiceno") %>'></asp:Label><br />
                                                        <asp:Label ID="Label53" runat="server" Text="Token No:"></asp:Label>
                                                        <asp:Label ID="lbltokenoTKW" runat="server" Text='<%# Eval("tokenno") %>' ForeColor="#333333" Font-Bold="True"></asp:Label>
                                                       <br /><br />

                                                        <asp:Panel ID="Panel3"  ScrollBars="Vertical" Height="165px" runat="server">
                                                            <asp:DataList ID="dtlistkditems"  runat="server">
                                                                <ItemTemplate>
                                                                <li>
                                                                    <asp:Label ID="LblID" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>    
                                                                    <asp:Label   ID="Label18" Font-Size="12px" runat="server" Text='<%# Bind("Qty") %>' ></asp:Label> -   
                                                                    <asp:Label   ID="lblItems" Font-Size="12px" runat="server" Text='<%# Bind("Items") %>' Font-Bold="True"></asp:Label>                      
                                                                  <br /> <asp:Label   ID="Label19" Font-Size="10px" runat="server" Text='<%# Bind("options") %>' ></asp:Label><p> </p>   
                                                                </li>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </asp:Panel><br />                                            
                                                    </li>
                                                    <div class="panel-footer">
                                                        <asp:Button ID="btnorderReady"  CssClass="btn btn-warning"  runat="server" Text="Order Ready" OnClick="btnorderReady_Click" />
                                                    </div>                                        
                                                </asp:Panel>
                                            </ul>
                                        </div>
                                  </div>
                                    </ItemTemplate>
                                </asp:DataList> 
                                </asp:Panel> 
         
                </div>
             </asp:Panel>     
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick">
    </asp:Timer>

</asp:Content>

