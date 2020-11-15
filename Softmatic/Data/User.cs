using Softmatic.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Hosting;
using static Softmatic.Model.Common;

namespace Softmatic.Data
{
    public class User
    {
        public static Boolean isLogin()
        {
            return HttpContext.Current.Session["userId"] != null;
        }

        public static string getLoginUserRole()
        {
            return HttpContext.Current.Session["userRole"].ToString();
        }

        public static Model.Common.returnResult userLogin(string email, string password)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Incorrect email/password.");

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@email", email));
            parameters.Add(new sqlParameter("@password", password));

            var reader = Data.Common.execSQLReader("sp_userLogin @email, @password", parameters);

            if (reader.HasRows)
            {
                reader.Read();

                var userId = Convert.ToInt32(reader["userId"].ToString());
                var role = reader["role"].ToString();

                reader.Close();

                if (string.IsNullOrEmpty(role))
                {
                    result = new Model.Common.returnResult(false, "No role is assigned to the User. Please wait till the admin assign them. ");
                    return result;
                }

                System.Web.HttpContext.Current.Session["userId"] = userId;
                System.Web.HttpContext.Current.Session["userRole"] = role;

                result.isSuccess = true;
                result.returnMsg = "Login Successfully";

            }

            return result;
        }

        public static Model.Common.returnResult addUser(string email, string firstName, string lastName, string role, string password, int createdBy)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@email", email));
            parameters.Add(new sqlParameter("@firstName", firstName));
            parameters.Add(new sqlParameter("@lastName", lastName));
            parameters.Add(new sqlParameter("@role", role));
            parameters.Add(new sqlParameter("@password", password));
            parameters.Add(new sqlParameter("@createdBy", createdBy));

            result = Data.Common.execSQLRetunResult("sp_addNewUser @email, @firstName, @lastName, @role, @password, @createdBy, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.Common.returnResult updateUserStatus(int userId, Boolean isActive, int updatedBy)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@userId", userId));
            parameters.Add(new sqlParameter("@isActive", isActive));
            parameters.Add(new sqlParameter("@updatedBy", updatedBy));

            result = Data.Common.execSQLRetunResult("sp_updateUserStatus @userId, @isActive, @updatedBy, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.Common.returnResult updateUserProfile(string email, string firstName, string lastName, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@email", email));
            parameters.Add(new sqlParameter("@firstName", firstName));
            parameters.Add(new sqlParameter("@lastName", lastName));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_updateUserProfile @email, @firstName, @lastName, @userId, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }
        public static Model.Common.returnResult updateUserPassword(string password, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@password", password));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_updateUserPassword @password, @userId, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.Common.returnResult updateRole(string role, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@role", role));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_updateUserRole @userId, @role, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.User.UserDetail getUserDetail(int userId)
        {
            Model.User.UserDetail result = new Model.User.UserDetail();
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@userId", userId));

            var reader = Data.Common.execSQLReader("sp_getUserDetails @userId", parameters);

            if (reader.HasRows)
            {
                reader.Read();

                result.firstName = reader["firstName"].ToString();
                result.lastName = reader["lastName"].ToString();
                result.email = reader["email"].ToString();

                reader.Close();
            }

            return result;
        }

        public static List<Model.User.UserDetail> getUserList()
        {
            List<Model.User.UserDetail> result = new List<Model.User.UserDetail>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            var reader = Data.Common.execSQLReader("sp_getUserList", parameters);

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Model.User.UserDetail user = new Model.User.UserDetail();

                    user.userId = Convert.ToInt32(reader["userId"].ToString());
                    user.firstName = reader["firstName"].ToString();
                    user.lastName = reader["lastName"].ToString();
                    user.role = reader["role"].ToString();
                    user.email = reader["email"].ToString();
                    user.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());

                    result.Add(user);
                }
                reader.Close();
            }

            return result;
        }

        public static List<Model.User.Inbox> getInboxList(int userId)
        {
            List<Model.User.Inbox> result = new List<Model.User.Inbox>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new Model.Common.sqlParameter("@userId", userId));

            var reader = Data.Common.execSQLReader("sp_getInboxList @userId", parameters);

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Model.User.Inbox inbox = new Model.User.Inbox();

                    inbox.fromUserId = Convert.ToInt32(reader["fromUserId"].ToString());
                    inbox.fromUserName = reader["userName"].ToString();
                    inbox.fromUserPic = reader["profilePic"].ToString();
                    inbox.lastUpdated = Convert.ToDateTime(reader["lastUpdated"].ToString());
                    inbox.unreadCount = Convert.ToInt32(reader["unreadCount"].ToString());

                    result.Add(inbox);
                }
                reader.Close();
            }

            return result;
        }

        public static List<Model.User.Message> getMessageList(int fromUserId, int toUserId)
        {
            List<Model.User.Message> result = new List<Model.User.Message>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new Model.Common.sqlParameter("@fromUserId", fromUserId));
            parameters.Add(new Model.Common.sqlParameter("@toUserId", toUserId));

            var reader = Data.Common.execSQLReader("sp_getMsgList @fromUserId, @toUserId", parameters);

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Model.User.Message message = new Model.User.Message();

                    message.byUserId = Convert.ToInt32(reader["fromUserId"].ToString());
                    message.byUserName = reader["fromUserName"].ToString();
                    message.msgContent = reader["msgContent"].ToString();
                    message.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());

                    result.Add(message);
                }
                reader.Close();
            }

            return result;
        }

        public static Model.Common.returnResult sendMessage(int fromUserId, int toUserId, string message)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@fromUserId", fromUserId));
            parameters.Add(new sqlParameter("@toUserId", toUserId));
            parameters.Add(new sqlParameter("@msgContent", message));

            result = Data.Common.execSQLRetunResult("sp_sendMessage @fromUserId, @toUserId, @msgContent, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        /// <summary>
        /// THis method will query the stored procedure and get the list of all developers.
        /// </summary>
        /// <returns></returns>
        public static List<Model.User.StaffList> getDeveleperList()
        {
            List<Model.User.StaffList> result = new List<Model.User.StaffList>();
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            var reader = Data.Common.execSQLReader("sp_getDevList", parameters);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    Model.User.StaffList user = new Model.User.StaffList();
                    user.UserName = reader["UserName"].ToString();
                    user.UserId = Convert.ToInt32(reader["UserId"].ToString());
                    result.Add(user);
                }
                //reader.Close();
            }
            reader.Close();

            return result;
        }

        public static string getCurrentDeveloper(int bugId)
        {
            string devId = "";

            Model.User.UserDetail result = new Model.User.UserDetail();
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@bugId", bugId));

            var reader = Data.Common.execSQLReader("sp_getBugDeveloper @bugId", parameters);

            if (reader.HasRows)
            {
                reader.Read();
                devId = reader["developerId"].ToString();
                reader.Close();
            }

            return devId;
        }

        public static TableValues getTableValues()
        {

            Model.Common.TableValues result = new Model.Common.TableValues();
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            var reader = Data.Common.execSQLReader("sp_getTableValues", parameters);

            if (reader.HasRows)
            {
                reader.Read();
                result.totalUsers = Convert.ToInt32(reader["totalUsers"].ToString());
                result.monthlyUsers = Convert.ToInt32(reader["monthlyUsers"].ToString());
                result.weeklyUsers = Convert.ToInt32(reader["weeklyUsers"].ToString());
                result.totalReports = Convert.ToInt32(reader["totalReports"].ToString());
                result.monthlyReports = Convert.ToInt32(reader["monthlyReports"].ToString());
                result.weeklyReports = Convert.ToInt32(reader["weeklyReports"].ToString());
                result.totalResolved = Convert.ToInt32(reader["totalResolved"].ToString());
                result.monthlyResolved = Convert.ToInt32(reader["monthlyResolved"].ToString());
                result.weeklyResolved = Convert.ToInt32(reader["weeklyResolved"].ToString());
                result.bestDeveloperAll = reader["bestDeveloperAll"].ToString();
                result.bestDeveloperAllTotReports = Convert.ToInt32(reader["bestDeveloperAllTotReports"].ToString());
                result.bestDeveloperMonth = reader["bestDeveloperMonth"].ToString();
                result.bestDeveloperMonthTotReports = Convert.ToInt32(reader["bestDeveloperMonthTotReports"].ToString());
                result.bestDeveloperWeek = reader["bestDeveloperWeek"].ToString();
                result.bestDeveloperWeekTotReports = Convert.ToInt32(reader["bestDeveloperWeekTotReports"].ToString());
                result.bestReporterAll = reader["bestReporterAll"].ToString();
                result.bestReporterAllTotReports = Convert.ToInt32(reader["bestReporterAllTotReports"].ToString());
                result.bestReporterMonth = reader["bestReporterMonth"].ToString();
                result.bestReporterMonthTotReports = Convert.ToInt32(reader["bestReporterMonthTotReports"].ToString());
                result.bestReporterWeek = reader["bestReporterWeek"].ToString();
                result.bestReporterWeekTotReports = Convert.ToInt32(reader["bestReporterWeekTotReports"].ToString());
            }
            reader.Close();

            return result;
        }
    }
}