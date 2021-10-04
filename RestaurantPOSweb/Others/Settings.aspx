<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Panel ID="Panel1" runat="server" DefaultButton="btnUpdateSettings">
<div class="col-lg-10 col-lg-offset-1">  
<div class="col-lg-6">  
    <div class="panel panel-primary" style="text-align:left" >       
          <div class="panel-body">
           <asp:Label ID="Label8" class="label label-warning" Font-Size="12px" runat="server" Text="POS Settings"></asp:Label>  
           <asp:Label ID="Label7" runat="server" Font-Size="11px" Text="Please Update the information below"></asp:Label>        
              <p></p>
                <br />  
                    
                <asp:Label ID="Label2" runat="server" Font-Size="12px"  Text="Company Name"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" ValidationGroup="vlpg43"   ControlToValidate="txtCompanyName" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                <asp:TextBox ID="txtCompanyName"  BackColor="#D7FDF9" ToolTip="Please Enter Company Name" class="form-control"  ValidationGroup="vlpg43" runat="server"></asp:TextBox>
                           
                <asp:Label ID="Label3" runat="server" Font-Size="12px"  Text="Company Address"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtCompanyAddress" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtCompanyAddress"  TextMode="MultiLine"  Height="100px" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                <asp:Label ID="Label4" runat="server" Font-Size="12px"  Text="Phone"></asp:Label>  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtPhone" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>  
                <asp:TextBox ID="txtPhone" class="form-control"    ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                  <asp:Label ID="Label5" runat="server" Font-Size="12px"  Text="Email Address"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtEmailAddress" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtEmailAddress" class="form-control"    ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

          
              
                <asp:Label ID="Label9" runat="server" Font-Size="12px"  Text="Web Address"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtWebAddress" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtWebAddress" class="form-control"    ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                <asp:Label ID="Label10" runat="server" Font-Size="12px"  Text="VAT %"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtVatRate" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtVatRate" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                <asp:Label ID="Label1" runat="server" Font-Size="12px"  Text="VAT Registration No"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtvatRegiNo" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtvatRegiNo" class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                <asp:Label ID="Label19" runat="server" Font-Size="12px"  Text="Shipping Cost"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtshippingcost" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtshippingcost" ToolTip="This shipping cost will apply for Customer when order using web order" placeholder="10"
                     class="form-control" ValidationGroup="vlpg43"  runat="server"></asp:TextBox>

                <asp:Label ID="Label6" runat="server" Font-Size="12px"  Text="Footer Message"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" ValidationGroup="vlpg43"  ControlToValidate="txtFooterMessage" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                              
                <asp:TextBox ID="txtFooterMessage"  BackColor="#D7FDF9"  TextMode="MultiLine" Font-Size="11px" ToolTip="Please Enter Receipt Footer message" class="form-control" ValidationGroup="vlpg43" runat="server"></asp:TextBox>
              <br />
              <asp:Button ID="btnUpdateSettings" runat="server"  ValidationGroup="vlpg43"  
                  class="btn btn-primary btn-sm" Text="Update Settings"     onclick="btnUpdateSettings_Click" /> 
            </div>
                 <div class="footer"></div> 
          </div>
    </div>


<%--   -------------------------------- Email setup ------------------------------%>
    <div class="col-lg-4"> 
    <div class="panel panel-primary" style="text-align:left" >       
          <div class="panel-body">
           <asp:Label ID="Label11" class="label label-success" Font-Size="12px" runat="server" Text="Email Setup"></asp:Label>          
              <p></p>
                <br />  
            <div class="col-lg-12">           
                <asp:Label ID="Label12" runat="server" Font-Size="12px"  Text="Smtp*"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="Red" ValidationGroup="vlpgemail"   ControlToValidate="txtsmtp" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                     
                <asp:TextBox ID="txtsmtp"   placeholder="smtp.gmail.com"  ToolTip="Please Enter SMTP Address" class="form-control"  ValidationGroup="vlpgemail" runat="server"></asp:TextBox>
                           
                <asp:Label ID="Label13" runat="server" Font-Size="12px"  Text="Port no*"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="Red" ValidationGroup="vlpgemail"  ControlToValidate="txtportno" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Numeric Only" ControlToValidate="txtportno"
                ValidationExpression="^\d+$" ForeColor="Red" Font-Size="8"  ValidationGroup="vlpgemail"  ></asp:RegularExpressionValidator>
                 <asp:TextBox ID="txtportno" placeholder="587"  class="form-control" ValidationGroup="vlpgemail"  runat="server"></asp:TextBox>
                 
                <asp:Label ID="Label14" runat="server" Font-Size="12px"  Text="Display Title*"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ForeColor="Red" ValidationGroup="vlpgemail"  ControlToValidate="txtdispalyname" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtdispalyname" class="form-control" placeholder="Your company name"    ValidationGroup="vlpgemail"  runat="server"></asp:TextBox>

                <asp:Label ID="Label15" runat="server" Font-Size="12px"  Text="Sender Email address"></asp:Label>  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ForeColor="Red" ValidationGroup="vlpgemail"  
                    ControlToValidate="txtemailuser" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>  
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="vlpgemail" ForeColor="Red" 
                runat="server" ErrorMessage="Please insert valid email address"   ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ControlToValidate="txtemailuser"></asp:RegularExpressionValidator> 
                 <asp:TextBox ID="txtemailuser" class="form-control" placeholder="senderemail@gmail.com"    ValidationGroup="vlpgemail"  runat="server"></asp:TextBox>
                       

                <asp:Label ID="Label16" runat="server" Font-Size="12px"  Text="Password*"></asp:Label> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="Red" ValidationGroup="vlpgemail"  ControlToValidate="txtPassword" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>                             
                <asp:TextBox ID="txtPassword" class="form-control"   placeholder="*****"     ValidationGroup="vlpgemail"  runat="server"></asp:TextBox>
 <hr />
                <asp:Label ID="Label17" runat="server" Font-Size="12px"  Text="Contact us Email: Company receive email from customer"></asp:Label>  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="Red" ValidationGroup="vlpgemail"  
                    ControlToValidate="txtcontactus" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>  
           
                 <asp:TextBox ID="txtcontactus" class="form-control" ToolTip="Contact us Email" placeholder="customercare@gmail.com"    ValidationGroup="vlpgemail"  runat="server"></asp:TextBox>
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationGroup="vlpgemail" ForeColor="Red" 
                runat="server" ErrorMessage="Please insert valid email address"   ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ControlToValidate="txtcontactus"></asp:RegularExpressionValidator>  <br />
                
                <asp:Label ID="Label18" runat="server" Text="Enable Email function"></asp:Label>  
                <asp:DropDownList ID="ddlenable"  class="form-control"  ValidationGroup="vlpgemail" runat="server">
                    <asp:ListItem Value="Yes"  Text="Yes"></asp:ListItem>     
                    <asp:ListItem Value="No"  Text="No"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Button ID="btnEmailsetup"    runat="server"  ValidationGroup="vlpgemail"  
                  class="btn btn-warning btn-sm" Text="Update Email setup"     onclick="btnEmailsetup_Click" /> 

            </div>
            
          </div>
    </div>
</div>

</div>

</asp:Panel>
</asp:Content>

