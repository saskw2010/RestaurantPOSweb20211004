<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ChartReport.aspx.cs" Inherits="ChartReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type = "text/javascript">
     function PrintPanel() {
         var panel = document.getElementById("<%=pnlContents.ClientID %>");
         var printWindow = window.open('', '', 'height=660,width=830');
         printWindow.document.write('<html><head><title> Print</title>');
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><br />
 
 <atk:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateFrom" />
        
        <asp:TextBox ID="txtDateFrom" runat="server" ToolTip="Your Starting Date"   
        placeholder="Starting Date" AutoPostBack="True" 
        ontextchanged="txtDateFrom_TextChanged"></asp:TextBox>

        <atk:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateTo" />
        <asp:TextBox ID="txtDateTo" runat="server"  ToolTip="End Date"  AutoPostBack="True"   
        placeholder="End Date" ontextchanged="txtDateTo_TextChanged"></asp:TextBox> | 

          <asp:Button ID="btnMonthlySales" runat="server" Text="Last 30 Days Report"  ToolTip="Current Month"
            class="btn btn-primary btn-sm" onclick="btnMonthlySales_Click" /> 

     <%--   <asp:LinkButton ID="lnkVoucherPrint" ToolTip="Print Report " class="glyphicon glyphicon-print" Font-Size="20px" OnClientClick = "return PrintPanel();"   runat="server"></asp:LinkButton>       
           --%>  
 

<br />
<asp:Panel ID="pnlContents" runat="server" >
  Total Sales with VAT <br />
        <asp:Chart ID="ChartSalesReport"  runat="server" Width="980px">
                 <Series>
                    <asp:Series Name="Default" ToolTip="#VALX =  #VAL{}" Label="#VAL{}" 
                         BorderDashStyle="Dot" MarkerStep="10" YValuesPerPoint="20" >
                    </asp:Series>
                </Series>

                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
            </asp:Chart>

            <br /> Sales and Profit without VAT <br />

        <asp:Chart ID="ChartProfitReport"  runat="server" Width="980px">
                 <Series>
                    <asp:Series Name="Sales" ToolTip="#VALX =  #VAL{}" Label="#VAL{}" 
                         BorderDashStyle="Dot" MarkerStep="10" YValuesPerPoint="20">
                    </asp:Series>
                     <asp:Series ChartArea="ChartArea1" Name="Profit"  ToolTip="#VALX =  #VAL{}" Label="#VAL{}" 
                         BorderDashStyle="Dot" MarkerStep="10" YValuesPerPoint="20">
                     </asp:Series>
                </Series>

                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
            </asp:Chart> 

 </asp:Panel>
</asp:Content>

