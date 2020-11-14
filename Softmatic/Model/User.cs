using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Softmatic.Model
{
    public class User
    {
        public class UserDetail
        {
            public int userId { get; set; }
            public string email { get; set; }
            public string firstName { get; set; }
            public string lastName { get; set; }
            public string password { get; set; }
            public string role { get; set; }
            public DateTime createdOn { get; set; }
            public string createdBy { get; set; }

        }

        public class Inbox
        {
            public int fromUserId { get; set; }
            public string fromUserName { get; set; }
            public string fromUserPic { get; set; }
            public DateTime lastUpdated { get; set; }
            public int unreadCount { get; set; }
        }

        public class Message
        {
            public int byUserId { get; set; }
            public string byUserName { get; set; }
            public string msgContent { get; set; }
            public DateTime createdOn { get; set; }
        }

        public class StaffList
        {
            public int UserId { get; set; }
            public string UserName { get; set; }
        }
    }
}