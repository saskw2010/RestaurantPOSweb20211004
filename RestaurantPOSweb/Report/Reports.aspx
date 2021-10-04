<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type = "text/javascript">
         function PrintPanel() {
             var panel = document.getElementById("<%=pnlContents.ClientID %>");
             var printWindow = window.open('', '', 'height=660,width=830');
             printWindow.document.write('<html><head><title>Report Print</title>');
             printWindow.document.write('</head><body>');
             printWindow.document.write(panel.innerHTML);
             printWindow.document.write('</body></html>');
             printWindow.document.close();
             setTimeout(function () {
                 printWindow.print();
             }, 500);
             return false;
         }
    </script>
    <%--//https://www.neodynamic.com/articles/How-to-print-raw-ESC-POS-commands-from-ASP-NET-directly-to-the-client-printer/--%>
        <script src="../Scripts/PrintPosCopy.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="col-lg-12">
    <div class="well well-sm"  >

            <asp:Button ID="btnTodaySales" runat="server" Text="Today Sales" 
            class="btn btn-success btn-sm" onclick="btnTodaySales_Click" />  

             <asp:Button ID="btnMonthlySales" runat="server" Text="Last 30 Days"  ToolTip="Current Month"
            class="btn btn-primary btn-sm" onclick="btnMonthlySales_Click" />

             <asp:Button ID="btnCashType" Visible="false" runat="server" Text="Cash"  ToolTip="Sales by Cash Type"
            class="btn btn-warning btn-sm" onclick="btnCashType_Click" /> | |           

            <asp:Button ID="btnReports" Visible="false"  runat="server" Text="Print Report" 
            class="btn btn-info"  PostBackUrl="~/Report/SalesReports.aspx" />
             
             <%--<asp:LinkButton ID="lnkVoucherPrint" ToolTip="Print Report " class="fa fa-print" Font-Size="20px" OnClientClick = "return PrintPanel();"   runat="server"></asp:LinkButton>--%> |
             <input type="button" class="btn btn-success btn-sm" value="Print"  onclick="javascript:printDiv('wrapper')" />      

              <asp:Button ID="Button1"   runat="server" Text="Chart"    class="btn btn-primary btn-sm"         PostBackUrl="~/Report/ChartReport.aspx" /> 
            <br /><br />

        <asp:Label ID="Label1" Font-Size="11px" runat="server" Text="Search by Invoice ID , Served by  or Customer ID , ShopID , Pay Type | Date to Date"></asp:Label><br />

        <asp:TextBox ID="txtInvoiceNo" runat="server" AutoCompleteType="Search"  placeholder="Search"
        ToolTip="Search by Invoice ID i.e: 1001 , Served by  or Customer ID , ShopID , Pay Type "  
        AutoPostBack="True" ontextchanged="txtInvoiceNo_TextChanged" Width="300px"></asp:TextBox>  
     
           <atk:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtInvoiceNo"
            MinimumPrefixLength="1" EnableCaching="true"   CompletionSetCount="1" CompletionInterval="100" 
            ServiceMethod="GetMDN">
            </atk:AutoCompleteExtender> 

        <atk:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateFrom" />
        <asp:TextBox ID="txtDateFrom" runat="server" ToolTip="Your Starting Date"   
        placeholder="Starting Date" AutoPostBack="True" 
        ontextchanged="txtDateFrom_TextChanged"></asp:TextBox>

        <atk:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateTo" />
        <asp:TextBox ID="txtDateTo" runat="server"  ToolTip="End Date"  AutoPostBack="True"   
        placeholder="End Date" ontextchanged="txtDateTo_TextChanged"></asp:TextBox>  
            <br /><br />
        <asp:Label ID="Label10" runat="server" Font-Size="12px" Text="Shop Location"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="ddllocation" runat="server" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>                            
        <asp:DropDownList ID="ddllocation" runat="server" CssClass="TKinput  TKinputwidth-med TKinput-layout TKinput-focus"
            OnSelectedIndexChanged="ddllocation_SelectedIndexChanged"   ValidationGroup="vlpg43" AutoPostBack="True"></asp:DropDownList>   
         
    </div>
 
        <div class="panel panel-primary"> 
          
                <div class="panel-body">
                <asp:Label ID="lbtotalRow" Font-Size="11px"  runat="server" Text=""></asp:Label>

                <asp:Label ID="lblVat" Font-Size="11px" runat="server" Font-Bold="true" Text=""></asp:Label> 
                <span style="padding-left:130px">  <asp:Label ID="lblTotal" Font-Bold="true"   Font-Size="11px" runat="server" Text=""></asp:Label></span>  
                <span style="padding-left:130px">  <asp:Label ID="lbltotalProfit" Font-Bold="true"   Font-Size="11px" runat="server" Text=""></asp:Label></span>  
                
              
                      <asp:Panel ID="pnlContents" runat="server" ScrollBars="Vertical" Height="400px">
                          <div id="wrapper">    
                               <span style="text-align:center"> 
                                <asp:Label ID="lblshopTitle" Font-Size="23px" runat="server" Text="-"  Font-Names="High Tower Text"></asp:Label> <br />
                                <asp:Label ID="lblshopAddress"  Font-Size="11px" runat="server" Text="-"></asp:Label>  <br />
                                <asp:Label ID="lblwebAddress"  Font-Size="11px"  runat="server" Text=""></asp:Label> <br />

                                <asp:Label ID="Label16" Font-Size="11px" runat="server" Text="Phone:"></asp:Label> 
                                <asp:Label ID="lblPhone" Font-Size="11px" runat="server" Text=""></asp:Label>  <br />
                                  <asp:Label ID="lblDatetime" Font-Size="11px" runat="server" Text=""></asp:Label><br /><br />
                                <asp:Label ID="Label3" Font-Size="14px" runat="server" Text="Sales Report"></asp:Label> 
                               </span>   <br /> <hr />  
                        <asp:GridView ID="grdViewReport" runat="server" 
                              class="table table-striped table-hover" Font-Size="11px" 
                              onrowdatabound="grdViewReport_RowDataBound" ShowFooter="true">
                         <Columns>
                              <asp:TemplateField HeaderText="Details">
                                    <ItemTemplate>                     
                                         <asp:LinkButton ID="LinkDetails" runat="server" ForeColor="Red"  Font-Size="15px"  OnClick="LinkDetails_click"     ToolTip="Details" class="glyphicon glyphicon-fullscreen"  />                                 
                                    </ItemTemplate>
                              </asp:TemplateField>                     
                              </Columns> 
                            </asp:GridView>
                     </div>      
                   </asp:Panel>  
                                  
                </div>
         </div>
</div>

<%--/////////////////Details Popup View  Details Popup View         Details Popup View ///////////////////--%>

     <asp:Button ID="btnShowPopup" runat="server" style="display:none" />      
    <atk:ModalPopupExtender ID="ModalPopupDetails" runat="server" TargetControlID="btnShowPopup" 
    PopupControlID="pnlpopupDetails"  CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </atk:ModalPopupExtender>


<asp:Panel ID="pnlpopupDetails"  class="panel panel-info" runat="server" BackColor="White" style="display:none;text-align:left"  Width="600px"   > 
    <div class="panel-heading" ><span  class="fa fa-list"> </span> 
            <asp:Label ID="Label2" runat="server"   Text="  Details View"></asp:Label>  |  
           <asp:Label ID="lblInvoiceID" runat="server" Text=""></asp:Label>
      </div>
      
       <div class="panel-body">       
            <asp:Button ID="btnClose" class="btn btn-danger btn-sm" runat="server" Text="Close" />   
             <span style="padding-left:300px"> 
              <asp:Button ID="btntakepayment" runat="server" class="btn btn-warning btn-sm" Text="Take due payment" onclick="btntakepayment_Click"   />      
                <asp:Button ID="btnMovetoPrintPage" class="btn btn-success btn-sm" runat="server" Text="Print" onclick="btnMovetoPrintPage_Click" />  
             </span> 
        </div>
   

        <div class="panel-body">   <div style="border-top:1px solid #000; padding-top:10px;">   </div> 
          <asp:Label Font-Size="11px" ID="lblRowCount" runat="server" Text=""></asp:Label>    
            <asp:Panel ID="Panel2" runat="server" Height="300px" ScrollBars="Vertical">
                         
                 <asp:GridView   class="table table-striped table-hover" Font-Size="11px"  ID="grdviewTrXDetails" runat="server"></asp:GridView>            
            </asp:Panel>  
        </div>

        <div class="panel-footer">  Due:
            <asp:Label ID="lblDueAmount" Font-Size="11px" runat="server" Text=""></asp:Label> ||
            <asp:Label ID="lblNetTotal" Font-Size="11px" runat="server" Text=""></asp:Label> 
             <span style="padding-left:200px">              
                <asp:Label ID="lblProfit" Font-Size="13px" runat="server" Text=""></asp:Label>     
            </span> 
        </div>

</asp:Panel>

</asp:Content>

