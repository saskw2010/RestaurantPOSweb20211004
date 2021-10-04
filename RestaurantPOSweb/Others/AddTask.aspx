<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="AddTask.aspx.cs" Inherits="AddTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-5 col-lg-offset-3">
        <div class="well well-sm"  >             
             Add Task <br />
             <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Task list provide all informations, Notices from system admin or Manager"></asp:Label>
        </div>
    </div>


  <div class="col-lg-5 col-lg-offset-3">
       <div class="panel panel-primary"  style="text-align:left">    
          <div class="panel-body"> 
           <asp:Label ID="lblmessage" ForeColor="Red" runat="server" Font-Size="11px" Text=""></asp:Label>  <br />

                <asp:Label ID="Label2" runat="server" Text="Title "></asp:Label>
                <asp:TextBox ID="txtTaskTitle" class="form-control"   runat="server"></asp:TextBox>

                <asp:Label ID="Label3" runat="server" Text="Description "></asp:Label>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red"  ControlToValidate="txtTaskDescription" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtTaskDescription" class="form-control" TextMode="MultiLine"   runat="server"></asp:TextBox> 
                
                 <asp:Label ID="Label4" runat="server" Text="Task for"></asp:Label>           
                <asp:DropDownList ID="DDSentto" runat="server"  class="form-control" >    </asp:DropDownList>
                <br />
              <asp:Button ID="btnSend" runat="server" class="btn btn-primary btn-sm"  
                    Text="Send" onclick="btnSend_Click" />

          </div>
        </div>
  </div>
</asp:Content>

