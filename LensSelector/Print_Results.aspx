<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Print_Results.aspx.cs" Inherits="LensSelector.Print_Results" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>HOYA Results Page</title>
    <link href="Assets/css/print_results.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table class="BackgroundTable" cellspacing="15px" width="550px">
    <tr>
        <td>
        <div id="header" class="Header">
	        <div id="logo" style="text-align: center; float: left; display: inline; width: 200px; height: 80px;">
	            <br />
		        <img src="Assets/images/HOYA_Logo.jpg" alt="HOYA Logo"/>
	        </div>
	        <div id="address" style="float: left; display: inline; text-align: left; height: 62px;">
	            <br />
		        <asp:Label ID="lblProviderTitle" runat="server" Text="ProviderTitle" CssClass="ProviderTitle"></asp:Label><br />
                <asp:Label ID="lblProviderAddressLine1" runat="server" Text="lblProviderAddress1" CssClass="ProviderInfo"></asp:Label><br />
                <asp:Label ID="lblProviderAddressLine2" runat="server" Text="lblProviderAddress2" CssClass="ProviderInfo"></asp:Label><br />
                <asp:Label ID="lblProviderPhone" runat="server" Text="lblProviderPhone" CssClass="ProviderInfo"></asp:Label>
    	    </div>
	        <br clear="left" />
        </div>
        <br />
        <div id="data">
	        <div class="Columns" style="float: left; display: inline;">
                <span class="LensTitle">PRIMARY LENS</span><br />
                <asp:Label ID="lblPrimaryTitle" runat="server" Text="lblPrimaryTitle" CssClass="LensBrandTitle"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">DESIGN:</span><br />
                <asp:Label ID="lblPrimaryDesign" runat="server" Text="lblPrimaryDesign" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">MATERIALS:</span><br />
                <asp:Label ID="lblPrimaryMaterials" runat="server" Text="lblPrimaryMaterials" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">TREATMENT:</span><br />
                <asp:Label ID="lblPrimaryTreatment" runat="server" Text="lblPrimaryTreatment" CssClass="Information"></asp:Label><br />
                <br />
	        </div>
	        <div class="Columns" style="float: left; display: inline;">
	        <asp:Panel ID="pnlComplementary" runat="server" Visible="true">
                <span class="LensTitle">COMPLEMENTARY LENS</span><br />
                <asp:Label ID="lblComplementaryTitle" runat="server" Text="lblComplementaryTitle" CssClass="LensBrandTitle"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">DESIGN:</span><br />
                <asp:Label ID="lblComplementaryDesign" runat="server" Text="lblComplementaryDesign" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">MATERIALS:</span><br />
                <asp:Label ID="lblComplementaryMaterials" runat="server" Text="lblComplementaryMaterials" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">TREATMENT:</span><br />
                <asp:Label ID="lblComplementaryTreatment" runat="server" Text="lblComplementaryTreatment" CssClass="Information"></asp:Label><br />
                <br />
                </asp:Panel>
	        </div>
	        <div class="Columns"  style="float: left; display: inline;">
                <span class="LensTitle">SPECIALITY LENS</span><br />
                <asp:Label ID="lblSpecialityTitle" runat="server" Text="lblSpecialityTitle" CssClass="LensBrandTitle"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">DESIGN:</span><br />
                <asp:Label ID="lblSpecialityDesign" runat="server" Text="lblSpecialityDesign" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">MATERIALS:</span><br />
                <asp:Label ID="lblSpecialityMaterials" runat="server" Text="lblSpecialityMaterials" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">TREATMENT:</span><br />
                <asp:Label ID="lblSpecialityTreatment" runat="server" Text="lblSpecialityTreatment" CssClass="Information"></asp:Label><br />
                <br />
                <span class="DescriptionTitle">PREFERRED TINTS:</span><br />
                <asp:Label ID="lblTintType" runat="server" Text="lblTintType" CssClass="Information"></asp:Label>&nbsp;&nbsp;&nbsp&nbsp;
                <asp:Label ID="lblTintColor" runat="server" Text="lblTintColor" CssClass="Information"></asp:Label><br />
                <br />
	        </div>
	        <br clear="left" />
        </div>
    </td>
    </tr>
    </table>
    <table class="FooterTable" cellspacing="15px">
    <tr>
    <td>
        <div id="Footer">
            <div id="Copyright" style="float: left; display: inline;">
	            <span class="Footer">Copyright &copy; <%=DateTime.Now.Year%> HOYA Vision North America. All rights reserved</span>
            </div>
            <div id="Logo" style="text-align: right; float: right; display: inline;">
                <img alt="Powered by HOYA" src="Assets/images/HOYA_footer_logo.jpg" style="width: 74px; height: 17px;" />
            </div>
            <br clear="left" />
        </div>
    </td>
    </tr>
    </table>
    </form>
</body>
</html>
