using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;


namespace Softmatic.pages
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Data.User.isLogin())
                {
                    Response.Redirect("../index.aspx");
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult addNewUser(string email, string firstName, string lastName, string role, string password)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            result = Data.User.addUser(email, firstName, lastName, role, password, 1);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult userLogin(string email, string password)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            result = Data.User.userLogin(email, password);

            return result;
        }
    }
}