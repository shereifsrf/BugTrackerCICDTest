using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Softmatic
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Data.User.isLogin())
                {
                    currentUserRole.Value = HttpContext.Current.Session["userRole"]?.ToString();
                }
                else
                {
                    Response.Redirect("pages/login.aspx");
                }
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Model.Common.TableValues getTableValues()
        {
            Model.Common.TableValues result = new Model.Common.TableValues();

            result = Data.User.getTableValues();

            return result;
        }
    }
}