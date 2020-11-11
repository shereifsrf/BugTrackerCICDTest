using System;
using System.Collections.Generic;

namespace Softmatic.Model
{
    public class Bug
    {
        public class BugDetails
        {
            public int bugId { get; set; }
            public string title { get; set; }
            public string description { get; set; }
            public string category { get; set; }
            public string status { get; set; }
            public DateTime createdOn { get; set; }
            public string createdBy { get; set; }
            public int createdByUserId { get; set; }
            public List<BugGallery> bugGalleryList { get; set; }
        }

        public class BugList
        {
            public List<BugDetails> bugList { get; set; }
            public int bugListCount { get; set; }
        }

        public class BugComment
        {
            public int commentId { get; set; }
            public string content { get; set; }
            public DateTime createdOn { get; set; }
            public string createdBy { get; set; }
            public int createdByUserId { get; set; }
        }

        public class BugCommentList
        {
            public List<BugComment> bugCommentList { get; set; }
            public int bugCommentListCount { get; set; }
        }

        public class BugGallery
        {
            public int bugId { get; set; }
            public int galleryId { get; set; }
            public string srcPath { get; set; }
        }

    }
}