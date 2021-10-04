<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateItem.aspx.cs" Inherits="UpdateItem" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo : AsyncFileUpload Control</title>
        <link rel="stylesheet" href="../BootStrapFiles/bootstrap_cerulean.css" type="text/css">

    <script type="text/javascript" language="javascript">
    
        function uploadError(sender,args)
        {
          document.getElementById('lblStatus').innerText = args.get_fileName(), "<span style='color:red;'>" + args.get_errorMessage() + "</span>";
        }
        
        function StartUpload(sender,args)
        {
            document.getElementById('lblStatus').innerText = 'Uploading Started.';
        }
        
        function UploadComplete(sender,args)
        {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of "  + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0)
            {
                text += " and content type is '" + contentType + "'.";
            }
            document.getElementById('lblStatus').innerText = text;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm1" runat="server" />

<div class="col-lg-8">
    <div style="text-align:left">   
       <div class="panel-body">
               
               <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label> 
              <br />
                        <div class="col-lg-6">
                                <asp:Label ID="Label2" runat="server" Font-Size="12px" Text="Item Code"></asp:Label><br />
                                <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtProductCode" runat="server"  ErrorMessage="*"></asp:RequiredFieldValidator>                   
                                <asp:TextBox  ReadOnly="true"  Width="310px" ID="txtProductCode"  ValidationGroup="vlpg43" runat="server"></asp:TextBox><br />

                                <asp:Label ID="Label3" runat="server" Font-Size="12px" Text="Item Name"></asp:Label><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtproductName" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                                <asp:TextBox ID="txtproductName"  Width="310px"  ValidationGroup="vlpg43"  runat="server"></asp:TextBox><br />

                                <asp:Label ID="Label4" runat="server"  Font-Size="12px" Text="Purchase Price"></asp:Label> <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtpurchasePrice" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>    
                                <asp:TextBox ID="txtpurchasePrice"  Width="310px" ValidationGroup="vlpg43"  runat="server"></asp:TextBox><br />             

                                <asp:Label ID="Label6" runat="server"  Font-Size="12px" Text="Retail Price"></asp:Label><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtRetailPrice" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                                <asp:TextBox ID="txtRetailPrice"  Width="310px"  ValidationGroup="vlpg43" runat="server"></asp:TextBox><br />

                                <asp:Label ID="Label9" runat="server"  Font-Size="12px" Text="Item Qutantity"></asp:Label><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemQty" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                                <asp:TextBox ID="txtItemQty"  Width="310px" ToolTip="add Item Qutantity e.g: 10"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                                <br />
                        
                                <asp:Label ID="Label5" runat="server"  Font-Size="12px" Text="Item Discount Rate"></asp:Label>  <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemDiscRate" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                                <asp:TextBox ID="txtItemDiscRate" Width="310px" ToolTip="Disc Rate without % sign" placeholder="Disc Rate without % sign"   ValidationGroup="vlpg43" Text="0.00"  runat="server"></asp:TextBox>
                                <br />

                        </div>
                        <div class="col-lg-6">                   
                 

                            <asp:Label ID="Label7" runat="server"  Font-Size="12px" Text="Item Category"></asp:Label><br />
                            <asp:DropDownList ID="DDLCategory" Width="310px"    ValidationGroup="vlpg43" runat="server"></asp:DropDownList><br />
                       
                            <asp:Image ID="imgItemPhoto"   runat="server"   /><br /> .png only 
                          <br />  <asp:FileUpload ID="FileUpload1"   class="btn btn-success btn-sm"  runat="server"  Width="320px" />
                            <br />
                                  <asp:Label ID="lblStatus" runat="server" Style="font-family: Arial; font-size: small;"></asp:Label>
                                    <br /> 
                            <asp:Button ID="btnUpdate" runat="server" class="btn btn-success btn-sm"  Text="Update" onclick="btnUpdate_Click" />   <br />
                           
                         
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ErrorMessage="Please add decimal value e.g: 20.11 or 20" ForeColor="Red"  ControlToValidate="txtpurchasePrice" ValidationGroup="vlpg43" 
                            ValidationExpression="\d{0,9}"></asp:RegularExpressionValidator> <br />

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                            ErrorMessage="Please add decimal value" ForeColor="Red"  ControlToValidate="txtRetailPrice" ValidationGroup="vlpg43" 
                            ValidationExpression="\d{0,9}"></asp:RegularExpressionValidator> <br />

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                            ErrorMessage="Please  add  Item Discount Rate" ForeColor="Red"  ControlToValidate="txtItemDiscRate" ValidationGroup="vlpg43" 
                            Display="Dynamic" ValidationExpression="^[0-9][\.\d]*(,\d+)?$"></asp:RegularExpressionValidator>
                        </div>
                          <asp:Label ID="Throbber" runat="server" Style="display: none"><img src="../images/indicator.gif" align="absmiddle" alt="loading" /></asp:Label>
        
             </div>    
  

    </div>
</div>
    </form>
</body>
</html>
