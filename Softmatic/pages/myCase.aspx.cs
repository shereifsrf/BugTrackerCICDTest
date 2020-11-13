using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Softmatic.pages
{
    public partial class myCase : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsPostBack)
                {
                    if (Data.User.isLogin())
                    {
                        /*if (Data.User.getLoginUserRole().Equals("USR"))
                        {
                            userTabs.Visible = true;
                        }
                        else
                        {
                            userTabs.Visible = false;
                        }*/
                    }
                    else
                    {
                        Response.Redirect("./login.aspx");
                    }
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.User.UserDetail getUserDetails(int userId)
        {
            Model.User.UserDetail result = new Model.User.UserDetail();

            result = Data.User.getUserDetail(userId == 0 ? Convert.ToInt32(HttpContext.Current.Session["userId"]) : userId);

            return result;
        }


        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult updateUserProfile(string email, string firstName, string lastName)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error updating password");

            int userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.User.updateUserProfile(email, firstName, lastName, userId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult updateUserPassword(string password)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error updating password");

            result = Data.User.updateUserPassword(password, Convert.ToInt32(HttpContext.Current.Session["userId"]));

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult createBug(string title, string description)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error creating campaign");

            result = Data.Bug.addBug(title, description, Convert.ToInt32(HttpContext.Current.Session["userId"]));

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult updateBug(int bugId, string title, string description)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error updating campaign");

            result = Data.Bug.updateBug(bugId, title, description, Convert.ToInt32(HttpContext.Current.Session["userId"]));

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<Model.Bug.BugDetails> getmyCase()
        {
            List<Model.Bug.BugDetails> result = new List<Model.Bug.BugDetails>();

            int userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);
            result = Data.Bug.getMyBugList(userId);

            return result;
        }
    }
}