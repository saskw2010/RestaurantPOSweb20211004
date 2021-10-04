<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Barcode_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>

    <style>
      * {
          color:#7F7F7F;
          font-family:Arial,sans-serif;
          font-size:12px;
          font-weight:normal;
      }    
      #config{
          overflow: auto;
          margin-bottom: 10px;
      }
      .config{
          float: left;
          width: 200px;
          height: 250px;
          border: 1px solid #000;
          margin-left: 2px;
      }
      .config .title{
          font-weight: bold;
          text-align: center;
      }
      .config .barcode2D,
      #miscCanvas{
        display: none;
      }
      #submit{
          clear: both;
      }
      #barcodeTarget,
      #canvasTarget{
        margin-top: 2px;
      }        
    </style>
    <%-- <link rel="stylesheet" href="../BootStrapFiles/bootstrap.css" media="screen" type="text/css">  --%>
    <script type="text/javascript" src="../Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-barcode.js"></script>   
    <script src="../Scripts/jquery-barcode.min.js" type="text/javascript"></script>
    <script src="../Scripts/PrintBarcode.js" type="text/javascript"></script>

    <script type="text/javascript">

        function generateBarcode() {
            var value = $("#barcodeValue").val();
            var btype = $("input[name=btype]:checked").val();
            var renderer = $("input[name=renderer]:checked").val();

            var quietZone = false;
            if ($("#quietzone").is(':checked') || $("#quietzone").attr('checked')) {
                quietZone = true;
            }

            var settings = {
                output: renderer,
                bgColor: $("#bgColor").val(),
                color: $("#color").val(),
                barWidth: $("#barWidth").val(),
                barHeight: $("#barHeight").val(),
                moduleSize: $("#moduleSize").val(),
                posX: $("#posX").val(),
                posY: $("#posY").val(),
                addQuietZone: $("#quietZoneSize").val()
            };
            if ($("#rectangular").is(':checked') || $("#rectangular").attr('checked')) {
                value = { code: value, rect: true };
            }
            if (renderer == 'canvas') {
                clearCanvas();
                $("#barcodeTarget").hide();
                $("#barcodeTarget2").hide();
                $("#canvasTarget").show().barcode(value, btype, settings);
            } else {
                $("#canvasTarget").hide();
                $("#barcodeTarget").html("").show().barcode(value, btype, settings);
                $("#barcodeTarget2").html("").show().barcode(value, btype, settings);
            }
        }

        function showConfig1D() {
            $('.config .barcode1D').show();
            $('.config .barcode2D').hide();
        }

        function showConfig2D() {
            $('.config .barcode1D').hide();
            $('.config .barcode2D').show();
        }

        function clearCanvas() {
            var canvas = $('#canvasTarget').get(0);
            var ctx = canvas.getContext('2d');
            ctx.lineWidth = 1;
            ctx.lineCap = 'butt';
            ctx.fillStyle = '#FFFFFF';
            ctx.strokeStyle = '#000000';
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.strokeRect(0, 0, canvas.width, canvas.height);
        }

        $(function () {
            $('input[name=btype]').click(function () {
                if ($(this).attr('id') == 'datamatrix') showConfig2D(); else showConfig1D();
            });
            $('input[name=renderer]').click(function () {
                if ($(this).attr('id') == 'canvas') $('#miscCanvas').show(); else $('#miscCanvas').hide();
            });
            generateBarcode();
        });
  
    </script>

  </head>


  <body><form  runat="server">
    <div id="generator">   
         <div class="col-lg-6">    
              <asp:TextBox ID="barcodeValue" runat="server" Text=""></asp:TextBox>    
            <input type="button" onclick="generateBarcode();" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Generate the barcode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" class="btn btn-primary btn-xs" >
         <input type="button" class="btn btn-success btn-xs" value="Print"  onclick="javascript:printBarcode('wrapper')" />
          <%--      <div id="submit">
              </div>--%>
                  <div  id="wrapper">                          
                    <asp:Label ID="lblItemName" ForeColor="Black" runat="server"  ></asp:Label> |
                    <asp:Label ID="lblRetailsPrice" ForeColor="Black" Font-Bold="true" runat="server"  ></asp:Label>
                    <div id="barcodeTarget" class="barcodeTarget"></div>
                     
                </div>
              <br />  
              <canvas id="canvasTarget" width="350" height="100"></canvas> <hr />
        </div>
    <div class="col-lg-6"> 
      <div id="config">
        <div class="config">
          <div class="title">Type</div>
          <input type="radio" name="btype" id="ean8" value="ean8" ><label for="ean8">EAN 8</label><br />
		  <input type="radio" name="btype" id="ean13" value="ean13"><label for="ean13">EAN 13</label><br />
		  <input type="radio" name="btype" id="upc" value="upc"><label for="upc">UPC</label><br />
          <input type="radio" name="btype" id="std25" value="std25" checked="checked"><label for="std25">standard 2 of 5 (industrial)</label><br />
          <input type="radio" name="btype" id="int25" value="int25"><label for="int25">interleaved 2 of 5</label><br />
          <input type="radio" name="btype" id="code11" value="code11"><label for="code11">code 11</label><br />
          <input type="radio" name="btype" id="code39" value="code39"><label for="code39">code 39</label><br />
          <input type="radio" name="btype" id="code93" value="code93"><label for="code93">code 93</label><br />
          <input type="radio" name="btype" id="code128" value="code128"><label for="code128">code 128</label><br />
          <input type="radio" name="btype" id="codabar" value="codabar"><label for="codabar">codabar</label><br />
          <input type="radio" name="btype" id="msi" value="msi"><label for="msi">MSI</label><br />
          <input type="radio" name="btype" id="datamatrix" value="datamatrix"><label for="datamatrix">Data Matrix</label> 
        </div>
            
        <div class="config">
          <div class="title">Misc</div>
            Background : <input type="text" id="bgColor" value="#FFFFFF" size="7"><br />
            "1" Bars : <input type="text" id="color" value="#000000" size="7"><br />
          <div class="barcode1D">
            bar width: <input type="text" id="barWidth" value="2" size="3"><br />
            bar height: <input type="text" id="barHeight" value="55" size="3"><br />
          </div>
          <div class="barcode2D">
            Module Size: <input type="text" id="moduleSize" value="5" size="3"><br />
            Quiet Zone Modules: <input type="text" id="quietZoneSize" value="1" size="3"><br />
            Form: <input type="checkbox" name="rectangular" id="rectangular"><label for="rectangular">Rectangular</label><br />
          </div>
          <div id="miscCanvas">
            x : <input type="text" id="posX" value="10" size="3"><br />
            y : <input type="text" id="posY" value="20" size="3"><br />
          </div>
        </div>
            
            <div class="config">
              <div class="title">Format</div>
              <input type="radio" id="css" name="renderer" value="css" checked="checked"><label for="css">CSS</label><br />
              <input type="radio" id="bmp" name="renderer" value="bmp"><label for="bmp">BMP (not usable in IE)</label><br />
              <input type="radio" id="svg" name="renderer" value="svg"><label for="svg">SVG (not usable in IE)</label><br />
              <input type="radio" id="canvas" name="renderer" value="canvas"><label for="canvas">Canvas (not usable in IE)</label>  
            </div>
      </div> 
    </div>
      EAN 13 is a World Standard  type for Bar-Code scanner      
</div>
    

   </form>
  </body>
</html>
