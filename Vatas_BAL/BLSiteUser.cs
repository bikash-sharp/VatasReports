using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLSiteUser : BLCommon
    {
        private static readonly BLSiteUser _instance;
        private static AdminEntities _context;

        static BLSiteUser()
        {
            _instance = new BLSiteUser();
        }

        private BLSiteUser()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLSiteUser Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }

        public StringMessageCL GetSiteUserIDByUserNameOREmailAddress(string identity)
        {
            try
            {
                var _user =
                    _context.tbl_UserGroup_Registration.Where(p => (p.EmailID.ToLower() == identity.ToLower()))
                        .FirstOrDefault();

                if (_user != null)
                {
                    return new StringMessageCL("Register User found", ResponseType.SUCCESS, "Success",
                        _user.Super_User_Id, _user);
                }
                else
                {
                    return
                        new StringMessageCL(
                            "User not found.Please verify the Username / Email and password once again",
                            ResponseType.DANGER, "", 0);
                }
            }
            catch (DbEntityValidationException ex)
            {
                return new StringMessageCL(ex.InnerException.Message, ResponseType.DANGER, "", 0);
            }
            catch (Exception ex)
            {
                return new StringMessageCL(ex.InnerException.Message, ResponseType.DANGER, "", 0);
            }

        }

        public tbl_UserGroup_Registration GetSiteUserByID(long userID)
        {
            return _context.tbl_UserGroup_Registration.Where(p => p.Super_User_Id == userID).FirstOrDefault();
        }

        public List<UserCL> GetAllUsers()
        {
            return
                _context.tbl_UserGroup_Registration.ToList()
                    .Select(p => new UserCL { UserID = p.Super_User_Id, Username = p.Name })
                    .ToList();
        }

        public List<DropDownCL> GetUserRolesByRoleId(int RoleId)
        {
            return
                _context.proc_GetUserRoleByRoleId(RoleId)
                    .Select(p => new DropDownCL { DataText = p.UserName, DataValue = p.UserID.ToString() })
                    .ToList();
        }

        public bool SaveNewUser(User user)
        {
            try
            {
                _context.proc_SaveNewUser(user.FirstName, user.LastName, user.Email, user.Password, user.MobileNumber, user.AccountType);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
