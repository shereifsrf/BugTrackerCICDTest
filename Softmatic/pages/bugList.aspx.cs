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
    public partial class campaignAdmin : System.Web.UI.Page
    {
       /* protected void Page_Load(object sender, EventArgs e)
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
        }*/

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<Model.Bug.BugDetails> getBugList()
        {
            List<Model.Bug.BugDetails> result = new List<Model.Bug.BugDetails>();

            result = Data.Bug.getBugList();

            return result;
        }

        
    }
}