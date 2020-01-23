<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="content-wrapper">
            <section class="content-header">
                <section class="content">
                    <div class="card box-default">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="form-group">
                                        <label>Connection String (MS SQL)</label>
                                        <asp:TextBox ID="txtConnectionString" runat="server" Text="Server=localhost;Database=PurcellLive;Trusted_Connection=True;" required placeholder="Enter Connection String" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group pull-right">
                                        <label></label>
                                        <asp:Button ID="btnConnect" Text="Connect" runat="server" CssClass="btn btn-facebook mt-4" OnClick="btnConnect_Click" />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Select Table</label>
                                        <asp:DropDownList runat="server" ID="drpTables" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-10">
                                    <div class="form-group pull-right">
                                        <label>Select Lead Excel </label>
                                        <asp:FileUpload ID="flUpload" CssClass="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group pull-right">
                                        <label></label>
                                        <asp:Button ID="btnGetSheets" Text="Get Sheets" runat="server" CssClass="btn btn-facebook mt-4" OnClick="btnGetSheets_Click" />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Select Sheet</label>
                                        <asp:DropDownList runat="server" ID="drpSheets" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group pull-right">
                                        <label></label>
                                        
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group pull-right">
                                        <label></label>
                                        <asp:Button ID="btnUploadLeads" Text="Load Excel" runat="server" CssClass="btn btn-facebook mt-4" OnClick="btnLoad_Click" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group pull-right">
                                        <label></label>
                                        <asp:Button ID="btnImport" Text="Import Excel Data" runat="server" CssClass="btn btn-danger mt-1" OnClick="btnImport_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </section>
        </div>
    </div>
    <section>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <asp:HiddenField runat="server" ID="hdnHeaderRank" />
                        <asp:GridView runat="server" CssClass="table table-responsive" ID="lstLeadsData" OnRowDataBound="lstLeadsData_RowDataBound">
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
            var selectionCounter = 0; var isZero = false;
            $('#MainContent_btnImport').click(function () {
                var cellHeaderTexts = ""; var skipCounter = 0;
                selectionCounter = 0;
                $('select[name^="ctl00$MainContent$lstLeadsData$ctl01$ct"]').each(function () {
                    if ($(this).val() == "0") { $(this).parent().attr('style', 'border-color:red'); selectionCounter++ } else { $(this).parent().attr('style', 'border-color:black'); };
                    cellHeaderTexts += this.value + ":";
                    if ($(this).val() == "1") { skipCounter++; };
                }); if (selectionCounter > 0 || skipCounter == $('select[name^="ctl00$MainContent$lstLeadsData$ctl01$ct"]').length) { isZero = false } else { isZero = true; $('#MainContent_hdnHeaderRank').val(cellHeaderTexts); }
                return isZero;
            });

            $('select[name^="ctl00$MainContent$lstLeadsData$ctl01$ct"]').change(function () {
                var selectedDrop = $(this); var selectedColumns = [];
                $('select[name^="ctl00$MainContent$lstLeadsData$ctl01$ct"]').each(function () {
                    if (this.value == "0") { $(this).parent().attr('style', 'border-color:red'); selectionCounter++ } else { $(this).parent().attr('style', 'border-color:black'); };
                    var otherDrop = $(this);
                    if (this.value != "0") {
                        if (this.value != "1") {
                            selectedColumns.push(this.value);
                        }
                    }
                });
                $("select[name^='ctl00$MainContent$lstLeadsData$ctl01$ct'] > option").each(function () {
                    if ($.inArray(this.value, selectedColumns) != -1) {
                        this.disabled = true;
                    }
                    else {
                        this.disabled = false;
                    }
                });

            });

        });
    </script>
</asp:Content>
