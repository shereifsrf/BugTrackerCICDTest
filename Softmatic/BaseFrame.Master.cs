using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Softmatic.Model.Common;

namespace Softmatic
{
    public partial class BaseFrame : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<string> staffRole = new List<string> { "FNC", "MGR", "STF" };

            if (!IsPostBack)
            {
                if (Data.User.isLogin())
                {
                    plhLogin.Visible = true;
                    loginMenu.Visible = false;

                    if (staffRole.Contains(Data.User.getLoginUserRole()))
                    {
                        navStaff.Visible = true;
                    }
                    else
                    {
                        navStaff.Visible = false;
                    }

                    if (Data.User.getLoginUserRole().Equals("ADMIN"))
                    {
                        navAdmin.Visible = true;
                    }
                    else
                    {
                        navAdmin.Visible = false;
                    }
                }
                else
                {
                    plhLogin.Visible = false;
                    loginMenu.Visible = true;
                }
            }
        }
    }
}