<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ManageCustomers.aspx.cs" Inherits="ManageCustomers" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="atk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       
        
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>

<script> 
$(document).ready(function() {
	    $('#<%=lblNoRecords.ClientID%>').css('display','none');

	    $('#<%=txtSearch.ClientID%>').click(function (e)
	    {
	        // Hide No records to display label.
	        $('#<%=lblNoRecords.ClientID%>').css('display','none');
	        //Hide all the rows.
	        $("#<%=grdVcustomersList.ClientID%> tr:has(td)").hide();
	         
	        var iCounter = 0;
	        //Get the search box value
	        var sSearchTerm = $('#<%=txtSearch.ClientID%>').val();
	         
	        //if nothing is entered then show all the rows.
	        if(sSearchTerm.length == 0)
	        {
	            $("#<%=grdVcustomersList.ClientID%> tr:has(td)").show();
	          return false;
	      }

	        //Iterate through all the td.
	      $("#<%=grdVcustomersList.ClientID%> tr:has(td)").children().each(function ()
	        {
	            var cellText = $(this).text().toLowerCase();
	            //Check if data matches
	            if(cellText.indexOf(sSearchTerm.toLowerCase()) >= 0)
            {   
	                $(this).parent().show();
	                iCounter++;
	                return true;
	            }
	        });
	        if(iCounter == 0)
	        {
	            $('#<%=lblNoRecords.ClientID%>').css('display','');
	        }
	        e.preventDefault();
	    })
	})
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-lg-10 col-lg-offset-1"> 
        <div class="well well-sm"  >
            <asp:Button ID="btnAdduser"  ValidationGroup="vlg656766" CssClass="btn btn-warning btn-xs" runat="server" Text="Add Customer" PostBackUrl="~/People/AddCustomer.aspx" />
        </div>
 
        <div class="panel panel-info"> 
            <div class="panel-heading" ><span  class="glyphicon glyphicon-list"> </span> Customers list </div>
                <div class="panel-body">
                    <asp:Label ID="lbtotalRow" runat="server" Text="------"></asp:Label>

            <div class="input-group"> <span class="input-group-addon">Filter</span>
                <asp:TextBox ID="txtSearch"    ValidationGroup="vlg9996"  class="form-control" placeholder="Type here..." runat="server"></asp:TextBox>
                 
            </div>
           <%-- class="table table-bordered table-striped table-hover table-heading table-datatable"--%>
                    <asp:Label ID="lblNoRecords" runat="server" Text=""></asp:Label>
                  

            <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="380px">
                <asp:GridView ID="grdVcustomersList" runat="server" data-search="true" class="table table-striped"   Font-Size="11px">
                  <Columns>
                      <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>                              
                                <asp:LinkButton ID="btnEdit" runat="server"  Font-Size="15px"   ToolTip="Edit" class="glyphicon glyphicon-edit "     OnClick="LinkEdit_Click"   />  |   
                                 <asp:LinkButton ID="LinkbanCustomer" runat="server" ForeColor="Red"  Font-Size="15px"   OnClick="LinkbanCustomer_Click"  ToolTip="Ban or Inactive Customer" class="glyphicon glyphicon-ban-circle"  />                                 
                            </ItemTemplate>
                      </asp:TemplateField>                     
                      </Columns>
                    </asp:GridView>
                    </asp:Panel>
                </div>
         </div>
  
</div>
<%--<<<<<<<<<<<<<<<<<<<<< --------------- Edit  Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
        <asp:Button ID="btnShowPopup" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="MpeEditShow" runat="server" TargetControlID="btnShowPopup" 
        PopupControlID="pnlpopupEditView"  CancelControlID="btnClose" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupEditView"  class="panel panel-primary" runat="server" BackColor="White" style="display:none"  Width="300px"  DefaultButton="btnSave"> 
      <div class="panel-heading"> 
          <asp:Label ID="lblID" runat="server" Text="Label"></asp:Label>: Edit Customer    
                                            
    </div>
               
    <div class="panel-body" style="text-align:left" >      

        <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Customer Name"></asp:Label><br />
        <asp:TextBox ID="txtCustName"    Font-Bold="true"  Width="275px"     runat="server"></asp:TextBox><br />

        <asp:Label ID="Label4" runat="server" Font-Size="11px" Text="Contact"></asp:Label><br />
        <asp:TextBox ID="txtContact"     Width="275px"     runat="server"></asp:TextBox><br />

        <asp:Label ID="Label2" runat="server" Font-Size="11px" Text="Email"></asp:Label><br />
        <asp:TextBox ID="txtEmail"     Width="275px"     runat="server"></asp:TextBox><br />

        <asp:Label ID="Label8"   runat="server" Text="Password:*"></asp:Label>                
        <asp:RequiredFieldValidator  ForeColor="Red"  Font-Size="12px"  ControlToValidate="txtPassoword" ValidationGroup="vlpg43"  
        ID="RequiredFieldValidator12323" runat="server"      ErrorMessage="Please insert password"></asp:RequiredFieldValidator>  
        <asp:TextBox ID="txtPassoword"     class="form-control"  runat="server" ></asp:TextBox>             
  

        <asp:Label ID="Label3" runat="server" Font-Size="11px" Text="Address"></asp:Label><br />
        <asp:TextBox ID="txtaddress"  Font-Size="11px"   Width="275px"  TextMode="MultiLine"    runat="server"></asp:TextBox><br />

        <hr />
        <asp:Label ID="Label5" runat="server" Font-Size="11px" Font-Bold="true" Text="Customer Type"></asp:Label><br />
        <asp:TextBox ID="txtCustType"      Width="275px"       runat="server"></asp:TextBox><br />

        <asp:Label ID="Label6" runat="server" Font-Size="11px" Text="Discount %"></asp:Label><br />
        <asp:TextBox ID="txtDiscount"      Width="275px"       runat="server"></asp:TextBox><br />

        <asp:Label ID="lblmsg" runat="server" Font-Size="11px" ForeColor="Red" Text="-"></asp:Label>
                
    </div>
    <div class="panel-footer"> 
        <asp:Button ID="btnSave" class="btn btn-success btn-sm" runat="server"   Text="Save"   onclick="btnSave_Click"  />
        <asp:Button ID="btnClose" class="btn btn-danger btn-sm" runat="server" Text="Close" />
    </div>  
 </asp:Panel> 
 <%--<<<<<<<<<<<<<<<<<<<<<END --------------- Edit   Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>


 <%--<<<<<<<<<<<<<<<<<<<<< --------------- Inactive user  Popup -------------- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--%>
        <asp:Button ID="btnShowPopupInAct" runat="server" style="display:none" />         
        <atk:ModalPopupExtender ID="ModalPopupInactive" runat="server" TargetControlID="btnShowPopupInAct" 
        PopupControlID="pnlpopupInactive"  CancelControlID="btnCloseInactive" BackgroundCssClass="modalBackground">
        </atk:ModalPopupExtender>

<asp:Panel ID="pnlpopupInactive"  class="panel panel-primary" runat="server" BackColor="White" style="display:none"  Width="300px"  DefaultButton="btnInactive"> 
   <asp:Label ID="lblInactiveID" runat="server" Text="0"></asp:Label>. 
    <asp:Label ID="lblInactiveCustName" runat="server" Text="0"></asp:Label>  <hr /> 
     <asp:Label ID="Label7" runat="server" class="label label-info" Text="Do you want to Inactive this user ???"></asp:Label> <br />
 <br />
<div class="panel-footer"> 
        <asp:Button ID="btnInactive" class="btn btn-success btn-sm" runat="server"   Text="Yes"   onclick="btnInactive_Click"  />
        <asp:Button ID="btnCloseInactive" class="btn btn-danger btn-sm" runat="server" Text="No" />
 </div>
</asp:Panel>

</asp:Content>



