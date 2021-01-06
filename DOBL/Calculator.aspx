<%@ Page Title="Calculator" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Calculator.aspx.cs" Inherits="DOBL.Calculator" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        html, body {
            margin: 20px;
            padding: 0;
            height: 100%;
        }

        body {
            display: flex;
            color: #333;
            justify-content: center;
        }

        table {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        td, th {
            white-space: nowrap;
            border: 1px solid #ddd;
            padding: 5px;
        }

            td ~ input {
                padding: 0px;
            }

        th {
            background-color: #eee;
            font-weight: normal;
            text-align: center;
        }

        .center-table {
            margin: auto;
            width: 50%;
        }

        .textbox {
            width: 100px;
            text-align: right;
        }

        .textbox-large {
            width: 210px
        }

        .textbox-huge {
            width: 433px;
            max-width: 500px;
        }

        .center-text {
            text-align: center;
        }

        .money {
            text-align: right;
        }
    </style>

    <h2>DDC Estimate</h2>
    <br />
    <asp:Label runat="server">Work Type:</asp:Label>
    <asp:DropDownList ID="WorkTypeDropDownList" runat="server" ClientIDMode="Static">
        <asp:ListItem Value="0">---</asp:ListItem>
        <asp:ListItem Value="1">Roadway Maintenance</asp:ListItem>
        <asp:ListItem Value="2">Resurfacing</asp:ListItem>
        <asp:ListItem Value="3">Pavement Replacement</asp:ListItem>
        <asp:ListItem Value="4">Reconditioning</asp:ListItem>
        <asp:ListItem Value="5">Reconstruction</asp:ListItem>
        <asp:ListItem Value="6">Expansion</asp:ListItem>
        <asp:ListItem Value="7">Bridge Rehabilitation</asp:ListItem>
        <asp:ListItem Value="8">Bridge Replacement</asp:ListItem>
        <asp:ListItem Value="9">Miscellaneous</asp:ListItem>
    </asp:DropDownList>
    <%--    <asp:Label runat="server">Let Range:</asp:Label>
    <asp:DropDownList ID="LetRangeDropDownList" runat="server" ClientIDMode="Static">
        <asp:ListItem Value="0">---</asp:ListItem>
        <asp:ListItem Value="1">$0-$250,000</asp:ListItem>
        <asp:ListItem Value="2">$250,001-$500,000</asp:ListItem>
        <asp:ListItem Value="3">$500,001-$1,000,000</asp:ListItem>
        <asp:ListItem Value="4">$1,000,001-$2,000,000</asp:ListItem>
        <asp:ListItem Value="5">$2,000,001-$4,000,000</asp:ListItem>
        <asp:ListItem Value="6">$4,000,001-$8,000,000</asp:ListItem>
        <asp:ListItem Value="7">$8,000,001 +</asp:ListItem>
    </asp:DropDownList>--%>
    <asp:Label runat="server">Estimated LET:</asp:Label>
    <asp:TextBox ID="EstLETTextBox" runat="server" ClientIDMode="Static"></asp:TextBox>
    <asp:RadioButton ID="RadioButton1" runat="server" GroupName="lead" Text="Consultant Lead" />
    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="lead" Text="In-House Lead" ClientIDMode="Static" />
    <asp:Button ID="Button1" runat="server" Text="Calculate" OnClientClick="displayResults(); return false;" type="button" />
    <br />
    <br />
    <asp:Label runat="server" ClientIDMode="Static" ID="results"></asp:Label>
    <br />
    <h2>Delivery Budget and EDCI Calculator</h2>
    <br />

    <asp:Table runat="server" ID="EDCITable" CssClass="center-table">
        <asp:TableHeaderRow>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell ColumnSpan="2" CssClass="center-text">Design</asp:TableCell>
            <asp:TableCell ColumnSpan="2" CssClass="center-text">Construction</asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableRow>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell CssClass="center-text">WisDOT</asp:TableCell>
            <asp:TableCell CssClass="center-text">Consultant</asp:TableCell>
            <asp:TableCell CssClass="center-text">WisDOT</asp:TableCell>
            <asp:TableCell CssClass="center-text">Consultant</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableHeaderCell ColumnSpan="5">Direct Project Charges</asp:TableHeaderCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Consultant Payments (with overhead)</asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignConsultPayments" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstConsultPayments" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>WisDOT Salary (includes Time Off w/ Pay)</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignWisSalary" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstWisSalary" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Fringe</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignWisFringe" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstWisFringe" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Travel</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignWisTravel" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstWisTravel" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Fleet</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignWisFleet" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstWisFleet" ClientIDMode="Static" CssClass="textbox money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Subtotal WisDOT direct charges</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignSubtotal" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignSubtotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstSubtotal" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstSubtotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Total direct charges</asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="TotalDirectCharges" ClientIDMode="Static" Enabled="false" CssClass="textbox-large money"></asp:TextBox>
                <asp:HiddenField runat="server" ID="TotalDirectChargesHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableHeaderCell ColumnSpan="5">EDCI Overhead</asp:TableHeaderCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>WisDOT overhead (0.5711 on direct charges)</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignWisOverhead" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignWisOverheadHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstWisOverhead" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstWisOverheadHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Subtotal project charges with overhead</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignWisSubtotal" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignWisSubtotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="DesignConsultSubtotal" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignConsultSubtotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstWisSubtotal" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstWisSubtotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox runat="server" ID="ConstConsultSubtotal" ClientIDMode="Static" CssClass="textbox money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstConsultSubtotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Total project charges with overhead</asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="DesignTotal" ClientIDMode="Static" CssClass="textbox-large money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignTotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="ConstTotal" ClientIDMode="Static" CssClass="textbox-large money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstTotalHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Program support rate (0.2225)</asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="DesignSupportRate" ClientIDMode="Static" CssClass="textbox-large money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignSupportRateHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="ConstSupportRate" ClientIDMode="Static" CssClass="textbox-large money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstSupportRateHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Total Delivery Cost w/ overhead (EDCI Delivery)</asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="DesignDeliveryCost" ClientIDMode="Static" CssClass="textbox-large money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DesignDeliveryCostHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="ConstDeliveryCost" ClientIDMode="Static" CssClass="textbox-large money" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="ConstDeliveryCostHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableHeaderCell ColumnSpan="5">EDCI Calculator</asp:TableHeaderCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Estimated Total LET Cost</asp:TableCell>
            <asp:TableCell ColumnSpan="4">
                <asp:TextBox runat="server" ID="TotalLETCost" ClientIDMode="Static" CssClass="textbox-huge money" onblur="handleblur(this)" onfocus="handlefocus(this)"></asp:TextBox>
                <asp:HiddenField runat="server" ID="TotalLETCostHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Estimated DDCI</asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="DDCI" ClientIDMode="Static" CssClass="textbox-large" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="DDCIHidden" ClientIDMode="Static" />
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Estimated CDCI</asp:TableCell>
            <asp:TableCell ColumnSpan="2"></asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox runat="server" ID="CDCI" ClientIDMode="Static" CssClass="textbox-large" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="CDCIHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>Total EDCI</asp:TableCell>
            <asp:TableCell ColumnSpan="4">
                <asp:TextBox runat="server" ID="EDCI" ClientIDMode="Static" CssClass="textbox-huge" Enabled="false"></asp:TextBox>
                <asp:HiddenField runat="server" ID="EDCIHidden" ClientIDMode="Static" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>

    <script type="text/javascript">        
        $(document).ready(function () {
            calculate();
        });
        function handleblur(textbox) {
            if (textbox.value != "") { //if there is no dollar sign in the textbox and it has content, add one to the beginning
                textbox.value = "$" + textbox.value.replace("$", "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            calculate();
        }
        function handlefocus(textbox) {
            if (textbox.value != "") {
                textbox.value = smartParse(textbox.value.replace("$", ""));
            }
        }
        function calculate() {
            //get textboxes and hidden fields
            //direct project charges
            var DesignConsultPayments = document.getElementById('DesignConsultPayments');
            var ConstConsultPayments = document.getElementById('ConstConsultPayments');
            var DesignWisSalary = document.getElementById('DesignWisSalary');
            var ConstWisSalary = document.getElementById('ConstWisSalary');
            var DesignWisFringe = document.getElementById('DesignWisFringe');
            var ConstWisFringe = document.getElementById('ConstWisFringe');
            var DesignWisTravel = document.getElementById('DesignWisTravel');
            var ConstWisTravel = document.getElementById('ConstWisTravel');
            var DesignWisFleet = document.getElementById('DesignWisFleet');
            var ConstWisFleet = document.getElementById('ConstWisFleet');
            var DesignSubtotal = document.getElementById('DesignSubtotal');
            var ConstSubtotal = document.getElementById('ConstSubtotal');
            var TotalDirectCharges = document.getElementById('TotalDirectCharges');
            var DesignSubtotalHidden = document.getElementById('DesignSubtotalHidden');
            var ConstSubtotalHidden = document.getElementById('ConstSubtotalHidden');
            var TotalDirectChargesHidden = document.getElementById('TotalDirectChargesHidden');
            //EDCI Overhead
            var DesignWisOverhead = document.getElementById('DesignWisOverhead');
            var ConstWisOverhead = document.getElementById('ConstWisOverhead');
            var DesignWisSubtotal = document.getElementById('DesignWisSubtotal');
            var DesignConsultSubtotal = document.getElementById('DesignConsultSubtotal');
            var ConstWisSubtotal = document.getElementById('ConstWisSubtotal');
            var ConstConsultSubtotal = document.getElementById('ConstConsultSubtotal');
            var DesignTotal = document.getElementById('DesignTotal');
            var ConstTotal = document.getElementById('ConstTotal');
            var DesignSupportRate = document.getElementById('DesignSupportRate');
            var ConstSupportRate = document.getElementById('ConstSupportRate');
            var DesignDeliveryCost = document.getElementById('DesignDeliveryCost');
            var ConstDeliveryCost = document.getElementById('ConstDeliveryCost');
            var DesignWisOverheadHidden = document.getElementById('DesignWisOverheadHidden');
            var ConstWisOverheadHidden = document.getElementById('ConstWisOverheadHidden');
            var DesignWisSubtotalHidden = document.getElementById('DesignWisSubtotalHidden');
            var DesignConsultSubtotalHidden = document.getElementById('DesignConsultSubtotalHidden');
            var ConstWisSubtotalHidden = document.getElementById('ConstWisSubtotalHidden');
            var ConstConsultSubtotalHidden = document.getElementById('ConstConsultSubtotalHidden');
            var DesignTotalHidden = document.getElementById('DesignTotalHidden');
            var ConstTotalHidden = document.getElementById('ConstTotalHidden');
            var DesignSupportRateHidden = document.getElementById('DesignSupportRateHidden');
            var ConstSupportRateHidden = document.getElementById('ConstSupportRateHidden');
            var DesignDeliveryCostHidden = document.getElementById('DesignDeliveryCostHidden');
            var ConstDeliveryCostHidden = document.getElementById('ConstDeliveryCostHidden');
            //EDCI Calc
            var TotalLETCost = document.getElementById('TotalLETCost');
            var DDCI = document.getElementById('DDCI');
            var CDCI = document.getElementById('CDCI');
            var EDCI = document.getElementById('EDCI');
            var TotalLETCostHidden = document.getElementById('TotalLETCostHidden');
            var DDCIHidden = document.getElementById('DDCIHidden');
            var CDCIHidden = document.getElementById('CDCIHidden');
            var EDCIHidden = document.getElementById('EDCIHidden');
            //direct project charges
            //calc design subtotal
            DesignSubtotal.value = "$" + roundDecimals(smartParse(DesignWisSalary.value.replace("$", "")) + smartParse(DesignWisFringe.value.replace("$", "")) + smartParse(DesignWisTravel.value.replace("$", "")) + smartParse(DesignWisFleet.value.replace("$", "")), 2);
            //calc const subtotal
            ConstSubtotal.value = "$" + roundDecimals(smartParse(ConstWisSalary.value.replace("$", "")) + smartParse(ConstWisFringe.value.replace("$", "")) + smartParse(ConstWisTravel.value.replace("$", "")) + smartParse(ConstWisFleet.value.replace("$", "")), 2);
            //calc total direct charges
            TotalDirectCharges.value = "$" + roundDecimals(smartParse(DesignConsultPayments.value.replace("$", "")) + smartParse(DesignSubtotal.value.replace("$", "")), 2);
            //edci overhead
            //calc design overhead
            //DesignWisOverhead.value = "$" + roundDecimals(smartParse(DesignSubtotal.value.replace("$", "")) * 0.5711, 2);
            DesignWisOverhead.value = "$" + roundDecimals(smartParse(DesignSubtotal.value.replace("$", "")) * 0.5711,2);
            //calc const overhead
            ConstWisOverhead.value = "$" + roundDecimals(smartParse(ConstSubtotal.value.replace("$", "")) * 0.5711, 2);
            //calc design subtotal with overhead
            DesignWisSubtotal.value = "$" + roundDecimals(smartParse(DesignSubtotal.value.replace("$", "")) + smartParse(DesignWisOverhead.value.replace("$", "")), 2);
            //calc const subtotal with overhead
            ConstWisSubtotal.value = "$" + roundDecimals(smartParse(ConstSubtotal.value.replace("$", "")) + smartParse(ConstWisOverhead.value.replace("$", "")), 2);
            //calc design consult subtotal
            DesignConsultSubtotal.value = "$" + roundDecimals(smartParse(DesignConsultPayments.value.replace("$", "")), 2);
            //calc const consult subtotal
            ConstConsultSubtotal.value = "$" + roundDecimals(smartParse(ConstConsultPayments.value.replace("$", "")), 2);
            //calc design total with overhead
            DesignTotal.value = "$" + roundDecimals(smartParse(DesignWisSubtotal.value.replace("$", "")) + smartParse(DesignConsultSubtotal.value.replace("$", "")), 2);

            //calc const total with overhead
            ConstTotal.value = "$" + roundDecimals(smartParse(ConstWisSubtotal.value.replace("$", "")) + smartParse(ConstConsultSubtotal.value.replace("$", "")), 2);
            //calc design support rate
            DesignSupportRate.value = "$" + roundDecimals(smartParse(DesignTotal.value.replace("$", "")) * 0.2225, 2);
            //calc const support rate
            ConstSupportRate.value = "$" + roundDecimals(smartParse(ConstTotal.value.replace("$", "")) * 0.2225, 2);
            //calc design delivery cost
            DesignDeliveryCost.value = "$" + roundDecimals(smartParse(DesignTotal.value.replace("$", "")) + smartParse(DesignSupportRate.value.replace("$", "")), 2);
            //calc const delivery cost
            ConstDeliveryCost.value = "$" + roundDecimals(smartParse(ConstTotal.value.replace("$", "")) + smartParse(ConstSupportRate.value.replace("$", "")), 2);
            //edci calculator
            //calc est DDCI
            if (DesignDeliveryCost.value.replace("$", "") != 0 && TotalLETCost.value.replace("$", "") != "") {
                DDCI.value = (smartParse(DesignDeliveryCost.value.replace("$", "")) / smartParse(TotalLETCost.value.replace("$", "")) * 100).toFixed(1) + "%";
            } else {
                DDCI.value = "-";
            }
            //calc est CDCI
            if (ConstDeliveryCost.value.replace("$", "") != 0 && TotalLETCost.value.replace("$", "") != "") {
                CDCI.value = (smartParse(ConstDeliveryCost.value.replace("$", "")) / smartParse(TotalLETCost.value.replace("$", "")) * 100).toFixed(1) + "%";
            } else {
                CDCI.value = "-";
            }
            //calc total EDCI
            EDCI.value = smartParse(DDCI.value.replace("$", "")) + smartParse(CDCI.value.replace("$", "")) ? (smartParse(DDCI.value.replace("$", "")) + smartParse(CDCI.value.replace("$", ""))) + "%" : "-";
        }
        function smartParse(number) { //parses float but returns 0 in place of NaN
            parsed = parseFloat(number.replace(/,/g, "")) || 0;
            return parsed;
        }
        function roundDecimals(number, decCount) { //adds trailing zeros if necessary
            var split = number.toString().split(".");
            if (split.length > 1) //if there are numbers beyond the decimal, round the numbers
            {
                number = number.toFixed(decCount);
            }
            //return number;
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    </script>
    <script type="text/javascript">
        function toNumber(dirtyNumber) {  //returns only numeric characters from string
            var cleanNumber = parseInt(dirtyNumber.replace(/\D/g, ''));
            return cleanNumber;
        }
        function getWorkType() { //returns selected work type
            return $("#WorkTypeDropDownList").val();
        }
        function getLetRange() { //returns let range
            var estLet = getLET();
            if (estLet > 0 && estLet <= 250000) {
                return 1;
            } else if (estLet > 250000 && estLet <= 500000) {
                return 2;
            } else if (estLet > 500000 && estLet <= 1000000) {
                return 3;
            } else if (estLet > 1000000 && estLet <= 2000000) {
                return 4;
            } else if (estLet > 2000000 && estLet <= 4000000) {
                return 5;
            } else if (estLet > 4000000 && estLet <= 8000000) {
                return 6;
            } else if (estLet > 8000000) {
                return 7;
            } else {
                return 0;
            }

        }
        function getLET() { // returns the inputed est design buget
            return toNumber($("#EstLETTextBox").val());
        }
        //function getDDCDifference(estBudget, DDC) { // returns string with difference between estBudget and DDC
        //    var diff = 0;
        //    if (estBudget > DDC) {
        //        diff = estBudget / DDC;
        //        diff = diff - 1;
        //        diff = diff * 100;
        //        diff = diff.toFixed(2);
        //        return diff + "% over";
        //    } else if (estBudget < DDC) {
        //        diff = estBudget / DDC;
        //        diff = 1 - diff;
        //        diff = diff * 100;
        //        diff = diff.toFixed(2);
        //        return diff + "% under";
        //    } else if (estBudget = DDC) {
        //        return "exactly matching"
        //    } else {
        //        return "error"
        //    }
        //}
        function getDDI(WorkType, LetRange) { // returns decimal of Design Deliver Index based on selected work type and let range
            var work_type = parseInt(WorkType);
            var let_range = parseInt(LetRange);
            switch (work_type) {
                case 1:
                    switch (let_range) {
                        case 1:
                            return .2;
                        case 2:
                            return .14;
                        case 3:
                            return .1;
                        case 4:
                            return .075;
                        case 5:
                            return .055;
                        case 6:
                            return .05;
                        case 7:
                            return .05;
                        default:
                            return 0;
                    }
                case 2:
                    switch (LetRange) {
                        case 1:
                            return .28;
                        case 2:
                            return .23;
                        case 3:
                            return .16;
                        case 4:
                            return .12;
                        case 5:
                            return .09;
                        case 6:
                            return .075;
                        case 7:
                            return .07;
                        default:
                            return 0;
                    }
                case 3:
                    switch (LetRange) {
                        case 1:
                            return .28;
                        case 2:
                            return .23;
                        case 3:
                            return .16;
                        case 4:
                            return .12;
                        case 5:
                            return .095;
                        case 6:
                            return .08;
                        case 7:
                            return .075;
                        default:
                            return 0;
                    }
                case 4:
                    switch (LetRange) {
                        case 1:
                            return .4;
                        case 2:
                            return .35;
                        case 3:
                            return .3;
                        case 4:
                            return .25;
                        case 5:
                            return .205;
                        case 6:
                            return .15;
                        case 7:
                            return .135;
                        default:
                            return 0;
                    }
                case 5:
                    switch (LetRange) {
                        case 1:
                            return .4;
                        case 2:
                            return .35;
                        case 3:
                            return .3;
                        case 4:
                            return .25;
                        case 5:
                            return .205;
                        case 6:
                            return .15;
                        case 7:
                            return .135;
                        default:
                            return 0;
                    }
                case 6:
                    switch (LetRange) {
                        case 1:
                            return .4;
                        case 2:
                            return .35;
                        case 3:
                            return .3;
                        case 4:
                            return .25;
                        case 5:
                            return .205;
                        case 6:
                            return .15;
                        case 7:
                            return .135;
                        default:
                            return 0;
                    }
                case 7:
                    switch (LetRange) {
                        case 1:
                            return .16;
                        case 2:
                            return .15;
                        case 3:
                            return .135;
                        case 4:
                            return .12;
                        case 5:
                            return .11;
                        case 6:
                            return .1;
                        case 7:
                            return .1;
                        default:
                            return 0;
                    }
                case 8:
                    switch (LetRange) {
                        case 1:
                            return .35;
                        case 2:
                            return .28;
                        case 3:
                            return .23;
                        case 4:
                            return .17;
                        case 5:
                            return .14;
                        case 6:
                            return .11;
                        case 7:
                            return .1;
                        default:
                            return 0;
                    }
                case 9:
                    switch (LetRange) {
                        case 1:
                            return .309;
                        case 2:
                            return .26;
                        case 3:
                            return .211;
                        case 4:
                            return .169;
                        case 5:
                            return .138;
                        case 6:
                            return .108;
                        case 7:
                            return .1;
                        default:
                            return 0;
                    }
                default:
                    return 0;
            }
        }
        function getDDC() {
            return (getLET() * getDDI(getWorkType(), getLetRange())).toFixed(0);
        }
        function get9OverDDC(ddc) {
            return (ddc * 1.09).toFixed(0);
        }
        function get9UnderDDC(ddc) {
            return (ddc * .91).toFixed(0);
        }
        function getResults() {
            var WorkType = getWorkType();
            var LetRange = getLetRange();
            var ddc = getDDC();
            var EstLET = getLET();
            if (WorkType == 0) {
                return "Please select a work type";
            } else if (getLET().length == 0) {
                return "Please input an estimated LET";
            } else {
                return "<table><tr><td></td><td><p>w/ Fringe, Travel, Fleet, Overhead</p></td><td><p>w/o Fringe, Travel, Fleet, Overhead</p></td></tr>"
                    + "<tr><td><p>9% under State DDC</p></td><td class='money'><p>$" + moneyForm(get9UnderDDC(ddc)) + "</p></td><td class='money'><p>$" + moneyForm(removeOverhead(get9UnderDDC(ddc), getLead())) + "</p></td></tr>"
                    + "<tr><td><p>State DDC</p></td><td class='money'><p>$" + moneyForm(ddc) + "</p></td><td class='money'><p>$" + moneyForm(removeOverhead(ddc, getLead())) + "</p></td>"
                    + "<tr><td><p>9% over State DDC</p></td><td class='money'><p>$" + moneyForm(get9OverDDC(ddc)) + "</p></td><td class='money'><p>$" + moneyForm(removeOverhead(get9OverDDC(ddc), getLead())) + "</p></td></tr></table>";
            }
        }
        function displayResults() {
            $("#results").html(getResults());
        }
        function moneyForm(myNumber) {
            return myNumber.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        function getLead() {
            if (document.getElementById('RadioButton2').checked) {
                return .9;
            } else return .1;
        }
        function removeOverhead(DDC, lead) {
            noOverhead = DDC / (0.69816975 * lead + 1.2225);
            return noOverhead.toFixed(0);
        }
    </script>
</asp:Content>
