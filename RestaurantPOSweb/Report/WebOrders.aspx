<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="WebOrders.aspx.cs" Inherits="Report_Report_WebOrders" %>

 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
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
        <script src="../Scripts/PrintPosCopy.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="col-lg-10 col-lg-offset-1">
    <div class="well well-sm">
        <atk:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateFrom" />
        <asp:TextBox ID="txtDateFrom" runat="server" ToolTip="Your Starting Date"   
        placeholder="Starting Date" AutoPostBack="True" 
        ontextchanged="txtDateFrom_TextChanged"></asp:TextBox>

        <atk:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="txtDateTo" />
        <asp:TextBox ID="txtDateTo" runat="server"  ToolTip="End Date"  AutoPostBack="True"   
        placeholder="End Date" ontextchanged="txtDateTo_TextChanged"></asp:TextBox>     
        <asp:Button ID="btngetdata" runat="server" class="btn btn-group btn-sm" OnClick="txtDateTo_TextChanged" Text="GO" />|
          <input type="button" class="btn btn-success btn-sm" value="Print"  onclick="javascript:printDiv('wrapper')" />   
    </div>
 
        <div class="panel panel-primary"> 
          
                <div class="panel-body">
                <asp:Label ID="lbtotalRow" Font-Size="11px"  runat="server" Text=""></asp:Label>

                <asp:Label ID="lblVat" Font-Size="11px" runat="server" Font-Bold="true" Text=""></asp:Label> 
                <span style="padding-left:130px">  <asp:Label ID="lblTotal" Font-Bold="true"   Font-Size="11px" runat="server" Text=""></asp:Label></span>  
              
              
                      <asp:Panel ID="pnlContents" runat="server" ScrollBars="Vertical" Height="450px">
                          <div id="wrapper">    
                               <span style="text-align:center"> 
                                <asp:Label ID="lblshopTitle" Font-Size="23px" runat="server" Text="-"  Font-Names="High Tower Text"></asp:Label> <br />
                                <asp:Label ID="lblshopAddress"  Font-Size="11px" runat="server" Text="-"></asp:Label>  <br />
                                <asp:Label ID="lblwebAddress"  Font-Size="11px"  runat="server" Text=""></asp:Label> <br />

                                <asp:Label ID="Label16" Font-Size="11px" runat="server" Text="Phone:"></asp:Label> 
                                <asp:Label ID="lblPhone" Font-Size="11px" runat="server" Text=""></asp:Label>  <br />
                                <asp:Label ID="lblDatetime" Font-Size="11px" runat="server" Text=""></asp:Label> <br /><br />
                                <asp:Label ID="Label1" Font-Size="14px" runat="server" Text="Web Orders"></asp:Label>
                               </span>   <br /> <hr />  
                        <asp:GridView ID="grdViewReport" runat="server" 
                                      class="table table-striped table-hover" Font-Size="11px" 
                              onrowdatabound="grdViewReport_RowDataBound" ShowFooter="true">
                         <Columns>
                              <asp:TemplateField HeaderText="Details">
                                    <ItemTemplate>                     
                                         <asp:LinkButton ID="LinkDetails" runat="server" ForeColor="Red"  Font-Size="15px"  OnClick="LinkDetails_click"     ToolTip="Details" class="glyphicon glyphicon-arrow-right"  />                                 
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



