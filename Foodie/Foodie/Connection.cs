using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
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
        public bool updateCartQuantity(int quantity, int productId, int UserId)
        {
            bool isUpdated = false;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "UPDATE");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@Quantity", quantity);
            cmd.Parameters.AddWithValue("@UserId", UserId);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                isUpdated = true;
            }
            catch (Exception ex)
            {
                isUpdated = false;
                System.Web.HttpContext.Current.Response.Write("<script>alert('error -  " + ex.Message + "');<script>");
            }
            finally
            {
                con.Close();
            }
            return isUpdated;

        } 
        public int CartCount(int UserId)
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@UserId", UserId);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt.Rows.Count;
        }
        public static string GetUniqueId()
        {
            Guid guid = Guid.NewGuid();
            string UniqueId = guid.ToString();
            return UniqueId;
        }
    }
}