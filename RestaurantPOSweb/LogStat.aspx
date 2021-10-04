<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LogStat.aspx.cs" Inherits="LogStat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Dashboard/Default.aspx">Home</asp:HyperLink><br />
    <div>Log statistics <br /><asp:Label ID="lbtotalRow" runat="server" Text="-"></asp:Label>
    <asp:Panel runat="server" Height="550px" ScrollBars="Vertical" >
        
        <asp:GridView ID="grdviewLogstat" runat="server">
        </asp:GridView>
    </asp:Panel>
    </div>
    </form>
</body>
</html>
