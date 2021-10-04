<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="TakePayment.aspx.cs" Inherits="Sales_TakePayment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 102px;           
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    <div class="col-lg-8 col-lg-offset-2"> 
            <div class="well well-sm" >
               Sales | Take Payment                 
            </div>
        </div> 

<div class="col-lg-8 col-lg-offset-2">  
     <div class="panel panel-success" style="text-align:left" > 
        <div class="panel-heading"> Invoice No: 
            <asp:Label ID="lblInvoiceNo" runat="server" Text="Label"></asp:Label> </div>
            <div class="panel-body">                      
                            <asp:GridView ID="grdItemList" runat="server"   
                            class="table table-striped table-hover" Font-Size="11px"  
                            ShowHeaderWhenEmpty="True" onrowdatabound="grdItemList_RowDataBound"></asp:GridView>
                             
         <%--Received payment transaction list--%>
                <div    class="col-lg-12 " >   
                       <asp:GridView ID="grdpaymentlist" runat="server"   
                        class="table table-striped table-hover" Font-Size="10px"  
                        ShowHeaderWhenEmpty="True"></asp:GridView>
                </div>
            </div>
    </div>
</div>

<div class="col-lg-4 col-lg-offset-2">  
     <div class="panel panel-info" style="text-align:left" > 
        <div class="panel-heading"> Receive payment  </div>
            <div class="panel-body">                      
                <table class="style1">
                    <tr>
                            <td class="style2">
                                Payment:  
                            </td>
                            <td>
                                <asp:TextBox ID="txtPaid" placeholder="Customer paid Amount"  ToolTip="Customer paid Amount" runat="server" class="form-control" 
                                    AutoPostBack="True"  ></asp:TextBox> 

                                <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtPaid" ValidationGroup="vr12"  Font-Size="11px" 
                                ID="RequiredFieldValidator1" runat="server"   ErrorMessage="Enter paid amount" SetFocusOnError="True"></asp:RequiredFieldValidator>

                                <asp:RegularExpressionValidator ForeColor="Red" Font-Size="11px" ValidationGroup="vr12" 
                                ControlToValidate="txtPaid" ID="RegularExpressionValidator1" 
                                runat="server" ErrorMessage="Enter a valid number" ValidationExpression="[0-9]*\.?[0-9]*" SetFocusOnError="True">
                                </asp:RegularExpressionValidator> 
                                                                  
                            </td>
                        </tr> 
                        
                        <tr>
                                <td class="style2">
                                    Paid by:  <br />    <br />
                                </td>
                                <td>
                                    <asp:DropDownList ID="DDLPaidBy" runat="server" class="form-control">
                                        <asp:ListItem>Cash</asp:ListItem>
                                        <asp:ListItem>Cheque</asp:ListItem>
                                        <asp:ListItem>Cradit Card</asp:ListItem>
                                        <asp:ListItem>Paypal</asp:ListItem>
                                        <asp:ListItem>Online</asp:ListItem>
                                    </asp:DropDownList>  <br />    
                                </td>
                        </tr>      
                       
                            <tr>
                                <td class="style2">
                                    Date:  <br />  <br />
                                </td>
                            
                                <td>
                                        <atk:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDate" />
                                        <asp:TextBox ID="txtDate" runat="server"  class="form-control" ToolTip="Order Date" placeholder="Select Date"></asp:TextBox>  
                                         <asp:RequiredFieldValidator  ForeColor="Red"  ControlToValidate="txtDate" ValidationGroup="vr12"  Font-Size="11px" 
                                    ID="RequiredFieldValidator2" runat="server"   ErrorMessage="Please select Date" SetFocusOnError="True"></asp:RequiredFieldValidator>  <br />
                                    <asp:Button ID="btnReceivedPayment" runat="server"  ValidationGroup="vr12" class="btn btn-success btn-sm"  Text="Submit"  onclick="btnReceivedPayment_Click"  /> 
                                </td>
                            </tr>                      
                </table>
                    
            </div>
    </div>
</div>

<div class="col-lg-4">  
     <div class="panel panel-info" style="text-align:left" > 
        <div class="panel-heading"> Amounts  </div>
            <div class="panel-body">                      
            <%--    Discount: <span  style="padding-left:10px"> <asp:Label ID="lbldis"          Font-Size="17px"  runat="server" Text="0"></asp:Label> </span> <br />--%>
                VAT:<span  style="padding-left:40px">   <asp:Label ID="lblvat"              Font-Size="17px" runat="server" Text="0"></asp:Label>  </span> <br />
                Net Total:  <span  style="padding-left:10px"> <asp:Label ID="lbltotal"      Font-Size="17px"  runat="server" Text="0"></asp:Label> </span>  <br />
                Due:  <span  style="padding-left:40px"> <asp:Label ID="lblDue"              Font-Size="17px"  runat="server" Text="0"></asp:Label></span> 
            
            </div>
    </div>
</div>

</asp:Content>

