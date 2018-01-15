using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Routing;
using System.Globalization;
using System.Threading;
using System.Security.Principal;
using System.Web.UI;
using Vatas_Common;

namespace Vatas_UI
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RegisterRoutes();
        }
        public void RegisterRoutes()
        {
            RouteCollection routes = RouteTable.Routes;

            #region Login
            routes.MapPageRoute("Login", "Login", "~/Login.aspx", true);
            routes.MapPageRoute("SignUp", "SignUp", "~/SignUp.aspx", true);

            routes.MapPageRoute("CreateUser", "CreateUser", "~/CreateUser.aspx", true);

            routes.MapPageRoute("Lock", "Lock", "~/LockScreen.aspx", true);
            routes.MapPageRoute("ForgotPassword", "RecoverPassword", "~/ForgotPassword.aspx", true);
            routes.MapPageRoute("ChangePassword", "ChangePassword", "~/ChangePassword.aspx", true);
            #endregion

            #region Home Sections
            routes.MapPageRoute("Home", "Index", "~/Home/Index.aspx", true);
            #endregion

            #region Reports Based Pages
            routes.MapPageRoute("FrontOfficeReturn", "FrontOfficeReturn", "~/Reports/Return_Recv_Front_Office.aspx", true);
            routes.MapPageRoute("ReturnAssigned", "ReturnAssigned", "~/Reports/Return_Assigned.aspx", true);
            routes.MapPageRoute("ReturnCompleted", "ReturnCompleted", "~/Reports/Return_Completed.aspx", true);
            routes.MapPageRoute("ReturnIncompleted", "ReturnIncompleted", "~/Reports/Return_InCompleted.aspx", true);
            routes.MapPageRoute("ReturnUploaded", "ReturnUploaded", "~/Reports/Return_Uploaded.aspx", true);
            routes.MapPageRoute("ReturnPending", "ReturnPending", "~/Reports/Return_Pending.aspx", true);
            routes.MapPageRoute("SearchJobsBetweenDates", "SearchJobsBetweenDates", "~/Reports/Search_Jobs_Between_Dates.aspx", true);
            #endregion

            #region Process Based Pages
            routes.MapPageRoute("ProcessFrontOfficeReturn", "ProcessFrontOfficeReturn", "~/Process/Process_FrontOfficeReturns.aspx", true);
            routes.MapPageRoute("ProcessBackOfficeReturn", "ProcessBackOfficeReturn", "~/Process/Process_BackOfficeReturns.aspx", true);
            routes.MapPageRoute("ProcessAssignReturn", "ProcessAssignReturn", "~/Process/Process_AssignReturns.aspx", true);
            routes.MapPageRoute("ProcessReAssignReturn", "ProcessReAssignReturn", "~/Process/Process_ReAssignReturns.aspx", true);
            routes.MapPageRoute("ProcessVerifyReturn", "ProcessVerifyReturn", "~/Process/Process_VerifyReturns.aspx", true);
            routes.MapPageRoute("ProcessCompletedReturn", "ProcessCompletedReturn", "~/Process/Process_CompletedReturns.aspx", true);
            routes.MapPageRoute("ProcessInCompletedReturn", "ProcessInCompletedReturn", "~/Process/Process_IncompletedReturns.aspx", true);
            routes.MapPageRoute("ProcessUploadReturn", "ProcessUploadReturn", "~/Process/Process_UploadReturns.aspx", true);
            #endregion
        }
        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            CultureInfo newCulture = (CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
            newCulture.DateTimeFormat.ShortDatePattern = "dd-MM-yyyy";
            newCulture.DateTimeFormat.DateSeparator = "-";


            newCulture.DateTimeFormat.LongDatePattern = "dd-MM-yyyy";
            Thread.CurrentThread.CurrentCulture = newCulture;
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    var identity = HttpContext.Current.User.Identity as FormsIdentity;
                    if (identity != null)
                    {
                        FormsIdentity id = identity;
                        FormsAuthenticationTicket ticket = id.Ticket;

                        //string userData = BLSecurity.Decrypt(ticket.UserData);
                        
                        //string[] roles = new string[] { userData.Split('$')[3] };

                        //HttpContext.Current.User = new GenericPrincipal(id, roles);
                    }
                }
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            //Create Log in Application

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}