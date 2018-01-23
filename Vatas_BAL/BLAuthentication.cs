using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLAuthentication : BLCommon
    {
        // Explicit static constructor to tell C# compiler
        // not to mark type as beforefieldinit
        private static readonly BLAuthentication _instance;
        
        private static AdminEntities _context;
        
        static BLAuthentication()
        {
            _instance = new BLAuthentication();
        }

        private BLAuthentication()
        {
        }

        public static BLAuthentication Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }

        public AuthMessageCL IsUserAuthenticated(LogonCL logon)
        {
            try
            {
                var result = BLSiteUser.Instance(_context).GetSiteUserIDByUserNameOREmailAddress(logon.Email.Trim());

                if (result.Response != ResponseType.SUCCESS)
                {
                    return new AuthMessageCL(0, null, 0, null, "", ResponseType.DANGER, "The username/email is not yet taken. Try creating a new account instead.");
                }

                tbl_UserGroup_Registration user = result.ObjClass;

                if (user.Password != logon.Password)
                {
                    return new AuthMessageCL(0, null, 0, null, "", ResponseType.DANGER, "The username and/or password is invalid.");
                }
                else if(user.Is_Login_Active != "Y")
                {
                    return new AuthMessageCL(0, null, 0, null, "", ResponseType.DANGER, "The account has been disabled.");
                }
                else
                {
                    string roleName = "";
                    var UserRoles = BLSiteUser.Instance(_context).GetUserRolesByUserId(user.Super_User_Id).FirstOrDefault();
                    if(UserRoles != null)
                    {
                        roleName = UserRoles.RoleName;
                    }
                    else
                    {
                        roleName = "Staff";
                    }
                    string token = Guid.NewGuid().ToString();

                    return new AuthMessageCL(user.Super_User_Id, logon.Email, 0, roleName,token, ResponseType.SUCCESS, "Success");
                }

            }
            catch (DbEntityValidationException ex)
            {
                var error = ex.Message;
                return new AuthMessageCL(0, "", 0, "", "", ResponseType.WARNING, "");
            }
            catch (Exception ex)
            {
                var error = ex.Message;
                return new AuthMessageCL(0, "", 0, "", "", ResponseType.WARNING, "");
            }
        }


    }
}
