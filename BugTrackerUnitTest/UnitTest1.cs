using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Softmatic.pages;
using static Softmatic.Model.Common;

namespace BugTrackerUnitTest
{
    [TestClass]
    public class UnitTest1
    {
        private returnResult actual = new returnResult();

        [TestMethod]
        public void loginRegisteringAdmin()
        {
            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestAdm@gmail.com", "unitTest", "admin01", "adm", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void loginRegisteringReviewer()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestReviewer@gmail.com", "unitTest", "Reveiwer01", "rvr", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void loginRegisteringTriager()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestriager@gmail.com", "unitTest", "riager01", "tgi", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void loginRegisteringReporter()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestReporter@gmail.com", "unitTest", "Reporter01", "rpt", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        //[TestMethod]
        //public void loginRegisteringDeveloper()
        //{
        //    actual = null;

        //    returnResult expected = new returnResult(true, "Add user successfully");

        //    //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

        //    actual = login.addNewUser("unitTestDeveloper@gmail.com", "unitTest", "Developer01", "dvp", "Unittest1#");

        //    Assert.AreEqual<returnResult>(expected, actual);
        //}

        //[TestMethod]
        //public void loginLoggingUser()
        //{
        //    returnResult expected = new returnResult(true, "Add user successfully");

        //    //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

        //    actual = login.addNewUser("unitTestAdm@gmail.com", "unitTest", "admin01", "adm", "Unittest1#");

        //    Assert.AreEqual<returnResult>(expected, actual);
        //}
    }
}
