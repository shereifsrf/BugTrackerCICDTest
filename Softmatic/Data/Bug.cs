using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Hosting;
using static Softmatic.Model.Common;

namespace Softmatic.Data
{
    // This is a bug class....
    public class Bug
    {


        ///fwkehfuwgefgwuie
        public static Model.Common.returnResult addBug(string title, string description, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@title", title));
            parameters.Add(new sqlParameter("@description", description));
            parameters.Add(new sqlParameter("@createBy", userId));

            result = Data.Common.execSQLRetunResult("sp_addNewBug @title, @description,  @createBy, @isSuccess OUTPUT, @returnMsg OUTPUT, @returnValue OUTPUT", parameters, true);

            if (result.isSuccess)
            {
                int bugId = Convert.ToInt32(result.returnValue);
            }

            return result;
        }

        public static Model.Common.returnResult updateBug(int bugId, string title, string description, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@bugId", bugId));
            parameters.Add(new sqlParameter("@title", title));
            parameters.Add(new sqlParameter("@description", description));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_updateBug @bugId, @title, @description, @userId, @isSuccess OUTPUT, @returnMsg OUTPUT, @returnValue OUTPUT", parameters, true);

            return result;
        }

        public static Model.Common.returnResult updateBugStatus(int bugId, string action, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@bugId", bugId));
            parameters.Add(new sqlParameter("@action", action));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_updateBugStatus @bugId, @action, @userId, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.Bug.BugDetails getBugDetails(int bugId)
        {
            Model.Bug.BugDetails result = new Model.Bug.BugDetails();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@bugId", bugId));

            var reader = Data.Common.execSQLReader("sp_getBugDetails @bugId", parameters);

            if (reader.HasRows)
            {
                reader.Read();

                result.title = reader["title"].ToString();
                result.description = reader["description"].ToString();
                result.createdBy = reader["createdBy"].ToString();
                result.createdByUserId = Convert.ToInt32(reader["createdByUserId"].ToString());
                /*                result.status = reader["status"].ToString();
                */
                result.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());

                try
                {
                    result.developerId = Convert.ToInt32(reader["developerId"].ToString());
                }
                catch (Exception e)
                {
                    result.developerId = 0;
                }
                reader.Close();
            }

            return result;
        }

        public static List<Model.Bug.BugDetails> getBugList()
        {
            List<Model.Bug.BugDetails> bugList = new List<Model.Bug.BugDetails>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            var reader = Data.Common.execSQLReader("sp_getBugList", parameters);

            if (reader.HasRows)
            {

                while (reader.Read())
                {
                    Model.Bug.BugDetails bug = new Model.Bug.BugDetails();
                    bug.bugId = Convert.ToInt32(reader["bugId"].ToString());
                    bug.title = reader["title"].ToString();
                    bug.description = reader["description"].ToString();
                    bug.createdBy = reader["createdBy"].ToString();
                    //bug.createdByUserId = Convert.ToInt32(reader["createdByUserId"].ToString());
                    bug.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());
                    bugList.Add(bug);
                }

                reader.Close();
            }

            return bugList;
        }

        public static Model.Bug.BugCommentList getBugCommentList(int bugId, int userId, int pageIndex, int pageSize)
        {
            Model.Bug.BugCommentList result = new Model.Bug.BugCommentList();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@bugId", bugId));
            parameters.Add(new sqlParameter("@userId", userId));
            parameters.Add(new sqlParameter("@pageIndex", pageIndex));
            parameters.Add(new sqlParameter("@pageSize", pageSize));

            var reader = Data.Common.execSQLReader("sp_getBugComment @userId, @bugId, @pageIndex, @pageSize", parameters);

            if (reader.HasRows)
            {
                reader.Read();

                result.bugCommentListCount = Convert.ToInt32(reader["rowCount"].ToString());

                reader.NextResult();

                List<Model.Bug.BugComment> commentList = new List<Model.Bug.BugComment>();
                while (reader.Read())
                {
                    Model.Bug.BugComment comment = new Model.Bug.BugComment();
                    comment.commentId = Convert.ToInt32(reader["commentId"].ToString());
                    comment.content = reader["content"].ToString();
                    comment.createdBy = reader["createdBy"].ToString();
                    comment.createdByUserId = Convert.ToInt32(reader["createdByUserId"].ToString());
                    comment.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());

                    commentList.Add(comment);
                }

                result.bugCommentList = commentList;

                reader.Close();
            }

            return result;
        }

        public static Model.Common.returnResult addComment(string content, int bugId, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@content", content));
            parameters.Add(new sqlParameter("@bugId", bugId));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_addBugComment @content, @bugId, @userId, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.Common.returnResult addCommentLike(int commentId, int userId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@commentId", commentId));
            parameters.Add(new sqlParameter("@userId", userId));

            result = Data.Common.execSQLRetunResult("sp_addCommentLike @commentId, @userId, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }



        public static List<Model.Bug.BugDetails> getMyBugList(int userId)
        {
            List<Model.Bug.BugDetails> result = new List<Model.Bug.BugDetails>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@userId", userId));

            var reader = Data.Common.execSQLReader("sp_getMyBugList @userId", parameters);


            while (reader.Read())
            {
                Model.Bug.BugDetails bug = new Model.Bug.BugDetails();

                bug.bugId = Convert.ToInt32(reader["bugId"].ToString());
                bug.title = reader["title"].ToString();
                bug.status = reader["status"].ToString();
                bug.createdBy = reader["createdBy"].ToString();
                bug.description = reader["description"].ToString();
                bug.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());


                result.Add(bug);
            }

            reader.Close();


            return result;
        }

        public static List<Model.Bug.BugDetails> getAdminBugList(DateTime startDate, DateTime endDate)
        {
            List<Model.Bug.BugDetails> result = new List<Model.Bug.BugDetails>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@startDate", startDate));
            parameters.Add(new sqlParameter("@endDate", endDate));

            var reader = Data.Common.execSQLReader("sp_getAdminBugList @startDate, @endDate", parameters);
            List<Model.Bug.BugGallery> bugImageList = new List<Model.Bug.BugGallery>();

            while (reader.Read())
            {
                Model.Bug.BugGallery file = new Model.Bug.BugGallery();

                file.bugId = Convert.ToInt32(reader["bugId"].ToString());
                file.srcPath = reader["srcPath"].ToString();
                file.galleryId = Convert.ToInt32(reader["galleryId"].ToString());

                bugImageList.Add(file);
            }

            reader.NextResult();

            while (reader.Read())
            {
                Model.Bug.BugDetails bug = new Model.Bug.BugDetails();

                bug.bugId = Convert.ToInt32(reader["bugId"].ToString());
                bug.title = reader["title"].ToString();
                bug.description = reader["description"].ToString();
                bug.category = reader["category"].ToString();
                bug.status = reader["status"].ToString();
                bug.createdBy = reader["createdBy"].ToString();
                bug.createdByUserId = Convert.ToInt32(reader["createdByUserId"].ToString());
                bug.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());
                bug.bugGalleryList = bugImageList.FindAll(e => e.bugId == bug.bugId);

                result.Add(bug);
            }

            reader.Close();

            return result;
        }

        public static List<Model.Bug.BugDetails> getBugList(DateTime startDate, DateTime endDate)
        {
            List<Model.Bug.BugDetails> result = new List<Model.Bug.BugDetails>();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@startDate", startDate));
            parameters.Add(new sqlParameter("@endDate", endDate));

            var reader = Data.Common.execSQLReader("sp_getAdminBugList @startDate, @endDate", parameters);
            List<Model.Bug.BugGallery> bugImageList = new List<Model.Bug.BugGallery>();

            while (reader.Read())
            {
                Model.Bug.BugGallery file = new Model.Bug.BugGallery();

                file.bugId = Convert.ToInt32(reader["bugId"].ToString());
                file.srcPath = reader["srcPath"].ToString();
                file.galleryId = Convert.ToInt32(reader["galleryId"].ToString());

                bugImageList.Add(file);
            }

            reader.NextResult();

            while (reader.Read())
            {
                Model.Bug.BugDetails bug = new Model.Bug.BugDetails();

                bug.bugId = Convert.ToInt32(reader["bugId"].ToString());
                bug.title = reader["title"].ToString();
                bug.description = reader["description"].ToString();
                bug.category = reader["category"].ToString();
                bug.status = reader["status"].ToString();
                bug.createdBy = reader["createdBy"].ToString();
                bug.createdByUserId = Convert.ToInt32(reader["createdByUserId"].ToString());
                bug.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());
                bug.bugGalleryList = bugImageList.FindAll(e => e.bugId == bug.bugId);

                result.Add(bug);
            }

            reader.Close();

            return result;
        }

        public static bool AssignDeveloper(int bugId, int devId)
        {
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new sqlParameter("@bugId", bugId));
            parameters.Add(new sqlParameter("@devId", devId));

            Data.Common.execSQLRetunResult("sp_updateBugDeveloper @bugId, @devId", parameters, true);
            return true;
        }
    }
}