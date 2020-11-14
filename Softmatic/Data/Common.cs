using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography.X509Certificates;
using System.Web;

namespace Softmatic.Data
{
    public class Common
    {
        public static SqlDataReader execSQLReader(string sqlQuery, List<Model.Common.sqlParameter> parameters)
        {
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Bugs"].ConnectionString);
            SqlCommand cmd = new SqlCommand();
            SqlDataReader reader;

            cmd.CommandText = sqlQuery;
            cmd.CommandType = CommandType.Text;
            cmd.Connection = sqlConnection;

            if (parameters.Count > 0)
            {
                for (int i = 0; i < parameters.Count; i++)
                {
                    cmd.Parameters.AddWithValue(parameters[i].key, parameters[i].value);
                }
            }

            sqlConnection.Open();

            reader = cmd.ExecuteReader();

            return reader;
        }

        public static Model.Common.returnResult execSQLRetunResult(string sqlQuery, List<Model.Common.sqlParameter> parameters, Boolean returnValue = false)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();
            result.isSuccess = false;
            result.returnMsg = "";

            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Bugs"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = sqlQuery;
            cmd.CommandType = CommandType.Text;
            cmd.Connection = sqlConnection;

            if (parameters.Count > 0)
            {
                for (int i = 0; i < parameters.Count; i++)
                {
                    cmd.Parameters.AddWithValue(parameters[i].key, parameters[i].value);
                }
            }

            var isSuccessParam = cmd.Parameters.Add(new SqlParameter("@isSuccess", SqlDbType.Bit));
            isSuccessParam.Direction = ParameterDirection.Output;
            var returnMsgParam = cmd.Parameters.Add(new SqlParameter("@returnMsg", SqlDbType.NVarChar, 10000));
            returnMsgParam.Direction = ParameterDirection.Output;

            if (returnValue)
            {
                var returnValueParam = cmd.Parameters.Add(new SqlParameter("@returnValue", SqlDbType.NVarChar, 200));
                returnValueParam.Direction = ParameterDirection.Output;
            }

            try
            {
                sqlConnection.Open();
                cmd.ExecuteNonQuery();
                sqlConnection.Close();

                result.isSuccess = Convert.ToBoolean(cmd.Parameters["@isSuccess"].Value);
                result.returnMsg = cmd.Parameters["@returnMsg"].Value.ToString();
                if (returnValue)
                {
                    result.returnValue = cmd.Parameters["@returnValue"].Value.ToString();
                }
            }
            catch (Exception e)
            {
                result.returnMsg = e.ToString();//"System error, please contact csit314.randomguys@gmail.com for assistance.";
            }

            return result;
        }

        public static List<Model.Common.Lookup> getLookup(string category)
        {
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new Model.Common.sqlParameter("@category", category));

            var reader = Common.execSQLReader("SELECT * FROM tbl_lookup WHERE category=@category ORDER BY sequence, [key];", parameters);

            List<Model.Common.Lookup> list = new List<Model.Common.Lookup>();
            try
            {
                while (reader.Read())
                {
                    Model.Common.Lookup l = new Model.Common.Lookup();
                    l.key = reader["key"].ToString();
                    l.value = reader["value"].ToString();
                    l.description = reader["desc"].ToString();

                    list.Add(l);
                }
            }
            finally
            {
                // Always call Close when done reading.
                reader.Close();
            }
            return list;
        }

        public static Model.Common.homepageOverview getHomepageOverview()
        {
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            var reader = Common.execSQLReader("sp_getHomepageOverview", parameters);

            Model.Common.homepageOverview result = new Model.Common.homepageOverview();

            if (reader.HasRows)
            {
                reader.Read();

                result.totalCampiagn = Convert.ToInt32(reader["totalCampiagn"].ToString());
                result.totalDonors = Convert.ToInt32(reader["totalDonors"].ToString());
                result.totalFundRaised = Convert.ToDouble(reader["totalFundRaised"].ToString());

                reader.NextResult();

                List<Model.Bug.BugDetails> campiagnList = new List<Model.Bug.BugDetails>();
                while (reader.Read())
                {
                    Model.Bug.BugDetails campaign = new Model.Bug.BugDetails();

                    campaign.bugId = Convert.ToInt32(reader["bugId"].ToString());
                    campaign.title = reader["title"].ToString();
                    campaign.description = reader["description"].ToString();
                    campaign.category = reader["category"].ToString();
                    campaign.createdBy = reader["createdBy"].ToString();
                    campaign.createdByUserId = Convert.ToInt32(reader["createdByUserId"].ToString());
                    campaign.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());

                    List<Model.Bug.BugGallery> gallery = new List<Model.Bug.BugGallery>();
                    Model.Bug.BugGallery file = new Model.Bug.BugGallery();

                    file.srcPath = reader["srcPath"].ToString();
                    gallery.Add(file);

                    campaign.bugGalleryList = gallery;

                    campiagnList.Add(campaign);
                }

                result.campaignList = campiagnList;
            }

            return result;
        }

        public static List<Model.Common.Notification> getNotificationList(int userId)
        {
            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new Model.Common.sqlParameter("@userId", userId));

            var reader = Common.execSQLReader("sp_getNotificationList @userId", parameters);

            List<Model.Common.Notification> result = new List<Model.Common.Notification>();

            while (reader.Read())
            {
                Model.Common.Notification noti = new Model.Common.Notification();
                noti.notificationId = Convert.ToInt32(reader["msgId"].ToString());
                noti.content = reader["msgContent"].ToString();
                noti.createdOn = Convert.ToDateTime(reader["createdOn"].ToString());

                result.Add(noti);
            }

            return result;
        }

        public static Model.Common.returnResult markNotificationAsRead(int notificationId)
        {
            Model.Common.returnResult result = new Model.Common.returnResult();

            List<Model.Common.sqlParameter> parameters = new List<Model.Common.sqlParameter>();

            parameters.Add(new Model.Common.sqlParameter("@notificationId", notificationId));

            result = Data.Common.execSQLRetunResult("sp_markNotificationAsRead @notificationId, @isSuccess OUTPUT, @returnMsg OUTPUT", parameters);

            return result;
        }

        public static Model.Common.returnResult sendEmail(string subject, string content, string toEmail, string ccEmail)
        {
            Model.Common.returnResult result = new Model.Common.returnResult(false, "Error sending email, please try again");

            SmtpClient client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            client.Host = "smtp.gmail.com";
            client.Port = 587;

            // setup Smtp authentication
            System.Net.NetworkCredential credentials =
                new System.Net.NetworkCredential("csit314.randomguys@gmail.com", "csit314rg!");
            client.UseDefaultCredentials = false;
            client.Credentials = credentials;

            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("csit314.randomguys@gmail.com");
            msg.To.Add(new MailAddress(toEmail));

            if (ccEmail != "")
            {
                msg.CC.Add(new MailAddress(ccEmail));
            }

            msg.Subject = subject;
            msg.IsBodyHtml = true;
            msg.Body = string.Format("<html><head></head><body>" + content + "</body>");

            // Create file attachment
            Attachment ImageAttachment = new Attachment(HttpContext.Current.Server.MapPath("../img/logo.png"));
            // Set the ContentId of the attachment, used in body HTML
            ImageAttachment.ContentId = "logo.png";

            // Add an image as file attachment
            msg.Attachments.Add(ImageAttachment);

            try
            {
                client.Send(msg);
                result.isSuccess = true;
                result.returnMsg = "Your message has been successfully sent.";
            }
            catch (Exception ex)
            {
                result.returnMsg = "System error, please contact csit314.randomguys@gmail.com for assistance.";
            }

            return result;
        }
    }
}