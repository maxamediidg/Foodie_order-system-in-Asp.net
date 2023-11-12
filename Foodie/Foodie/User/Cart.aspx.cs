using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        decimal grandTotal = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if(Session["Userid"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else{
                    getCartItems();

                }
            }
        }

        void getCartItems()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");       
            cmd.Parameters.AddWithValue("@UserId", Session["Userid"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCartItem.DataSource = dt;
            if (dt.Rows.Count == 0)
            {
                rCartItem.FooterTemplate = null;
                rCartItem.FooterTemplate = new CustomTemplate(ListItemType.Footer);
            }
            rCartItem.DataBind(); 

        }
        protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Utils utils = new Utils();
            if (e.CommandName == "remove")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Cart_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["Userid"]);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    getCartItems();
                    //Cart Count
                    Session["CartCount"] = utils.CartCount(Convert.ToInt32(Session["Userid"]));
                }
                catch (Exception ex)
                {
                    System.Web.HttpContext.Current.Response.Write("<script>alert('error -  " + ex.Message + "');<script>");
                }
                finally
                {
                    con.Close();
                }
            }
         
            if (e.CommandName == "updateCart")
            {
                bool isCartUpdated = false;
                for (int item = 0; item < rCartItem.Items.Count; item ++)
                {
                    if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox quantity = rCartItem.Items[item].FindControl("txtQuantity") as TextBox;
                        HiddenField _productId = rCartItem.Items[item].FindControl("hdnProductId") as HiddenField;
                        HiddenField _quantity = rCartItem.Items[item].FindControl("hdnQuantity") as HiddenField;
                        int quantityFromCart = Convert.ToInt32(quantity.Text);
                        int productId = Convert.ToInt32(_productId.Value);
                        int quanttiyFromDB = Convert.ToInt32(_quantity.Value);
                        bool isTrue = false;
                        int UpdatedQuantity = 1;
                        if (quantityFromCart > quanttiyFromDB)
                        {
                            UpdatedQuantity = quantityFromCart;
                            isTrue = true;
                        }
                        else if (quantityFromCart < quanttiyFromDB)
                        {
                            UpdatedQuantity = quantityFromCart;
                            isTrue = true;
                        }
                        if (isTrue)
                        {
                            // Update cart item quantity in DB
                            isCartUpdated = utils.updateCartQuantity(UpdatedQuantity, productId, Convert.ToInt32(Session["Userid"]));
                        }
                    }
                }
                getCartItems();
            
            }
            if(e.CommandName == "checkout")
            {
                bool isTrue = false;
                string pName = string.Empty;
                // first will check item qauntity
                for (int item = 0; item < rCartItem.Items.Count; item++)
                {
                    if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                    {
                        HiddenField _productId = rCartItem.Items[item].FindControl("hdnProductId") as HiddenField;
                        HiddenField _cartquantity = rCartItem.Items[item].FindControl("hdnQuantity") as HiddenField;
                        HiddenField _productquantity = rCartItem.Items[item].FindControl("hdnPrdQuantity") as HiddenField;
                        Label productName = rCartItem.Items[item].FindControl("lblName") as Label;
                        int productId = Convert.ToInt32(_productId.Value);
                        int CardQuantity = Convert.ToInt32(_cartquantity.Value);
                        int ProductQuantity = Convert.ToInt32(_productquantity.Value);                 
                        if (ProductQuantity > CardQuantity && ProductQuantity > 2)
                        {                       
                            isTrue = true;
                        }
                        else
                        {
                            isTrue = false;
                            pName = productName.Text.ToString();
                            break;
                        }                      
                    }
                }
                if (isTrue)
                {
                    Response.Redirect("Payment.aspx");
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "item <b>'" + pName +"' </b> is out of stock:(";
                    lblmsg.CssClass = "alert alert-warning";

                }
            }
        }

        protected void rCartItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label totalPrice = e.Item.FindControl("lblTotalPrice") as Label;
                Label ProductPrice = e.Item.FindControl("lblPrice") as Label;
                TextBox quantity = e.Item.FindControl("txtQuantity") as TextBox;
                decimal calTotalPrice = Convert.ToDecimal(ProductPrice.Text) * Convert.ToDecimal(quantity.Text);
                totalPrice.Text = calTotalPrice.ToString();
                grandTotal += calTotalPrice;
            }
            Session["grandTotalPrice"] = grandTotal;
        }
        private sealed class CustomTemplate : ITemplate
        {
            private ListItemType listItemType { get; set; }

            public CustomTemplate(ListItemType type)
            {
                listItemType = type;
            }
            public void InstantiateIn(Control container)
            {
                if (listItemType == ListItemType.Footer)
                {
                    var footer = new LiteralControl("<tr><td colspan='5'><b>your cart is empty.</b><a href='Menu.aspx' class='badge badge-info ml-2'> Continue shopping</a></td></tr></body></table>");
                    container.Controls.Add(footer);
                }
            }
        }
    }

}