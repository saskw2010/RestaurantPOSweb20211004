<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="TaskList.aspx.cs" Inherits="TaskList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-8 col-lg-offset-2">
        <div class="well well-sm"  >             
             Task List Page <br />
             <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Task list provide all informations, Notices from system admin or Manager"></asp:Label>
        </div>
    </div>

  <div class="col-lg-8 col-lg-offset-2">
       <div class="panel panel-primary"  >    
          <div class="panel-body"> 
              <asp:GridView ID="grdViewTasklist" class="table table-striped table-hover" Font-Size="11px"  runat="server">
              </asp:GridView>
          </div>
        </div>
  </div>
</asp:Content>

