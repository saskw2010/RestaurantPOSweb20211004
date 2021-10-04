<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="POS_printPage.aspx.cs" Inherits="POS_printPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
    <style type="text/css" media="all">
        body 
        {    
            color:#000; 
            font-family: Arial, Helvetica, sans-serif; 
            
        }
        #wrapper 
        {
            width: 270px;
            margin: 0 auto; 
        } 
        .papersize
        { 
           color:Black;
           width: 270px;
          /*  font-family:SimSun; */
        }
        
        .papersize58
        {
           color:Black;
           width: 210px;
           text-align:left;
        }

        .style2
        {
            width: 100%;
            font-size:10px;
        }

    </style>       
    <script src="../Scripts/PrintPosCopy.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><br />

<%----------------------------------  Paper Size: 80mm ------------ 280 px-----------------------------%>
<div class="col-lg-3 col-lg-offset-1">
        <div  style="text-align:left">
            <asp:HyperLink ID="HyperLink2"  class="btn btn-danger btn-xs" runat="server" NavigateUrl="~/Sales/Tableview.aspx">Back</asp:HyperLink> 
            <input type="button" class="btn btn-success btn-xs" value="Print"  onclick="javascript:printDiv('wrapper80')" /> <br /><br />
 Paper Size: 80mm or  3.14inch (width)
        </div>
          <hr />

    <div  id="wrapper80" style="text-align:left">       
 
            <table class="papersize">
                <tr>
                    <td style="text-align:center">
                        <asp:Label ID="lblshopTitle" Font-Size="23px" runat="server" Text="-"  Font-Names="High Tower Text"></asp:Label> <br />
                        <asp:Label ID="lblshopAddress"  Font-Size="11px" runat="server" Text="-"></asp:Label>  <br />
                        <asp:Label ID="lblwebAddress"  Font-Size="11px"  runat="server" Text=""></asp:Label> <br />

                        <asp:Label ID="Label16" Font-Size="11px" runat="server" Text="Phone:"></asp:Label> 
                        <asp:Label ID="lblPhone" Font-Size="11px" runat="server" Text=""></asp:Label>  
                     <br /> <br />  
                     </td>
                </tr>  
                  <tr>
                    <td>
                        <asp:Label ID="Label1" Font-Size="11px" runat="server" Text="Date:"></asp:Label>
                        <asp:Label ID="lblDatetime" Font-Size="11px" runat="server" Text=""></asp:Label> <br />                                               
                       
                        <table class="style2">
                            <tr>
                                <td>
                                        <asp:Label ID="Label3" runat="server"  Font-Size="11px" Text="VAT REG:"></asp:Label>
                                        <asp:Label ID="lblVATRegiNo"  Font-Size="11px" runat="server" Text=""></asp:Label> 
                                </td>
                                <td>
                                        <asp:Label ID="Label4" runat="server"  Font-Size="11px" Text="Shop ID:"></asp:Label> 
                                        <asp:Label ID="lblShopID" runat="server"  Font-Size="11px" Text=""></asp:Label> 
                                </td>
                            </tr>
                            <tr>
                                <td>                       
                                        <asp:Label ID="Label2" runat="server"  Font-Size="11px" Text="Customer ID:"></asp:Label>
                                        <asp:Label ID="lblCustID" runat="server"  Font-Size="11px" Text=""></asp:Label> 
                                </td>
                                <td>
                                        <asp:Label ID="Label6"  Font-Size="11px" runat="server" Text="Contact No:"></asp:Label> 
                                        <asp:Label ID="lblCustContactNo" Font-Size="11px"  runat="server" Text=""></asp:Label> 
                                </td>
                            </tr>
                            <tr>
                                <td>                      
                                        <asp:Label ID="Label5"  Font-Size="11px" runat="server" Text="Name:"></asp:Label> 
                                        <asp:Label ID="lblCustName"  Font-Size="11px" runat="server" Text=""></asp:Label> 
                                </td>
                                <td>
                                        <asp:Label ID="Label7" Font-Size="11px"   runat="server" Text="ServedBy:"></asp:Label> 
                                        <asp:Label ID="lblServedBy" Font-Size="11px"   runat="server" Text=""></asp:Label> 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                       <asp:Label ID="lbltableno" Font-Size="11px" runat="server" Text="Parcel"></asp:Label> 
             
                                </td>
                                <td>
                                        <asp:Label ID="Label23" Font-Size="11px" runat="server" Text="Token:"></asp:Label>
                                        <asp:Label ID="lbltokenno" Font-Size="11px" runat="server" Text="-" Font-Bold="True"></asp:Label> 
                                </td>
                            </tr>
                        </table> <br />
                        
                        <asp:Label ID="Label15" Font-Size="11px"  runat="server" Text="Invoice #"></asp:Label>  
                        <asp:Label ID="lblInvoice" Font-Size="11px"  runat="server" Text="1003"></asp:Label> 
                        <br />                       
          <%--              <asp:GridView ID="grdItemList" Font-Size="11px"  runat="server"  
                            OnRowDataBound="grdItemList_RowDataBound" BackColor="White" 
                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                            ForeColor="Black" GridLines="Horizontal"> </asp:GridView> --%>

                        <asp:DataList ID="dtlistitems" runat="server">
                            <ItemStyle ForeColor="Black"/>
                            <ItemTemplate> 
                              <table >
                           
                            <tr> 
                                <td style="width:190px; text-align:left">   
                                <asp:Label   ID="lblCode" Font-Size="10px" runat="server" Text='<%# Bind("Code") %>'  ></asp:Label> <br />
                                <asp:Label   ID="lblItems" Font-Size="11px" runat="server" Text='<%# Bind("Items") %>' ></asp:Label> <br />
                                <asp:Label   ID="Label18" Font-Size="12px" runat="server" Text='<%# Bind("Qty") %>' ></asp:Label> - 
                                  <asp:Label   ID="Label19" Font-Size="11px" runat="server" Text='<%# Bind("Disc") %>' ></asp:Label>% - 
                                  <asp:Label   ID="Label20" Font-Size="11px" runat="server" Text='<%# Bind("Price") %>' ></asp:Label>
                                </td>                                

                                <td style="width:80px; text-align:right">                                
                                  <asp:Label   ID="Label21"  Font-Size="12px"  Font-Bold="true" runat="server" Text='<%# Bind("Total") %>' ></asp:Label>
                                </td>                              
                            </tr>  <div style="border-top:1px dotted #CCCCCC; padding-top:10px; "></div>
                            </table>
                            </ItemTemplate> 
                        </asp:DataList>
                    </td>
                </tr>

                <tr>
                    <td>
                        <table class="papersize">
                           
                            <tr>    
                                <td > <asp:Label ID="Label17"  Font-Size="11px" runat="server" Text="Total Sales Qty:"></asp:Label> <br /></td>
                                <td  style="text-align: right;" class="text-right">  <asp:Label ID="lblTotalQty" Font-Bold="true"  Font-Size="11px" runat="server" Text="0"></asp:Label> <br /> </td>                                                            
                             </tr>
                            <tr>    
                                <td> <asp:Label ID="Label14"  Font-Size="11px" runat="server" Text="Sub Total:"></asp:Label>  </td>
                                <td  class="text-right" style="text-align: right">  <asp:Label ID="lblsubTotal" Font-Bold="true"  Font-Size="11px" runat="server" Text="0"></asp:Label>   </td>                                                            
                            </tr>
                             <tr>
                                 <td>
                                 <asp:Label   Font-Size="11px" ID="Label22" runat="server" Text="Discount"></asp:Label> 
                                 </td>
                                 <td style="text-align: right;" class="text-right">
                                 <asp:Label Font-Size="11px"  ID="lbldiscountamt" runat="server" Text="0"></asp:Label>
                                
                                 </td>
                            </tr>

                            <tr>
                                 <td style="border-bottom-style: solid; border-bottom-width: thin;" >
                                 <asp:Label   Font-Size="11px" ID="Label13" runat="server" Text="Vat"></asp:Label>
                                  <asp:Label Font-Size="9px"  ID="lblvatRate" runat="server" Text="0"></asp:Label>
                                 </td>
                                 <td style="border-bottom-style: solid; border-bottom-width: thin;text-align: right;" class="text-right">
                                 <asp:Label Font-Size="11px"  ID="lblvat" runat="server" Text="0"></asp:Label>
                                
                                 </td>
                            </tr>



                            <tr> 
                                <td ><asp:Label ID="Label9" Font-Bold="true" Font-Size="12px" runat="server" Text="Net Amount:"></asp:Label>  <br /> <br />     </td>
                                <td style="text-align: right;" class="text-right"> 
                                <asp:Label ID="lbltotalpay"  Font-Size="12px"  Font-Bold="true" runat="server" Text="0"></asp:Label>   <br /> <br />   </td>
                            </tr>
                            <tr>    
                                <td><asp:Label ID="Label8"  Font-Size="11px" runat="server" Text="Pay Type:"></asp:Label>  <br />   </td>
                                <td class="text-right" style="text-align: right">
                                <asp:Label ID="lblpaidby" Font-Size="11px" Font-Bold="true" runat="server" Text="0"></asp:Label> <br />    </td>                                                            
                            </tr>

                            <tr>
                                <td><asp:Label ID="Label10"  Font-Size="11px" runat="server" Text="Paid Amount"></asp:Label> </td>
                                <td class="text-right" style="text-align: right">
                                <asp:Label ID="lblPaidAmt" Font-Size="11px" runat="server" Text="0"></asp:Label></td>                               
                            </tr>

                            <tr>
                                <td><asp:Label ID="Label11"  Font-Size="11px" runat="server" Text="Changed Amount:"></asp:Label> <br /> <br /></td>
                                <td class="text-right" style="text-align: right">
                                <asp:Label ID="lblChange" Font-Size="11px" runat="server" Text="0"></asp:Label> <br /> <br /></td>                               
                            </tr>

                             <tr>
                                <td style="border-bottom-style: solid; border-bottom-width: thin;">
                                <asp:Label ID="Label12"  Font-Size="11px" runat="server" Text="Due Amount:"></asp:Label> </td>
                               <td style="border-bottom-style: solid; border-bottom-width: thin;text-align: right">
                                <asp:Label ID="lblDue" Font-Size="11px" runat="server" Text="0"></asp:Label> </td>                               
                           </tr>
                            <div style="border-top:1px solid #000; padding-top:10px;"></div>
                        </table>
                       
                     <span style="text-align:center"> 
                             <center><asp:Label  ID="lblFooterMessage"  Font-Size="12px" runat="server" Text="-------------------"></asp:Label>  </center>
                          </span>                 
                        
                  </td>
                </tr>

            </table>
          
     </div>
 </div> 

<%----------------------------------  Paper Size: 58mm ------------ 218 px-----------------------------%>

 <div class="col-lg-2 col-lg-offset-1">
        <div  style="text-align:left">
            <asp:HyperLink ID="HyperLink1"  class="btn btn-danger btn-xs" runat="server" NavigateUrl="~/Sales/Tableview.aspx">Back</asp:HyperLink> 
            <input type="button" class="btn btn-success btn-xs" value="Print"  onclick="javascript:printDiv('wrapper58')" /> <br /><br />
 58mm or  2.28inch (width)
        </div>
          <hr />

    <div  id="wrapper58" style="text-align:left">
            <table class="papersize58">
                <tr>
                    <td style="text-align:center">
                        <asp:Label ID="lblshopTitle2" Font-Size="23px" runat="server" Text="-"  Font-Names="High Tower Text"></asp:Label> <br />
                        <asp:Label ID="lblshopAddress2"  Font-Size="11px" runat="server" Text="-"></asp:Label>  <br />
                        <asp:Label ID="lblwebAddress2"  Font-Size="11px"  runat="server" Text=""></asp:Label> <br />

                        <asp:Label ID="Label25" Font-Size="11px" runat="server" Text="Phone:"></asp:Label> 
                        <asp:Label ID="lblPhone2" Font-Size="11px" runat="server" Text=""></asp:Label>  
                     <br /> <br />  
                     </td>
                </tr>  
                  <tr>
                    <td>                       

                        <asp:Label ID="Label27" Font-Size="11px" runat="server" Text="Date:"></asp:Label>
                        <asp:Label ID="lblDatetime2" Font-Size="11px" runat="server" Text=""></asp:Label> <br />                                               
                       
                        <table class="style2">
                            <tr>
                                <td>
                                        <asp:Label ID="Label29" runat="server"  Font-Size="11px" Text="VAT REG:"></asp:Label>
                                        <asp:Label ID="lblVATRegiNo2"  Font-Size="11px" runat="server" Text=""></asp:Label> 
                                </td>
                                <td>
                                        <asp:Label ID="Label31" runat="server"  Font-Size="11px" Text="Shop ID:"></asp:Label> 
                                        <asp:Label ID="lblShopID2" runat="server"  Font-Size="11px" Text=""></asp:Label> 
                                </td>
                            </tr>
                            <tr>
                                <td>                       
                                        <asp:Label ID="Label33" runat="server"  Font-Size="11px" Text="Customer ID:"></asp:Label>
                                        <asp:Label ID="lblCustID2" runat="server"  Font-Size="11px" Text=""></asp:Label> 
                                </td>
                                <td>
                                        <asp:Label ID="Label35"  Font-Size="11px" runat="server" Text="Contact No:"></asp:Label> 
                                        <asp:Label ID="lblCustContactNo2" Font-Size="11px"  runat="server" Text=""></asp:Label> 
                                </td>
                            </tr>
                            <tr>
                                <td>                      
                                        <asp:Label ID="Label37"  Font-Size="11px" runat="server" Text="Name:"></asp:Label> 
                                        <asp:Label ID="lblCustName2"  Font-Size="11px" runat="server" Text=""></asp:Label> 
                                </td>
                                <td>
                                        <asp:Label ID="Label39" Font-Size="11px"   runat="server" Text="ServedBy:"></asp:Label> 
                                        <asp:Label ID="lblServedBy2" Font-Size="11px"   runat="server" Text=""></asp:Label> 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                       <asp:Label ID="lbltableno2" Font-Size="11px" runat="server" Text="Parcel"></asp:Label> 
             
                                </td>
                                <td>
                                        <asp:Label ID="Label24" Font-Size="11px" runat="server" Text="Token:"></asp:Label>
                                        <asp:Label ID="lbltokenno2" Font-Size="11px" runat="server" Text="-" Font-Bold="True"></asp:Label> 
                                </td>
                            </tr>
                        </table> <br />
                        
                        <asp:Label ID="Label41" Font-Size="11px"  runat="server" Text="Invoice #"></asp:Label>  
                        <asp:Label ID="lblInvoice2" Font-Size="11px"  runat="server" Text="1003"></asp:Label> 
                        <br />                   
                        <asp:DataList ID="dtlistitems58" runat="server">
                            <ItemStyle ForeColor="Black"/>
                            <ItemTemplate> 
                              <table >
                           
                            <tr> 
                                <td style="width:160px; text-align:left">   
                                <asp:Label   ID="lblCode" Font-Size="10px" runat="server" Text='<%# Bind("Code") %>'  ></asp:Label><br />
                                <asp:Label   ID="lblItems" Font-Size="11px" runat="server" Text='<%# Bind("Items") %>' ></asp:Label>   <br />
                                <asp:Label   ID="Label18" Font-Size="12px" runat="server" Text='<%# Bind("Qty") %>' ></asp:Label> - 
                                  <asp:Label   ID="Label19" Font-Size="11px" runat="server" Text='<%# Bind("Disc") %>' ></asp:Label>% - 
                                  <asp:Label   ID="Label20" Font-Size="11px" runat="server" Text='<%# Bind("Price") %>' ></asp:Label>
                                </td>                                

                                <td style="width:50px; text-align:right">                                
                                  <asp:Label   ID="lbltotal2"  Font-Size="12px"  Font-Bold="true" runat="server" Text='<%# Bind("Total") %>' ></asp:Label>
                                </td>    
                               </tr>  
                               <div style="border-top:1px dotted #000; padding-top:10px; border-top-color: #CCCCCC;"></div>                           
                            </table>
                            </ItemTemplate> 
                        </asp:DataList>
                    </td>
                </tr>

                <tr>
                    <td>
                        <table class="papersize58">                           
                            <tr>    
                                <td > <asp:Label ID="Label43"  Font-Size="11px" runat="server" Text="Total Sales Qty:"></asp:Label> <br /></td>
                                <td  style="text-align: right;" class="text-right">  
                                <asp:Label ID="lblTotalQty2" Font-Bold="true"  Font-Size="11px" runat="server" Text="0"></asp:Label> <br /> </td>                                                            
                             </tr>
                            <tr>    
                                <td> <asp:Label ID="Label45"  Font-Size="11px" runat="server" Text="Sub Total:"></asp:Label>  </td>
                                <td  class="text-right" style="text-align: right">  
                                <asp:Label ID="lblsubTotal2" Font-Bold="true"  Font-Size="11px" runat="server" Text="0"></asp:Label>   </td>                                                            
                            </tr>

                           <tr>
                                 <td>
                                 <asp:Label   Font-Size="11px" ID="Label26" runat="server" Text="Discount"></asp:Label> 
                                 </td>
                                 <td style="text-align: right;" class="text-right">
                                 <asp:Label Font-Size="11px"  ID="lbldiscountamt2" runat="server" Text="0"></asp:Label>
                                
                                 </td>
                            </tr>

                            <tr>
                                 <td style="border-bottom-style: solid; border-bottom-width: thin;" >
                                 <asp:Label   Font-Size="11px" ID="Label47" runat="server" Text="Vat"></asp:Label>
                                  <asp:Label Font-Size="9px"  ID="lblvatRate2" runat="server" Text="0"></asp:Label>
                                 </td>
                                 <td style="border-bottom-style: solid; border-bottom-width: thin;text-align: right;" class="text-right">
                                 <asp:Label Font-Size="11px"  ID="lblvat2" runat="server" Text="0"></asp:Label>
                                
                                 </td>
                            </tr>
                            <tr> 
                                <td ><asp:Label ID="Label50" Font-Bold="true" Font-Size="12px" runat="server" Text="Net Amount:"></asp:Label>  <br /> <br />     </td>
                                <td style="text-align: right;" class="text-right"> 
                                <asp:Label ID="lbltotalpay2"  Font-Size="12px"  Font-Bold="true" runat="server" Text="0"></asp:Label>   <br /> <br />   </td>
                            </tr>
                            <tr>    
                                <td><asp:Label ID="Label52"  Font-Size="11px" runat="server" Text="Pay Type:"></asp:Label>  <br />   </td>
                                <td class="text-right" style="text-align: right">
                                <asp:Label ID="lblpaidby2" Font-Size="11px" Font-Bold="true" runat="server" Text="0"></asp:Label> <br />    </td>                                                            
                            </tr>

                            <tr>
                                <td><asp:Label ID="Label54"  Font-Size="11px" runat="server" Text="Paid Amount"></asp:Label> </td>
                                <td class="text-right" style="text-align: right">
                                <asp:Label ID="lblPaidAmt2" Font-Size="11px" runat="server" Text="0"></asp:Label></td>                               
                            </tr>

                            <tr>
                                <td><asp:Label ID="Label56"  Font-Size="11px" runat="server" Text="Changed Amount:"></asp:Label> <br /> <br /></td>
                                <td class="text-right" style="text-align: right">
                                <asp:Label ID="lblChange2" Font-Size="11px" runat="server" Text="0"></asp:Label> <br /> <br /></td>                               
                            </tr>

                             <tr>
                                <td style="border-bottom-style: solid; border-bottom-width: thin;">
                                <asp:Label ID="Label58"  Font-Size="11px" runat="server" Text="Due Amount:"></asp:Label> </td>
                               <td style="border-bottom-style: solid; border-bottom-width: thin;text-align: right">
                                <asp:Label ID="lblDue2" Font-Size="11px" runat="server" Text="0"></asp:Label> </td>                               
                                <div style="border-top:1px solid #000; padding-top:10px;"></div>
                            </tr>
                        </table>
                       
                     <span style="text-align:center"> 
                             <center><asp:Label  ID="lblFooterMessage2"  Font-Size="12px" runat="server" Text="-------------------"></asp:Label><br />  </center>
                        </span>                 
                        
                  </td>
                </tr>

            </table>
          
     </div>
 </div> 


    
<%----------------------------------  Ticket  Size: 58mm ------------ 218 px-----------------------------%>

 <div class="col-lg-2 col-lg-offset-1">
        <div  style="text-align:left"> 
            <input type="button" class="btn btn-success btn-xs" value="Print"  onclick="javascript: printDiv('wrapper58TK')" /> <br /><br />
 58mm or  2.28inch (width)
        </div>
          <hr />

            <div  id="wrapper58TK" class="papersize58" style="text-align:left">
                 <table>                           
                    <tr> 
                        <td style="width:200px; text-align:left">  
                            <asp:Label ID="Label30" runat="server" Text="Ticket" Font-Size="17" Font-Bold="True"></asp:Label><br />
                            <asp:Label ID="Label28" runat="server" Text="Date:"></asp:Label>
                            <asp:Label ID="lbldateTK" runat="server" Text="Date:"></asp:Label><br />
                            <asp:Label ID="Label32" runat="server" Text="Table:"></asp:Label>
                            <asp:Label ID="lbltablenoTK" runat="server" Text="Table:"></asp:Label><br />
                            <asp:Label ID="Label36" runat="server" Text="Invoice:"></asp:Label>
                            <asp:Label ID="lblinvoiceTK" runat="server" Text="Invoice:"></asp:Label><br />
                            <asp:Label ID="Label40" runat="server" Text="Token No:"></asp:Label>
                            <asp:Label ID="lbltokenoTK" runat="server" Text="Tokenno:"></asp:Label><br /><br />
                        </td>                         
                    </tr>                         
                </table>

                <asp:DataList ID="dtlistticket" runat="server">
                    <ItemStyle ForeColor="Black"/>
                    <ItemTemplate> 
                        <table>                           
                            <tr> 
                                <td style="width:200px; text-align:left">  
                                    <asp:Label   ID="Label18" Font-Size="12px" runat="server" Text='<%# Bind("Qty") %>' ></asp:Label> -    
                                    <asp:Label   ID="lblItems" Font-Size="12px" runat="server" Text='<%# Bind("Items") %>' ></asp:Label>                      
                                    <br /><asp:Label   ID="Label19" Font-Size="10px" runat="server" Text='<%# Bind("options") %>' ></asp:Label> 
                                </td>  
                            </tr>  
                            <div style="border-top:1px dotted #000; padding-top:10px; border-top-color: #CCCCCC;"></div>                           
                        </table>
                    </ItemTemplate> 
                </asp:DataList> <br /> 
                <asp:Label ID="Label34" runat="server" Text="Customer Copy" ForeColor="#999999"></asp:Label> <br />
                <asp:Label ID="lblcompanytitleTK" runat="server" Text="--" Font-Size="7" ForeColor="Gray"></asp:Label> <br /><br />
                 
                <div style="width:200px; text-align:left; border-top:1px dotted #000; padding-top:10px; border-top-color: #CCCCCC;"></div>    

       <%--   ------------------------------------      Waiter Copy -----------------------------------------------%>
                    <table style="width:200px; text-align:left">                       
                        <tr> 
                            <td >  
                                <asp:Label ID="Label38" runat="server" Text="Ticket" Font-Size="17" Font-Bold="True"></asp:Label><br />
                                <asp:Label ID="Label42" runat="server" Text="Date:"></asp:Label>
                                <asp:Label ID="lbldateTKW" runat="server" Text="Date:"></asp:Label><br />
                                <asp:Label ID="Label46" runat="server" Text="Table:"></asp:Label>
                                <asp:Label ID="lbltablenoTKW" runat="server" Text="Table:"></asp:Label><br />
                                <asp:Label ID="Label49" runat="server" Text="Invoice:"></asp:Label>
                                <asp:Label ID="lblinvoiceTKW" runat="server" Text="Invoice:"></asp:Label><br />
                                <asp:Label ID="Label53" runat="server" Text="Token No:"></asp:Label>
                                <asp:Label ID="lbltokenoTKW" runat="server" Text="Tokenno:"></asp:Label><br /><br />
                            </td>                         
                        </tr>                         
                    </table>

                
                    <asp:DataList ID="dtlistwaitercopy" runat="server">
                        <ItemStyle ForeColor="Black"/>
                        <ItemTemplate> 
                            <table>                           
                                <tr> 
                                    <td style="width:200px; text-align:left">  
                                        <asp:Label   ID="Label18" Font-Size="12px" runat="server" Text='<%# Bind("Qty") %>' ></asp:Label> -    
                                        <asp:Label   ID="lblItems" Font-Size="12px" runat="server" Text='<%# Bind("Items") %>' ></asp:Label>                      
                                       <br /> <asp:Label   ID="Label19" Font-Size="10px" runat="server" Text='<%# Bind("options") %>' ></asp:Label> 
                                    </td>  
                                </tr>  
                                <div style="border-top:1px dotted #000; padding-top:10px; border-top-color: #CCCCCC;"></div>                           
                            </table>
                        </ItemTemplate> 
                    </asp:DataList> <br /> 
                    <asp:Label ID="Label57" runat="server" Text="Waiter Copy" ForeColor="#999999"></asp:Label> <br /><br />

            </div>
</div>
              
</asp:Content>

