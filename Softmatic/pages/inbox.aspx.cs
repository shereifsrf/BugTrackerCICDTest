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
    public partial class inbox : System.Web.UI.Page
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
        public static List<Model.User.Inbox> getInboxList()
        {
            List<Model.User.Inbox> result = new List<Model.User.Inbox>();

            var userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.User.getInboxList(userId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<Model.User.Message> getMessageList(int fromUserId)
        {
            List<Model.User.Message> result = new List<Model.User.Message>();

            var userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.User.getMessageList(fromUserId, userId);

            return result;
        }
    }
}