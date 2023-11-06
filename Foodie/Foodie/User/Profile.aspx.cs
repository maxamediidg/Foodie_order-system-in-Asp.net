using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["Userid"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    getUserDetails();
                }
            }
        }
        void getUserDetails()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "select4Profile");
            cmd.Parameters.AddWithValue("@UserId", Session["Userid"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rUserProfile.DataSource = dt;
            rUserProfile.DataBind();
            if (dt.Rows.Count == 1)
            {
                Session["name"]= dt.Rows[0]["Name"].ToString();
                Session["email"] =dt.Rows[0]["Email"].ToString();
                Session["ImageUrl"] = dt.Rows[0]["ImageUrl"].ToString();
                Session["CreateDate"] = dt.Rows[0]["CreateDate"].ToString();
            }
           
        }

    }
}

