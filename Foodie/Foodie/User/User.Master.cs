using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class User : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.Url.AbsoluteUri.ToString().Contains("default.aspx"))
            {
                form1.Attributes.Add("class", "sub_page");
            } else
            {
                //Load the control
                Control SliderUserControl = (Control)Page.LoadControl("SliderUserControl.ascx");


                // add control to the panel
                pnlSliderUC.Controls.Add(SliderUserControl);
            }
            if (Session["Userid"] != null)
            {
                lbLoginOrLogOut.Text = "LogOut";
            }
            else
            {
                lbLoginOrLogOut.Text = "Login";
            }
        }

        protected void lbLoginOrLogOut_Click(object sender, EventArgs e)
        {
            if (Session["Userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbRegisterOrProfile_Click(object sender, EventArgs e)
        {
            if (Session["Userid"] != null)
            {
                lbRegisterOrProfile.ToolTip = "User Profile";
                Response.Redirect("Profile.aspx");
            }
            else
            {
                lbRegisterOrProfile.ToolTip = "User Registration";
                Response.Redirect("Registration.aspx");
            }
        }

    }


}