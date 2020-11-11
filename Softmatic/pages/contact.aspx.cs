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
    public partial class contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.returnResult submitContactUsForm(string subject, string content, string toEmail)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error submitting form, please try again");

            result = Data.Common.sendEmail(subject, content, toEmail, "fundsomething.softmatic@gmail.com");

            return result;
        }
    }
}