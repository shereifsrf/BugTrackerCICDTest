using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Softmatic
{
    /// <summary>
    /// Summary description for Common
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Common : System.Web.Services.WebService
    {
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<Model.Common.Lookup> getLookupList(string category)
        {
            var result = Data.Common.getLookup(category);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<Model.Common.Notification> getNotificationList()
        {
            int userId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            var result = Data.Common.getNotificationList(userId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Model.Common.homepageOverview getHomepageOverview()
        {
            var result = Data.Common.getHomepageOverview();

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Boolean isUserLogin()
        {
            var result = Data.User.isLogin();

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Model.Common.returnResult markNotificationAsRead(int notificationId)
        {
            var result = Data.Common.markNotificationAsRead(notificationId);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Model.Common.returnResult sendMessage(int toUserId, string message)
        {
            int fromuserId = Convert.ToInt32(HttpContext.Current.Session["userId"]);

            var result = Data.User.sendMessage(fromuserId, toUserId, message);

            return result;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Model.Common.returnResult logout()
        {
            var result = new Model.Common.returnResult(true, "Logout successfully");

            try
            {
                Session.Abandon();
            }
            catch (Exception e)
            {
                result.isSuccess = false;
                result.returnMsg = e.ToString();
            }

            return result;
        }
    }
}
