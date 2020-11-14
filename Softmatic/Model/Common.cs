using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Softmatic.Model
{
    public class Common
    {
        public class Lookup {
            public string key { get; set; }
            public string value { get; set; }
            public string description { get; set; }
        }

        public class File
        {
            public string fileName { get; set; }
            public string fileData { get; set; }
        }

        public class Notification
        {
            public int notificationId { get; set; }
            public string content { get; set; }
            public DateTime createdOn { get; set; }
        }

        public class homepageOverview
        {
            public int totalCampiagn { get; set; }
            public int totalDonors { get; set; }
            public double totalFundRaised { get; set; }
            public List<Model.Bug.BugDetails> campaignList { get; set; }
        }

        public class returnResult {
            public Boolean isSuccess { get; set; }
            public string returnMsg { get; set; }
            public string returnValue { get; set; }

            public returnResult()
            {

            }

            public returnResult(Boolean isSuccess, string returnMsg)
            {
                this.isSuccess = isSuccess;
                this.returnMsg = returnMsg;
            }

            public override bool Equals(object obj)
            {
                if(obj is returnResult)
                {
                    var that = obj as returnResult;
                    return this.isSuccess == that.isSuccess && this.returnValue == that.returnValue && this.returnMsg == that.returnMsg;
                }
                return false;
            }
        }

        public class sqlParameter
        {
            public string key { get; set; }
            public dynamic value { get; set; }

            public sqlParameter(string key, dynamic value)
            {
                this.key = key;
                this.value = value;
            }
        }
    }
}