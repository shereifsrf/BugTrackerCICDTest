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
    public partial class bugDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Data.User.isLogin())
                {
                    commentForm.Visible = true;
                    currentUserRole.Value = HttpContext.Current.Session["userRole"]?.ToString();
                }
                else
                {
                    commentForm.Visible = false;
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Bug.BugDetails getBugDetails(int bugId)
        {
            Model.Bug.BugDetails result = new Model.Bug.BugDetails();

            result = Data.Bug.getBugDetails(bugId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult addComment(string comment, int bugId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error inserting comment");

            var userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.Bug.addComment(comment, bugId, userId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Bug.BugCommentList getBugComments(int bugId, int pageIndex, int pageSize)
        {
            Model.Bug.BugCommentList result = new Model.Bug.BugCommentList();
            var userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            result = Data.Bug.getBugCommentList(bugId, userId, pageIndex, pageSize);

            return result;
        }



        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult addCommentLike(int commentId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error inserting comment");

            var userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            if (userId == 0)
            {
                result.returnMsg = "Login required";
                return result;
            }

            result = Data.Bug.addCommentLike(commentId, userId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<Model.User.StaffList> getDevList()
        {
            var result = Data.User.getDeveleperList();
            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string getCurrentlyAssignedDeveloper(int bugId)
        {
            return Data.User.getCurrentDeveloper(bugId);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool assignDeveloper(int bugId, int? devId)
        {
            if (devId == null)
            {
                return Data.Bug.AssignDeveloper(bugId, 0);
            }
            else
            {
                return Data.Bug.AssignDeveloper(bugId, devId.Value);
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult ResolveBug(int bugId)
        {
            var userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);
            var role = HttpContext.Current.Session["userRole"]?.ToString();

            if(role == "dvp")
            {
                var bugDetails = Data.Bug.getBugDetails(bugId);
                if(bugDetails.developerId != userId)
                {
                    return new Model.Common.returnResult
                    {
                        isSuccess = false,
                        returnMsg = "This Bug is assigned to another developer. You are not entitles to resolve this."
                    };
                }
            }

            var isCommented = Data.Bug.CheckComment(bugId, userId);

            if (!isCommented.isSuccess)
            {
                return isCommented;
            }

            return Data.Bug.ResolveBug(bugId);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool ApproveAndCloseBug(int bugId)
        {
            var reviewer = Convert.ToInt32(HttpContext.Current.Session["userId"]);
            return Data.Bug.AproveBugFix(bugId, reviewer);
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool RejectBugFix(int bugId)
        {
            var reviewer = Convert.ToInt32(HttpContext.Current.Session["userId"]);
            return Data.Bug.RejectBugFix(bugId, reviewer);
        }
    }
}