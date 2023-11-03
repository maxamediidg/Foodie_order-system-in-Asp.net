using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Foodie
{
    public class Connection
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        }
    }
    public class Utils
    {
        public static bool IsValidExtension(string FileName)
        {
            bool IsValid = false;
            string[] fileExtension = { ".jpg", ".png", ".jpeg" };
            for (int i = 0; i <= fileExtension.Length - 1; i++)
            {
                if (FileName.Contains(fileExtension[i]))
                {
                    IsValid = true;
                    break;
                }
            }
            return IsValid;
        }
        //setting default image if their is no image for any job
        public static string GetImageUrl(object url)
        {
            string url1 = "";
            if (string.IsNullOrEmpty(url.ToString()) || url == DBNull.Value)
            {
                url1 = "../Images/No_Image.png";
            }
            else
            {
                url1 = string.Format("../{0}", url);
            }

            return url1;
        }
    }
}