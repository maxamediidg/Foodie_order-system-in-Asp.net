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
            if(!Request.Url.AbsoluteUri.ToString().Contains("default.aspx"))
            {
                form1.Attributes.Add("class", "sub_page");
            }else
            {
                //Load the control
                Control SliderUserControl = (Control)Page.LoadControl("SliderUserControl.ascx");


                // add control to the panel
                pnlSliderUC.Controls.Add(SliderUserControl);
            }
        }
    }
}