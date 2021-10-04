<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo : AsyncFileUpload Control</title>
        <link href="../Styles/tooltipsCSS.css" rel="stylesheet" type="text/css" />
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
<div class="col-lg-12">
    <div   style="text-align:left">   
       <div class="panel-body">
                <asp:Label ID="Label1" class="label label-warning" Font-Size="12px" runat="server" Text="Add Item"></asp:Label>
                <asp:Label ID="Label8" runat="server" Font-Size="11px" Text="Please enter Item/product details below | and Select item picture"></asp:Label> 
                
              <hr />
                        <div class="col-lg-6">
                                <asp:Label ID="Label2" runat="server" Font-Size="12px" Text="Item Code"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtProductCode" runat="server"  ErrorMessage="*"></asp:RequiredFieldValidator>                   
                               <asp:TextBox ID="txtProductCode" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox> 

                                <asp:Label ID="Label3" runat="server" Font-Size="12px" Text="Item Name"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtproductName" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                                <asp:TextBox ID="txtproductName" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                                <asp:Label ID="Label4" runat="server"  Font-Size="12px" Text="Purchase Price"></asp:Label> 
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtpurchasePrice" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>    
                                <asp:TextBox ID="txtpurchasePrice" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>             

                                <asp:Label ID="Label6" runat="server"  Font-Size="12px" Text="Retail Price"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtRetailPrice" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                                <asp:TextBox ID="txtRetailPrice" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>


                        </div>
                        <div class="col-lg-6">

                        
                            <asp:Label ID="Label9" runat="server"  Font-Size="12px" Text="Item Qutantity"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemQty" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                            <asp:TextBox ID="txtItemQty" class="form-control" ToolTip="add Item Qutantity e.g: 10"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>

                        
                            <asp:Label ID="Label5" runat="server"  Font-Size="12px" Text="Item Discount Rate"></asp:Label>  
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="vlpg43"   ForeColor="Red"  ControlToValidate="txtItemDiscRate" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator> 
                            <asp:TextBox ID="txtItemDiscRate" ToolTip="Disc Rate without % sign" placeholder="Disc Rate without % sign" class="form-control" ValidationGroup="vlpg43" Text="0.00"  runat="server"></asp:TextBox>


                            <asp:Label ID="Label7" runat="server"  Font-Size="12px" Text="Item Category"></asp:Label>
                            <asp:DropDownList ID="DDLCategory" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:DropDownList>
                    
                          <br /><asp:Label ID="Label10" runat="server"  Font-Size="11px" Text="Select item picture * .png only"></asp:Label> <br />
                                <asp:FileUpload ID="FileUpload1"   class="btn btn-success btn-sm"  runat="server"  Width="320px" />
                            
                            <br />    <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label> <br />
                            <asp:Button ID="btnSave" runat="server" class="btn btn-primary btn-sm"  Text="Save" onclick="btnSave_Click"  />
                             |
                            <asp:Button ID="Button1" runat="server" class="btn btn-danger btn-sm"   Text="cencel" PostBackUrl="~/SalesRegister.aspx"   />

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
             </div>
 
    
        
        <asp:Label ID="Throbber" runat="server" Style="display: none"><img src="../images/indicator.gif" align="absmiddle" alt="loading" /></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblStatus" runat="server" Style="font-family: Arial; font-size: small;"></asp:Label>
        <br />
 

    </div>
</div>
    </form>
</body>
</html>
