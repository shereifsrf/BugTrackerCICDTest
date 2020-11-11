using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Softmatic.pages
{
    public partial class userList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsPostBack)
                {
                    if (Data.User.isLogin())
                    {
                        
                    }
                    else
                    {
                        Response.Redirect("../index.aspx");
                    }
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<Model.User.UserDetail> getUserList()
        {
            List<Model.User.UserDetail> result = new List<Model.User.UserDetail>();

            result = Data.User.getUserList();

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult addNewUser(string firstName, string lastName, string email, string role, string password)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error creating new suer");

            int createdBy = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.User.addUser(email, firstName, lastName, role, password,5);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult updateUserStatus(int userId, Boolean isActive)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error updating user status");

            int updatedBy = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.User.updateUserStatus(userId, isActive, updatedBy);

            return result;
        }
    }
}