<%@ Page Title="" Language="C#"  MasterPageFile="~/MasterPage/Bootstrap.master"  AutoEventWireup="true" CodeFile="SalesReports.aspx.cs" Inherits="Report_SalesReports" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms,  Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> <br />
   
<atk:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateFrom" />
<asp:TextBox ID="txtDateFrom" runat="server" ToolTip="Your Starting Date"   
placeholder="Starting Date" AutoPostBack="True" 
ontextchanged="txtDateFrom_TextChanged"></asp:TextBox>

<atk:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateTo" />
    <asp:TextBox ID="txtDateTo" runat="server"  ToolTip="End Date"  AutoPostBack="True"   
    placeholder="End Date" ontextchanged="txtDateTo_TextChanged"></asp:TextBox>

    <asp:TextBox ID="txtShopID" runat="server"  ToolTip="Search by Shop ID or Employee"  AutoPostBack="True"   
    placeholder="Search by Shop ID" ontextchanged="txtShopID_TextChanged"  ></asp:TextBox> 

<asp:Button ID="btnTodaySales" runat="server" Text="Today Sales" 
class="btn btn-success btn-sm" onclick="btnTodaySales_Click" />  

<hr />

    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="720px" Height="450px">
        <LocalReport ReportPath="Report\POS_SalesReports.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSourceSalesReport" Name="SalesDS" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSourceSalesReport" runat="server" 
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetData" 
        TypeName="SalesReportDataSetTableAdapters.tbl_SalesPaymentTableAdapter">
        <InsertParameters>
            <asp:Parameter Name="SalesQty" Type="Int32" />
            <asp:Parameter Name="Subtotal" Type="Decimal" />
            <asp:Parameter Name="Vat" Type="Decimal" />
            <asp:Parameter Name="totalpayable" Type="Decimal" />
            <asp:Parameter Name="payType" Type="String" />
            <asp:Parameter Name="Due" Type="Decimal" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="ShopId" Type="String" />
            <asp:Parameter Name="paidAmount" Type="Decimal" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtDateFrom" Name="Date1" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="txtDateTo" Name="Date2" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="txtShopID" Name="ShopId" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="txtShopID" Name="ServedBy" PropertyName="Text" 
            Type="String" />

        </SelectParameters>
    </asp:ObjectDataSource>
    
    <%--Search by ShopID --%>

    </asp:Content>

