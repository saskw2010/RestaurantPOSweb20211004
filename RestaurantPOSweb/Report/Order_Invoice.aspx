<%@ Page  Title="Invoice" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Order_Invoice.aspx.cs"   enableEventValidation="false" Inherits="Order_module_Order_Invoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
    <script src="../Scripts/PrintPosCopy.js" type="text/javascript"></script> 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div   class="col-md-8 col-md-offset-2"> <p></p>
    <div class="row"> 
        <div style="text-align:left"     class="col-lg-6">   
        Order Invoice |  <asp:Label ID="lblInvoiceNoTop"  runat="server" Text="" Font-Bold="True"> </asp:Label>  </div>
        <div style="text-align:right"    class="col-lg-6">
              
            <input type="button" class="btn btn-success btn-xs" value="Print" title="Print this invoice to keep record"  onclick="javascript:printDiv('wrapper')" /> 
            <asp:Button ID="btnclose" class="btn btn-danger btn-xs" runat ="server" Text="Close" PostBackUrl="~/Report/WebOrders.aspx" />          
        </div></div><hr />

<div class="panel panel-info"></div>
    <div  id="wrapper" style="text-align:left; background-color:White"> 
        <div class="row"> 
            <div style="text-align:left; background-color:White"      class="col-lg-12">  
                                <asp:Label ID="lblshopTitle" Font-Size="23px" runat="server" Text="-"  Font-Names="High Tower Text"></asp:Label> <br />
                                <asp:Label ID="lblshopAddress"  Font-Size="12px" runat="server" Text="-"></asp:Label>  <br />
                                <asp:Label ID="lblwebAddress"  Font-Size="12px"  runat="server" Text=""></asp:Label> <br />

                                <asp:Label ID="Label16" Font-Size="12px" runat="server" Text="Phone:"></asp:Label> 
                                <asp:Label ID="lblcompanyphone" Font-Size="13px" runat="server" Text=""></asp:Label> <br />
                                 <asp:Label ID="Label3" Font-Size="12px" runat="server" Text=""></asp:Label> <br /> 
            </div>

             <div style="text-align:left; background-color:White"      class="col-lg-8">   
                                <asp:Panel ID="Panel1" BackColor="#0099CC" Width="250" runat="server">
                                 <asp:Label ID="Label11" Font-Size="15px" runat="server" Font-Bold="true"   Font-Underline="true"  ForeColor="White" Text="SHIP TO "  Font-Names="High Tower Text"></asp:Label> <br />  
                                 </asp:Panel>
                                <asp:Label ID="lblcustname" Font-Size="17px" runat="server" Text="-"  ></asp:Label> <br />
                                <asp:Label ID="lblcustaddr"  Font-Size="11px" runat="server" Text="-"></asp:Label>  <br />            
                                <asp:Label ID="Label5" Font-Size="11px" runat="server" Text="Phone:"></asp:Label> 
                                <asp:Label ID="lblcustphone" Font-Size="11px" runat="server" Text=""></asp:Label> <br /> 
            </div>

            <div  style="text-align:right; background-color:White"     class="col-lg-4">  
                             <asp:Label ID="Label1" Font-Size="23px" runat="server" ForeColor="BlueViolet" Text="Invoice"> </asp:Label> <br />
            
                   Invoice #    <asp:Label ID="lblInvoiceNo"     Font-Size="14px" runat="server" Text="--" Font-Bold="True"></asp:Label>  <br />
                   Date #       <asp:Label ID="lbldate"          Font-Size="12px"  runat="server" Text=""></asp:Label> <br />                             
            </div>

                <%-- Sold item databind--%>
                <div    class="col-lg-12  box-body table-responsive no-padding" style="background-color:White" >  <br /> 
                       <asp:GridView ID="grdItemList" runat="server"  
                        class="table table-striped table-hover" Font-Size="11px"  
                        ShowHeaderWhenEmpty="True" onrowdatabound="grdItemList_RowDataBound" ShowFooter="true"></asp:GridView>                
         
                </div>
                <div style="text-align:right ; background-color:White"    class="col-lg-12">                    
                    <div class=" panel panel-body">  
                        Subtotal =  <asp:Label ID="lblsubTotal" runat="server" Font-Bold="true"  Text="0"></asp:Label><br /> 
                        <asp:Label ID="Label4" Font-Size="11px" runat="server" Text="Discount = "></asp:Label>
                         <asp:Label ID="lbldiscountamt" Font-Size="11px" runat="server" Text="0"></asp:Label> <br />                          
                        <asp:Label ID="Label2" Font-Size="11px" runat="server" Text="Vat"></asp:Label>
                        (<asp:Label ID="lblVatRate" Font-Size="9px" runat="server" Text="0"></asp:Label>% )
                        <asp:Label ID="lblVatAmount"  Font-Size="11px"  runat="server" Text="0"></asp:Label><br /> 
                        Shipping =  <asp:Label ID="lblshippingcost" runat="server" Font-Size="12px"   Text="0"></asp:Label><br /> 
                        Total =     <asp:Label ID="lbltotal" runat="server" Font-Bold="true" Text="0"></asp:Label> <br />
                           
                    </div>
                </div>


                <div style="text-align:left; background-color:White"      class="col-lg-12">                    
                    <div class="panel"> <u> Other Comments or special instructions</u> <br />
                        <asp:Label ID="lblComment" Font-Size="12px" runat="server" Text="----"></asp:Label>
                   </div>
                    
                </div>

                 <div     class="col-lg-12" style="text-align:center; background-color:White"  >                     
                    <div class="panel panel-info">
                            If you have any questions about this <b> Order invoice </b>, please contact<br />
                             <asp:Label ID="lblcomphone" Font-Size="12px" runat="server" Text="-"></asp:Label><br />
                            Thanks you for your Business!
                    </div>
                </div>
            </div>
   </div>   
</div>

 
 
</asp:Content>

