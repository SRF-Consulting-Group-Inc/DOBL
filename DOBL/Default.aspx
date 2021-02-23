<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .main {
            width: 95%;
            margin: auto;
            padding: 10px;
            background-color: white;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            border-radius: 10px;
        }

        .table-container {
            margin: auto;
        }

        .header-container {
            max-width: 1080px;
            margin: auto;
        }

        th {
            padding: 5px;
        }

        .auto-style1 {
            text-align: center;
        }

        .auto-style2 {
            text-align: left;
        }

        .sidenav {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #111;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 60px;
        }

            .sidenav a {
                padding: 8px 8px 8px 32px;
                text-decoration: none;
                font-size: 25px;
                color: #818181;
                display: block;
                transition: 0.3s;
            }

                .sidenav a:hover {
                    color: #f1f1f1;
                }

            .sidenav .closebtn {
                position: absolute;
                top: 0;
                right: 25px;
                font-size: 36px;
                margin-left: 50px;
            }

        @media screen and (max-height: 450px) {
            .sidenav {
                padding-top: 15px;
            }

                .sidenav a {
                    font-size: 18px;
                }
        }

        input {
            padding: 2px;
            margin-left: 2px;
        }

        .flex-container {
            display: flex;
        }

        .flex-child {
            flex: 1;
        }

            .flex-child:first-child {
                margin-right: 50px;
            }

        .warning-container {
            text-align: center;
        }

        .warning {
            display: inline-block;
            margin: auto;
            color: orangered;
            font-size: large;
        }

        .highcharts-tooltip-box {
            fill: lightgrey;
            fill-opacity: 0.1;
            stroke-width: 0;
        }
    </style>

    <div id="mySidenav" class="sidenav">
        <a href="javascript:void(0)" style="float: right" onclick="closeNav()">&times;</a>
        <a href="javascript:__doPostBack('','')" onclick="fillNav('7130-08-04')">Project 1</a>
        <a href="javascript:__doPostBack('','')" onclick="fillNav('9190-26-00')">Project 2</a>
        <a href="javascript:__doPostBack('','')" onclick="fillNav('1100-43-00')">Project 3</a>
    </div>

    <div class="main">
        <h1>Project Manager Spending Outlook</h1>
        <h3 style="color: orangered;">Site under development</h3>
        <br />
        <span style="font-size: 18px; cursor: pointer" onclick="openNav()">&#9776; My Projects</span>
        <asp:Label ID="Label2" runat="server" Text="Search by project number: "></asp:Label>
        <asp:TextBox ID="SearchBox" ClientIDMode="Static" runat="server" AutoPostBack="true" CssClass="short" ToolTip="Type Project number with or without dashes here and click search. Delete Project number to go back to full list"></asp:TextBox>
        <asp:Button ID="btnSearch" ClientIDMode="Static" runat="server" Text="Search" CausesValidation="false" OnClick="btnSearch_Click" />
        <br />
        <div class="warning-container">
            <asp:Label ID="Warning" CssClass="warning" runat="server" Text=""></asp:Label>
        </div>
        <asp:GridView ID="HeaderGridView" runat="server" DataSourceID="ProjHeader" CellPadding="4" Style="margin: auto">
        </asp:GridView>
        <asp:GridView ID="SubheaderGridView" runat="server" DataSourceID="SubProjHeader" CellPadding="4" Style="margin: auto" />
        <br />
        <br />
        <div>
            <div id="container" style="height: 400px"></div>
            <div id="drag"></div>
            <div id="drop"></div>
            <asp:Button ID="submit" runat="server" Text="Submit Predictions" OnClick="submit_Click" />
        </div>
        <div class="table-container">
            <div class="auto-style1">
                <div class="flex-container">
                    <div class="flex-child">
                        <asp:GridView ID="GridView1" runat="server" DataKeyNames="PredictionID" AutoGenerateColumns="false" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="25" BorderWidth="0" GridLines="None" AlternatingRowStyle-BackColor="WhiteSmoke" PagerSettings-Mode="NumericFirstLast">
                            <AlternatingRowStyle BackColor="WhiteSmoke"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="Project Number" SortExpression="ProposalNumber">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("ProjectID") %>' ID="proposalLabel"></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("ProjectID") %>' ID="proposalEditLabel"></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quarter" SortExpression="LongName">
                                    <ItemTemplate>
                                        <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap" class="auto-style2">
                                            <asp:Label runat="server" Text='<%# Bind("DisplayQuarter") %>' ID="nameLabel"></asp:Label>
                                            <asp:HiddenField runat="server" Value='<%# Bind("Quarter") %>' ID="quarterField" />
                                        </div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap" class="auto-style2">
                                            <asp:Label runat="server" Text='<%# Bind("DisplayQuarter") %>' ID="nameEditLabel"></asp:Label>
                                        </div>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Prediction" SortExpression="RevenueScore">
                                    <ItemTemplate>
                                        <asp:Label ID="DollarsLabel" runat="server" Text='<%# Bind("Spend") %>'></asp:Label>
                                        <asp:HiddenField ID="TextBox25" runat="server" Value='<%# Bind("Spend") %>'></asp:HiddenField>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="% Spend" SortExpression="PercentSpend">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TextBox26" usersubmitbehavior="false" runat="server" Text='<%# Bind("PercentSpend") %>' Width="35px" Style="text-align: right"></asp:TextBox>%
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" usersubmitbehavior="false" runat="server" Text='<%# Bind("PercentSpend") %>' Width="35px" Style="text-align: right"></asp:TextBox>%
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast"></PagerSettings>
                        </asp:GridView>
                    </div>
                    <div class="flex-child">
                        <asp:GridView ID="letgridview" runat="server" DataSourceID="letquery" BorderWidth="0" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Associated Let's">
                                    <ItemTemplate>
                                        <asp:Label ID="letid" runat="server" Text='<%# Bind("PROJ_ID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="flex-child">
                        <asp:Label runat="server" ID="ChangeManagementPlaceholder" Text="No Change Mangement Events"></asp:Label>
                        <asp:GridView ID="GridView2" runat="server">
                            <AlternatingRowStyle BackColor="WhiteSmoke"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="Change Management Event">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='No events yet' ID="ChangeManagementDate"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <br />
                <asp:Label ID="LatestUpdate" runat="server" Text=""></asp:Label>
            </div>

            <asp:SqlDataSource runat="server" ID="SqlDataSource1"
                ConnectionString='<%$ ConnectionStrings:DOBLCurveAdjustment %>'
                SelectCommand="SELECT [predictionid], [projectid], REPLACE([projectid],'-','') as [nodash], [DisplayQuarter], [quarter], [Spend], [Base], isnull([percentspend],CAST(ROUND(CAST([spendNumber] as decimal(15,2))*100/CAST([budget] as decimal(15,2)),0)as int)) as [percentspend] from (SELECT [predictionid], [projectid], [budget], Format([quarter], 'MMM yy') AS DisplayQuarter, quarter, CASE WHEN [maxspend] <= [base] THEN LEFT( Format( Isnull([spend], [base]), 'C', 'en-us'), Len( Format(Isnull([spend], [base]), 'C', 'en-us')) - 3) WHEN [maxspend] > [base] THEN LEFT(Format(Isnull([spend], [maxspend]), 'C', 'en-us'), Len( Format(Isnull([spend], [maxspend]), 'C', 'en-us')) - 3) END AS 'Spend', CASE WHEN [maxspend] <= [base] THEN Isnull([spend], [base]) WHEN [maxspend] > [base] THEN isnull([spend], [maxspend]) END AS 'spendNumber', LEFT(Format([base], 'C', 'en-us'), Len(Format( [base], 'C', 'en-us')) - 3) AS 'Base', percentspend FROM [WisDOT-DOBL].[dbo].[v_SpendPrediction] WHERE quarter > Getdate())a"
                UpdateCommand="IF EXISTS (SELECT 1 from [PMTool] where [ProjectID] = @ProjectID and [Quarter] = @Quarter) UPDATE [PMTool] SET [EditUser] = @EditUser, [EditDate] = getdate(),[Spend] = convert(int, LEFT(SUBSTRING(replace(@Spend,',',''), PATINDEX('%[0-9.-]%', replace(@Spend,',','')), 8000),PATINDEX('%[^0-9.-]%', SUBSTRING(replace(@Spend,',',''), PATINDEX('%[0-9.-]%', replace(@Spend,',','')), 8000) + 'X') -1)) WHERE [ProjectID] = @ProjectID and [Quarter] = @Quarter ELSE INSERT INTO [PMTool](EditUser, EditDate, ProjectID, Quarter, Spend) VALUES (@EditUser, getdate(), @ProjectID, @Quarter, convert(int, LEFT(SUBSTRING(replace(@Spend,',',''), PATINDEX('%[0-9.-]%', replace(@Spend,',','')), 8000),PATINDEX('%[^0-9.-]%', SUBSTRING(replace(@Spend,',',''), PATINDEX('%[0-9.-]%', replace(@Spend,',','')), 8000) + 'X') -1)))"
                FilterExpression="ProjectID like '{0}%' OR nodash like '{0}%'">
                <FilterParameters>
                    <asp:ControlParameter Name="ProjectID" ControlID="SearchBox" PropertyName="Text" ConvertEmptyStringToNull="false" />
                </FilterParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProjectID" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Quarter" Type="String" />
                    <asp:Parameter Name="Spend" Type="String"></asp:Parameter>
                    <asp:ControlParameter Name="EditUser" ControlID="CurrentUser" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="ProjHeader"
                ConnectionString='<%$ ConnectionStrings:DOBLCurveAdjustment %>'
                SelectCommand="SELECT distinct LEFT(FORMAT([budget],'C','en-us'),LEN(FORMAT([budget],'C','en-us')) -3) as [Budget],[MGR_PPROJ_PTCP_NM] as [Project Manager],[PROJ_SUPR_NM] as [Project Supervisor],FORMAT([controllingPSEDt],'MM/dd/yyyy') as [Controlling PS&E Date],FORMAT([LET_DT],'MM/dd/yyyy') as [LET Date],[region] as [Responsible Region],[worktype] as [WorkType] FROM [WisDOT-DOBL].[dbo].[v_Tableau] where [Project ID] = @ProjectID OR REPLACE([Project ID],'-','') = @ProjectID">
                <SelectParameters>
                    <asp:ControlParameter Name="ProjectID" ControlID="SearchBox" PropertyName="Text" ConvertEmptyStringToNull="true" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SubProjHeader"
                ConnectionString='<%$ ConnectionStrings:DOBLCurveAdjustment %>'
                SelectCommand="SELECT distinct PPROJ_RTNM_TXT as Route, PPROJ_FOST_TXT as Title, PPROJ_FOSL_TXT as Limit FROM [WisDOT-DOBL].[dbo].[v_Tableau] where [Project ID] = @ProjectID OR REPLACE([Project ID],'-','') = @ProjectID">
                <SelectParameters>
                    <asp:ControlParameter Name="ProjectID" ControlID="SearchBox" PropertyName="Text" ConvertEmptyStringToNull="true" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="letquery"
                ConnectionString='<%$ ConnectionStrings:DOBLCurveAdjustment %>'
                SelectCommand="SELECT [PROJ_ID] FROM [WisDOT-DOBL].[dbo].[LET_IDs] where [DES_GRP_ID] = @ProjectID OR REPLACE([DES_GRP_ID],'-','') = @ProjectID">
                <SelectParameters>
                    <asp:ControlParameter Name="ProjectID" ControlID="SearchBox" PropertyName="Text" ConvertEmptyStringToNull="true" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <asp:HiddenField ID="spentData" ClientIDMode="Static" runat="server" Value="" />
    <asp:HiddenField ID="DDCIData" ClientIDMode="Static" runat="server" Value="" />
    <asp:HiddenField ID="PredictionData" ClientIDMode="Static" runat="server" Value="" />
    <asp:HiddenField ID="Timeline" ClientIDMode="Static" runat="server" Value="" />
    <asp:HiddenField ID="ProjectBudget" ClientIDMode="Static" runat="server" Value="" />
    <asp:HiddenField ID="CurrentUser" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="PSEPosition" ClientIDMode="Static" runat="server" Value="" />
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://rawgithub.com/highcharts/draggable-points/master/draggable-points.js"></script>
    <script>
        function openNav() {
            document.getElementById("mySidenav").style.width = "250px";
            document.getElementById("main").style.marginLeft = "250px";
        }

        function closeNav() {
            document.getElementById("mySidenav").style.width = "0";
            document.getElementById("main").style.marginLeft = "0";
        }
        function fillNav(project) {
            document.getElementById("SearchBox").value = project;
            document.getElementById("mySidenav").style.width = "0";
            document.getElementById("main").style.marginLeft = "0";
            document.getElementById("btnSearch").click();
        }
        function getMax() {
            return parseInt($('#ProjectBudget').val(), 10);
        }

        function getMin() {
            var spentData = getGraphData($('#spentData'));
            return spentData[spentData.length - 1];
        }

        function getGraphData(dataset) {
            var res = dataset.val().split(",");
            for (var i = 0; i < res.length; i++) { res[i] = +res[i]; }
            return res;
        }

        function getCurrentX(dataset) {
            var res = dataset.val().split(",");
            return res.length - 1;
        }

        Number.prototype.toFixedDown = function (digits) {  //Function to truncate decimal places I.E. round down
            var re = new RegExp("(\\d+\\.\\d{" + digits + "})(\\d)"),
                m = this.toString().match(re);
            return m ? parseFloat(m[1]) : this.valueOf();
        };

        var chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                animation: false
            },

            title: {
                text: ''
            },

            tooltip: {
                formatter: function () {
                    var prevPoint = this.point.x == 0 ? null : this.series.data[this.point.x - 1];
                    var rV = 'The value for ' + this.x +
                        ' is $' + Highcharts.numberFormat(this.y, 0);
                    if (prevPoint) {
                        rV += '; previous quarter is $' + Highcharts.numberFormat(prevPoint.y, 0);
                    }
                    return rV;
                }
            },

            xAxis: {
                plotLines: [{
                    color: '#C8C8C8',
                    width: 2,
                    value: $('#PSEPosition').val(),
                    label: {
                        text: 'Controlling PS&E',
                        verticalAlign: 'top',
                        textAlign: 'left',
                        rotation: 0,
                        style: {
                            color: '#C8C8C8',
                            fontWeight: 'bold'
                        }
                    }
                }],
                categories: $('#Timeline').val().split(",")
            },

            yAxis: {
                allowDecimals: false
            },

            plotOptions: {
                series: {
                    point: {
                        events: {
                            drag: function (e) {
                                if (e.x == getCurrentX($('#spentData'))) {
                                    return false;
                                }
                            },
                            drop: function () {
                                $('#q2').val(this.y);
                                $('#drop').html(
                                    '<b>' + this.category + '</b> was set to <b>$' + Highcharts.numberFormat(this.y, 0) + '</b>');
                                $('#drop').css({
                                    'color': 'black'
                                });
                                relativeX = this.x - getGraphData($('#spentData')).length;
                                textbox = "#MainContent_GridView1_TextBox25_" + relativeX;
                                percent = "#MainContent_GridView1_TextBox26_" + relativeX;
                                dollars = "#MainContent_GridView1_DollarsLabel_" + relativeX;
                                $(textbox).val("$" + Highcharts.numberFormat(this.y, 0, [], ','));
                                $(dollars).html("$" + Highcharts.numberFormat(this.y, 0, [], ','));
                                $(percent).val((100 * this.y / getMax()).toFixedDown(0));
                                chart.series[1].options.color = '#2CE000';
                                var newLabel = 'Error, negative spending not allowed.';
                                $('#MainContent_submit').attr("disabled", false);
                                for (i = 1; i < this.series.data.length; i++) {
                                    if (this.series.data[i - 1].y > this.series.data[i].y) {
                                        newLabel = newLabel.replace(".", ",") + ' (' + this.series.xAxis.categories[i - 1] + ' to ' + this.series.xAxis.categories[i] + ').';
                                        $('#drop').html(newLabel);
                                        chart.series[1].options.color = '#ff0000';
                                        $('#drop').css({
                                            'color': 'red'
                                        });
                                        $('#MainContent_submit').attr("disabled", true);
                                    }
                                }
                                chart.series[1].update(chart.series[1].options);
                            }
                        }
                    },
                    stickyTracking: false
                },
                column: {
                    stacking: 'normal'
                },
                line: {
                    cursor: 'ns-resize'
                }
            },

            series: [
                {
                    data: getGraphData($('#DDCIData')),
                    name: 'Past Predictions',
                    color: '#000000',
                    dashStyle: 'longdash'
                }, {
                    data: getGraphData($('#PredictionData')),
                    draggableY: true,
                    name: 'Future Prediction',
                    dragMaxY: getMax(),
                    dragMinY: getMin(),
                    color: '#2CE000', //2CE000
                    dashStyle: 'shortdot'
                }, {
                    data: getGraphData($('#spentData')),
                    color: '#7F00FF',
                    name: 'Spent'
                }]

        });

        function toNumber(dirtyNumber) {
            var cleanNumber = parseInt(dirtyNumber.replace(/\D/g, ''));
            return cleanNumber;
        }

        function dollarFormat(number) {
            /**
             * Number.prototype.format(n, x)
             * 
             * @param integer n: length of decimal
             * @param integer x: length of sections
             */
            Number.prototype.format = function (n, x) {
                var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
                return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
            };
            return '$' + (number).format();
        }

        function checkTextboxValues() {
            status = 0;
            var newLabel = 'Error, negative spending not allowed.';
            for (i = 0; i < getQuarters() - 1; i++) {
                textbox = "MainContent_GridView1_TextBox26_" + i;
                label = "#MainContent_GridView1_nameLabel_" + i;
                nextTextbox = "MainContent_GridView1_TextBox26_" + (i + 1);
                nextLabel = "#MainContent_GridView1_nameLabel_" + (i + 1);
                var text1 = document.getElementById(textbox).value;
                var text2 = document.getElementById(nextTextbox).value;
                if (toNumber(text1) > toNumber(text2)) {
                    status = 1;
                    newLabel = newLabel.replace(".", ",") + ' (' + $(label).html() + ' to ' + $(nextLabel).html() + ').';
                    console.log($(textbox).val() + ' > ' + $(nextTextbox).val() + ' status: ' + status);
                }
            }
            if (status == 1) {
                $('#MainContent_submit').attr("disabled", true);
                $('#drop').html(newLabel);
                $('#drop').css({
                    'color': 'red'
                });
            } else {
                $('#MainContent_submit').attr("disabled", false);
                $('#drop').html('');
                $('#drop').css({
                    'color': 'black'
                });
                updatePredections();
            }
        }

        function updatePredections() {
            //console.log($('#PredictionData').val());
            var oldData = $('#PredictionData').val().split(",");
            var elements = $('#PredictionData').val().match(/[n]/g);
            var newpredictions = [];
            for (i = 0; i < elements.length; i++) {
                newpredictions.push('null');
            }
            for (i = 0; i < oldData.length; i++) {
                if (isNaN(oldData[i])) {

                } else {
                    newpredictions.push(oldData[i]);
                    break;
                }
            }
            //console.log(newpredictions);
            for (i = 0; i < getQuarters(); i++) {
                textbox = "MainContent_GridView1_TextBox26_" + i;
                hiddentext = "MainContent_GridView1_TextBox25_" + i;
                var text1 = document.getElementById(textbox).value;
                newpredictions.push(((toNumber(text1) / 100) * getMax()).toFixedDown(0));
                percent = "#MainContent_GridView1_DollarsLabel_" + i;
                $(percent).html(dollarFormat(((toNumber(text1) / 100) * getMax()).toFixedDown(0)));
                document.getElementById(hiddentext).value = ((toNumber(text1) / 100) * getMax()).toFixedDown(0);
            }
            $('#PredictionData').val(newpredictions);
            //console.log($('#PredictionData').val());
            chart.series[1].setData(getGraphData($('#PredictionData')));
        }

        function getQuarters() {
            var e = document.getElementsByTagName('input');
            var i;
            var s = 0;
            for (i = 0; i < e.length; i++) {
                if (e[i].type == "text" && e[i].name.indexOf("TextBox26") !== -1) { s++; };
            }
            return (s);
        }

        $(document).ready(function () {
            $("input").change(function () {
                checkTextboxValues();
            });
        });

        document.getElementById("MainContent_GridView1").onkeypress = function (e) {
            var key = e.charCode || e.keyCode || 0;
            if (key == 13) {
                e.preventDefault();
            }
        }
    </script>
</asp:Content>
