<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Resources.aspx.cs" Inherits="DOBL.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <h3>What is this tool?</h3>
    <p>This site is designed to allow project managers to adjust their expected future spending for their projects.
        <br />
        If you hit submit without making any changes you will accept the default curve.
    </p>
    <h3>Tableau Dashboard</h3>
    <p><a target="_blank" href="https://devdoaenterprisebi.wi.gov">Here is a link to the current management dashboard.</a></p>
    <%--<p>If you don't have tableau reader installed <a href="https://www.tableau.com/products/reader/download" target="_blank">here is a link to the most recent version.</a></p>--%>
</asp:Content>
