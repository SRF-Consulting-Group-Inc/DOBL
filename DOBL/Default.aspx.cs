using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string project = SearchBox.Text;
            if (!project.Contains("-") && project.Length >= 8) { project = project.Substring(0, 4) + '-' + project.Substring(3, 2) + '-' + project.Substring(5, 2); }
            Load_graph(project);
            Load_last_updated(project);
            CurrentUser.Value = Context.User.Identity.Name.Substring(0, Context.User.Identity.Name.IndexOf('@'));
        }

        protected void Load_last_updated(string project)
        {
            string date = "";
            string user = "";
            SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DOBLCurveAdjustment"].ConnectionString);
            string query = "SELECT top 1 FORMAT([EditDate], 'MM/dd/yyyy') as lastDate, [EditUser] FROM [WisDOT-DOBL].[dbo].[PMTool] WHERE [ProjectID] = @project";
            SqlCommand Comm1 = new SqlCommand(query, Conn);
            Conn.Open();
            Comm1.Parameters.AddWithValue("@project", project);
            SqlDataReader DR1 = Comm1.ExecuteReader();
            if (DR1.Read())
            {
                date = DR1.GetValue(0).ToString();
                user = DR1.GetValue(1).ToString();
            }
            Conn.Close();
            if (date == "")
            {
                LatestUpdate.Text = "Project has not been owned";
            }
            else
            {
                LatestUpdate.Text = "Project last updated on " + date.ToString() + " by " + user.ToString();
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            string project = SearchBox.Text;
            if (!project.Contains("-") && project.Length >= 8) { project = project.Substring(0, 4) + '-' + project.Substring(3, 2) + '-' + project.Substring(5, 2); }
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                GridView1.UpdateRow(i, false);
                Load_graph(project);
                Load_last_updated(project);
            }
        }

        protected void Load_graph(string project)
        {
            SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DOBLCurveAdjustment"].ConnectionString);
            string query = "SELECT DISTINCT ST2.[Project ID], SUBSTRING((SELECT ','+CAST(ST1.past as varchar) AS [text()] FROM [WisDOT-DOBL].[dbo].[v_ProjectFlagCurve] ST1 WHERE ST1.[Project ID] = ST2.[Project ID] ORDER BY ST1.[Project ID] FOR XML PATH ('')), 2, 1000) [DDCI], SUBSTRING((SELECT ','+CAST(ST1.Spent as varchar) AS [text()] FROM [WisDOT-DOBL].[dbo].[v_ProjectFlagCurve] ST1 WHERE ST1.[Project ID] = ST2.[Project ID] ORDER BY ST1.[Project ID] FOR XML PATH ('')), 2, 1000) [Spending], SUBSTRING((SELECT ','+CAST(ST1.prediction as varchar) AS [text()] FROM [WisDOT-DOBL].[dbo].[v_ProjectFlagCurve] ST1 WHERE ST1.[Project ID] = ST2.[Project ID] ORDER BY ST1.[Project ID] FOR XML PATH ('')), 2, 1000) [Prediction], SUBSTRING((SELECT ','+CAST(FORMAT(ST1.date,'MMM yy') as varchar)  AS [text()] FROM [WisDOT-DOBL].[dbo].[v_ProjectFlagCurve] ST1 WHERE ST1.[Project ID] = ST2.[Project ID] ORDER BY ST1.[Project ID] FOR XML PATH ('')), 2, 1000) [quarters], budget FROM [WisDOT-DOBL].[dbo].[v_ProjectFlagCurve] ST2 WHERE ST2.[Project ID] like @project";
            SqlCommand Comm1 = new SqlCommand(query, Conn);
            Conn.Open();
            Comm1.Parameters.AddWithValue("@project", project);
            SqlDataReader DR1 = Comm1.ExecuteReader();
            if (DR1.Read())
            {
                spentData.Value = DR1.GetValue(2).ToString();
                DDCIData.Value = DR1.GetValue(1).ToString();
                PredictionData.Value = DR1.GetValue(3).ToString();
                Timeline.Value = DR1.GetValue(4).ToString();
                ProjectBudget.Value = DR1.GetValue(5).ToString();
            }
            Conn.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string project = SearchBox.Text;
            if (!project.Contains("-") && project.Length >= 8) { project = project.Substring(0, 4) + '-' + project.Substring(3, 2) + '-' + project.Substring(5, 2); }
            Load_graph(project);
        }
    }
}