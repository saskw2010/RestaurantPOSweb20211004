<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="ResetDatabase.aspx.cs" Inherits="ResetDatabase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-8 col-lg-offset-2">
        <div class="well well-sm"  >             
             Reset Database <br />
             <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Reset sales and return transaction"></asp:Label>
        </div>
    </div>

  <div class="col-lg-8 col-lg-offset-2">
       <div class="panel panel-primary"  >    
          <div class="panel-body"> 
              <asp:Button ID="btnresetdatabase" CssClass="btn btn-danger btn-group" runat="server" Text="Reset transaction" OnClick="btnresetdatabase_Click" />
            <br />    <br />  <asp:Label ID="lblmsg" runat="server" Text=""  ForeColor="Red"></asp:Label>
          </div>
        </div>
  </div>
</asp:Content>

