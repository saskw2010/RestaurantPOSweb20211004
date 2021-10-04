<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="UploadItems.aspx.cs" Inherits="Items_UploadItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="col-lg-8 col-lg-offset-2">
        <div class="well well-sm"  >
            <div class="col-lg-6" style="text-align:left">
                <asp:HyperLink ID="hlnkManageItems" Font-Size="20px" ForeColor="Black" ToolTip="Manage Items"  class="glyphicon glyphicon-list" NavigateUrl="~/Items/ManageItems.aspx"  ValidationGroup="vlpg11" runat="server"></asp:HyperLink>
                Manage Items 
          
            </div>
            <div class="col-lg-6" style="text-align:Right">
                <asp:HyperLink ID="hlnkAddCategory" Font-Size="20px" ForeColor="Black"  ToolTip="Add Category"  class="glyphicon glyphicon-plus" NavigateUrl="~/Items/AddItem.aspx"  ValidationGroup="vlpg11" runat="server"></asp:HyperLink>
                Add single item
            </div><br />
    </div>
 
       <div class="panel panel-primary" style="text-align:left">      
          <div class="panel-body">
                <asp:Label ID="Label1" class="label label-warning" Font-Size="12px" runat="server" Text="Add Item"></asp:Label>
                <asp:Label ID="Label8" runat="server" Font-Size="11px" Text="Please Select .CSV file"></asp:Label> 
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/CSVFile/csvfilesample/BulkItemsUpload.csv" Font-Underline="True"> Download CSV file Sample</asp:HyperLink>
              <hr />
 
                        <div class="col-lg-8">

                           
                            
                            <asp:UpdatePanel ID="UpdatePanelImageUpload" runat="server"  UpdateMode="Conditional">
                                <ContentTemplate>                                
                                    <asp:FileUpload ID="FileUpload1"     runat="server"    /> <br />
                                    <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label> <p></p> 
                                    <asp:Button ID="btnSubmit" runat="server" ValidationGroup="vlpg43" class="btn btn-primary btn-sm" Text="Submit" onclick="btnSubmit_Click" />
                                    </ContentTemplate>   
                                 <Triggers> <asp:PostBackTrigger   ControlID="btnSubmit"/></Triggers>      
                            </asp:UpdatePanel>                            
                             <br />
                            <asp:Label ID="Label2" runat="server" Text="Item ID/code should be unique"></asp:Label>
                        </div>
             </div>
        </div>
</div>
</asp:Content>

