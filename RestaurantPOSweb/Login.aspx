<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs"   enableEventValidation="false" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login | Point of sale System</title>
    <link href="BootStrapFiles/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="BootStrapFiles/signin.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
<div class="col-lg-3 col-lg-offset-4" >
      <div class="panel panel-primary">
                    <div class="panel-heading">
                    <h3 class="panel-title"  style="text-align:center">                        
                     Point of sale                 
                    </h3>
                  </div>
    <div class="panel-body" > 

      <form class="form-signin" role="form">     
        <h5 class="form-signin-heading">Please sign in admin/admin</h5> 
        
     <asp:Label ID="lblLogMsg" runat="server"   ForeColor="Red" Text="---------"></asp:Label>

        <asp:TextBox ID="txtuser" runat="server" type="text" class="form-control" placeholder="User ID" required autofocus></asp:TextBox>
        <asp:TextBox ID="txtpass" runat="server" class="form-control" 
          placeholder="Password" required TextMode="Password"></asp:TextBox>
        
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> Remember me
        </label> 
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
          ErrorMessage="*" ControlToValidate="txtuser"></asp:RequiredFieldValidator>
        <asp:Button ID="btnSubmit" runat="server" Text="Sign in" 
            class="btn btn-lg btn-primary btn-block btn-sm" onclick="btnSubmit_Click" />   
      </form>    
    </div>
      
  </div>
      

          <%--Footer--%>
      
            <div class="panel panel-primary" >   
                <div class="panel-footer"  style="text-align:center">
                         
					    Developed by <a href="http://codecanyon.net/user/dynamicsoft" target="_blank"> DynamicSoft </a>  <br/>
                        Copyright © 2014 - <%= DateTime.Now.Year.ToString() %>  All Rights Reserved.
                     
                </div>
            </div>
  </div>       
        <%--Footer--%>

       <%-- Traffic Statistics --%>
<%--             <div class="col-lg-3 col-lg-offset-4" >
                  <a href="http://info.flagcounter.com/LId3">
                <img src="http://s05.flagcounter.com/count/LId3/bg_FFFFFF/txt_000000/border_CCCCCC/columns_4/maxflags_20/viewers_0/labels_1/pageviews_1/flags_0/" alt="Flag Counter" border="0">
                </a>
        </div>  --%>
 
    </form>

</body>
</html>
