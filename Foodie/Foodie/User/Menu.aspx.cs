using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Foodie.User
{

    public partial class Menu : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                getCategories();
                getrProducts();
            }
        }
        private void getCategories()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCategory.DataSource = dt;
            rCategory.DataBind();
        }

        private void getrProducts()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVEPROD");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProducts.DataSource = dt;
            rProducts.DataBind();
        }

        protected void rProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Session["Userid"] != null)
            {
                bool isCartItemUpdated = false;
                int i= isItemExistInCart(Convert.ToInt32(e.CommandArgument));
                if(i == 0)
              {
                    //adding new item in cart
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Cart_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@Quantity", 1);
                    cmd.Parameters.AddWithValue("@UserId", Session["Userid"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        Response.Write("<script>alert('error -  " + ex.Message+ "');<script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                else
                {
                    //adding exist item to cart
                    Utils utils = new Utils();
                    isCartItemUpdated = utils.updateCartQuantity(i + 1,Convert.ToInt32(e.CommandArgument),
                        Convert.ToInt32(Session["Userid"]));
                   
                }
                lblmsg.Visible = true;
                lblmsg.Text = "item added successfully in your cart!";
                lblmsg.CssClass = "alert alert-success";
                Response.AddHeader("REFRESH", "1;URL=Cart.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        int isItemExistInCart(int ProductId)
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", ProductId);
            cmd.Parameters.AddWithValue("@UserId", Session["Userid"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            int Quantity = 0;
            if(dt.Rows.Count > 0)
            {
                Quantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);
            }
            return Quantity;
        }

        //public string LowerCase(object obj)
        //{
        //    return obj.ToString().ToLower();
        //}

    }
}