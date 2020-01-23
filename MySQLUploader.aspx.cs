using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Data.OleDb;
using DataBaseHelpers;

public partial class MySQLUploader : System.Web.UI.Page
{
    ExcelHelper excelHelper = new ExcelHelper();
    MySQLHelper mySqlHelper = new MySQLHelper();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnUploadLeads_Click(object sender, EventArgs e)
    {

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {

    }

    protected void btnConnect_Click(object sender, EventArgs e)
    {
        drpTables.DataSource = mySqlHelper.GetDBTables(txtConnectionString.Text);
        drpTables.DataValueField = "Table_Name";
        drpTables.DataTextField = "Table_Name";
        drpTables.DataBind();
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        Session["ColumnNames"] = mySqlHelper.GetTableColumns(txtConnectionString.Text, drpTables.SelectedItem.Text);
        string excelName = Session["fileName"].ToString();
        DataSet ds = excelHelper.GetSheetData(excelName, drpSheets.SelectedItem.Text);
        lstLeadsData.DataSource = ds.Tables["ExcelFileData"];
        lstLeadsData.DataBind();
    }

    protected void btnGetSheets_Click(object sender, EventArgs e)
    {
        string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + flUpload.FileName;
        flUpload.SaveAs(Server.MapPath("~/Uploads/" + fileName));
        var excelName = Server.MapPath("~/Uploads/" + fileName);
        String[] sheetNames = excelHelper.GetExcelSheetNames(excelName);
        drpSheets.DataSource = sheetNames;
        drpSheets.DataBind();
        Session["fileName"] = excelName;

    }

    protected void lstLeadsData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                DropDownList drpHeader = new DropDownList();
                drpHeader.DataSource = Session["ColumnNames"];
                drpHeader.DataBind();
                drpHeader.Items.Insert(0, new ListItem("Select Column Name", "0"));
                drpHeader.Items.Insert(1, new ListItem("Skip Column", "1"));
                e.Row.Cells[i].Controls.Add(drpHeader);
            }
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        string[] lstdata = hdnHeaderRank.Value.Split(':');
        List<string> lstColumnNames = (List<string>)Session["ColumnNames"];
        foreach (GridViewRow gridRow in lstLeadsData.Rows)
        {
            List<string> lstCellColumns = new List<string>();
            List<string> lstCellParameters = new List<string>();
            List<string> lstCellValues = new List<string>();
            for (int a = 0; a < lstLeadsData.HeaderRow.Cells.Count; a++)
            {
                lstCellColumns.Add(lstdata[a]);
                lstCellParameters.Add("@" + lstdata[a]);
                lstCellValues.Add(gridRow.Cells[a].Text);
            }
            string columns = string.Join(",", lstCellColumns);
            string values = string.Join(",", lstCellParameters);
            mySqlHelper.InsertData(txtConnectionString.Text, drpTables.SelectedItem.Text, columns, values, lstCellParameters, lstCellValues);
        }
    }
}