<%@ Page Title="" Language="C#" MasterPageFile="../MasterPage/Bootstrap.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../BootStrapFiles/jsapi" type="text/javascript"></script>     
    <script type="text/javascript">
        google.load('visualization', '1', { packages: ['corechart'] });
        // google.load('visualization', '1.1', { 'packages': ['bar'] });
    </script>  
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Default.aspx/GetChartData',
                data: '{}',
                success:
                function (response) {
                    drawchart(response.d);
                },

                error: function () {
                    alert("Error loading data!");
                }
            });
        })
        function drawchart(dataValues) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Year');
            data.addColumn('number', 'Total amount');
            //   data.addColumn('string', 'Total amount2');

            for (var i = 0; i < dataValues.length; i++) {
                // data.addRows([dataValues[i].Year, dataValues[i].Total], dataValues[i].Year);
                data.addRow([dataValues[i].Year, dataValues[i].Total]);
            }

            //   new google.visualization.PieChart
            //  new google.visualization.BarChart(  //LineChart  //ColumnChart  //ComboChart
            new google.visualization.PieChart(document.getElementById('myChartDivPie')).
            draw(data, { title: "Sales Pie chart last 8 days " });

            new google.visualization.ColumnChart(document.getElementById('myChartDiv')).
            draw(data, { title: "Sales Column chart last 8 days " });
       
        }  
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
   

    <br />
            <div class="col-lg-4">
                    <div class="panel panel-primary" style="height:410px"> 
                    <span  style="font-size:70px" class="glyphicon glyphicon-shopping-cart"></span> 
                    <h1>Point of sale</h1>
                <%--    <asp:Button ID="btnAddItems" class="btn btn-info btn-lg" runat="server" Text="Purchase" PostBackUrl="~/uploadFiles/" />--%>
       
                        <asp:Button ID="btnStartSales" class="btn btn-success btn-lg" runat="server" Text="Start Sales" PostBackUrl="~/Sales/SalesRegister.aspx" />
                    <p>...</p>
                    Contact <br />
                    citkar@live.com
                    <br />

                     <a href="../Report/ChartReport.aspx" title="Chart Report" style="font-size:44px"><span class="glyphicon glyphicon-stats"> </span></a>
             <br /> <br /> 
             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://codecanyon.net/downloads" >Please Don't Forget to Rate Us</asp:HyperLink>
   
       
                </div>
          </div>

        <div class="col-lg-4">
             <div class="panel panel-primary"> 
                        <div class="well well-sm"  >             
                                Top Sold Items by Qty  [last 30 days]
                        </div>   
                  <div class="panel-body"> 
                      <asp:Panel ID="Panel2" Height="320px"   ScrollBars="Vertical" runat="server">              
                          <asp:GridView ID="grdviewTopSoldItems"   class="table table-striped table-hover" Font-Size="11px"  runat="server">
                          </asp:GridView>
                      </asp:Panel>
                  </div>
                </div>
        </div>

      <div class="col-lg-4">       
       <div class="panel panel-primary"> 
                <div class="well well-sm"  >             
                        Task List<br />
                        <asp:Label ID="Label1" runat="server" Font-Size="11px" Text="Task list provide all informations, Notices from system admin or Manager"></asp:Label>
                </div>   
          <div class="panel-body"> 
              <asp:Panel ID="Panel1" Height="300px"   ScrollBars="Vertical" runat="server">              
                  <asp:GridView ID="grdViewTasklist"   class="table table-striped table-hover" Font-Size="11px"  runat="server">
                  </asp:GridView>
              </asp:Panel>
          </div>
        </div>
    </div>
<%--</div>--%>

    
 <div class="col-lg-5">
        <div id="myChartDivPie" style="width: 700px; height: 450px;">  
        </div>   
</div>  
 <div class="col-lg-5">       
  <div id="myChartDiv" style="width: 650px; height: 450px;">  
        </div> 
 </div>

    
</asp:Content>

