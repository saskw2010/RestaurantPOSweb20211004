<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="StockItemReport.aspx.cs" Inherits="Report_StockItemReport" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms,  Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="720px" 
        Height="550px">
        <LocalReport ReportPath="Report\POS_StockItemReport.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource_StockItem" 
                    Name="StockItemDataset" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource_StockItem" runat="server" 
        DeleteMethod="Delete" InsertMethod="Insert" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="PointofsaleDataSetTableAdapters.tbl_ItemTableAdapter" 
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_ItemCode" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ItemCode" Type="String" />
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="PurchasePrice" Type="Decimal" />
            <asp:Parameter Name="RetailPrice" Type="Decimal" />
            <asp:Parameter Name="ItemQty" Type="Decimal" />
            <asp:Parameter Name="ItemCategory" Type="String" />
            <asp:Parameter Name="Tax" Type="Decimal" />
            <asp:Parameter Name="Discount" Type="Decimal" />
            <asp:Parameter Name="Logtime" Type="DateTime" />
            <asp:Parameter Name="LogBy" Type="String" />
            <asp:Parameter Name="Lastupdate" Type="DateTime" />
            <asp:Parameter Name="Lastupdateby" Type="String" />
            <asp:Parameter Name="Status" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="PurchasePrice" Type="Decimal" />
            <asp:Parameter Name="RetailPrice" Type="Decimal" />
            <asp:Parameter Name="ItemQty" Type="Decimal" />
            <asp:Parameter Name="ItemCategory" Type="String" />
            <asp:Parameter Name="Tax" Type="Decimal" />
            <asp:Parameter Name="Discount" Type="Decimal" />
            <asp:Parameter Name="Logtime" Type="DateTime" />
            <asp:Parameter Name="LogBy" Type="String" />
            <asp:Parameter Name="Lastupdate" Type="DateTime" />
            <asp:Parameter Name="Lastupdateby" Type="String" />
            <asp:Parameter Name="Status" Type="Int32" />
            <asp:Parameter Name="Original_ItemCode" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

