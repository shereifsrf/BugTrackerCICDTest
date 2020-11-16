using System;
using System.Collections.Generic;
using System.Web;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Softmatic.pages;
using static Softmatic.Model.Common;

namespace BugTrackerUnitTest
{
    [TestClass]
    public class UnitTest1
    {
        private returnResult actual = new returnResult();

        [TestMethod]
        public void a1LoginRegisteringAdmin()
        {
            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestAdm@gmail.com", "unitTest", "admin01", "adm", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void a2LoginRegisteringReviewer()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestReviewer@gmail.com", "unitTest", "Reveiwer01", "rvr", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void a3LoginRegisteringTriager()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestriager@gmail.com", "unitTest", "riager01", "tgi", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void a4LoginRegisteringReporter()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestReporter@gmail.com", "unitTest", "Reporter01", "rpt", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        [TestMethod]
        public void a5LoginRegisteringDeveloper()
        {
            actual = null;

            returnResult expected = new returnResult(true, "Add user successfully");

            //returnResult expected = new returnResult(false, "This email has been used, please login / resgister with another email");

            actual = login.addNewUser("unitTestDeveloper@gmail.com", "unitTest", "Developer01", "dvp", "Unittest1#");

            Assert.AreEqual<returnResult>(expected, actual);
        }

        //[TestMethod]
        //public void a6LogginInAndCeateBug()
        //{
        //    actual = null;

        //    returnResult expected = new returnResult(true, "Login successfully");


        //    //var mockSession1 = new Mock<System.Web.SessionState.HttpSessionState>();
        //    //var mockSession2 = new Mock<System.Web.SessionState.HttpSessionState>();
        //    //var mockDataUser = new Mock<Softmatic.Data.ITesting>();
        //    //mockSession1.SetupGet(s => s["userId"]).Returns(""); //somevalue
        //    //mockSession2.SetupGet(s => s["userRole"]).Returns(""); //somevalue
        //    //mockDataUser.Setup(p => HttpContext.Current.Session).Returns(mockSession1.Object);
        //    //mockDataUser.Setup(p => HttpContext.Current.Session).Returns(mockSession2.Object);



        //    actual = login.userLogin("unitTestAdm@gmail.com", "Unittest1#");


        //    Assert.AreEqual<returnResult>(expected, actual);
        //}


        [TestMethod]
        public void aaaDeleteUnitTestUsers()
        {

            List<Softmatic.Model.Common.sqlParameter> parameters = new List<Softmatic.Model.Common.sqlParameter>();

            var reader = Softmatic.Data.Common.execSQLReader("delete from tbl_user where email in ('unitTestAdm@gmail.com', 'unitTestDeveloper@gmail.com', 'unitTestReporter@gmail.com', 'unitTestReviewer@gmail.com', 'unitTestriager@gmail.com')", parameters);

            reader.Read();
            reader.Close();
        }

    }
}
