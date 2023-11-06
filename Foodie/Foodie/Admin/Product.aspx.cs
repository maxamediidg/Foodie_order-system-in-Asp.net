using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.Admin
{
    public partial class Product : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Product";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    getrProducts();
                }
                getrProducts();
            }
            lblMsg.Visible = false;
        }

        protected void btnaddorupdate_Click(object sender, EventArgs e)
        {
            String actionName = String.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int ProductId = Convert.ToInt32(hdnid.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", ProductId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@ProductId", ProductId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text.Trim());
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
            cmd.Parameters.AddWithValue("@Category", ddlCategories.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbisactive.Checked);
            if (fuProductimage.HasFile)
            {
                if (Utils.IsValidExtension(fuProductimage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuProductimage.FileName);
                    imagePath = "Images/Product/" + obj.ToString() + fileExtension;
                    fuProductimage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }

                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "please select .jpg, .jpeg, or .png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }
            }
            else
            {
                isValidToExecute = true;
            }
            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = ProductId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product " + actionName + "  successfull!";
                    lblMsg.CssClass = "alert alert-success";
                    getrProducts();
                    clear();
                }

                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "error " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void getrProducts()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProduct.DataSource = dt;
            rProduct.DataBind();
        }

        private void clear()
        {
            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtPrice.Text = string.Empty;
            ddlCategories.ClearSelection();
            cbisactive.Checked = false;
            hdnid.Value = "0";
            btnaddorupdate.Text = "Add";
            imgProduct.ImageUrl = string.Empty;
        }

        protected void btnclear_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("Product_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtDescription.Text = dt.Rows[0]["Description"].ToString();
                txtPrice.Text = dt.Rows[0]["Price"].ToString();
                txtQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                ddlCategories.SelectedValue = dt.Rows[0]["CategoryId"].ToString();
                cbisactive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imgProduct.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "../Images/No_Image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                imgProduct.Height = 200;
                imgProduct.Width = 200;
                hdnid.Value = dt.Rows[0]["ProductId"].ToString();
                btnaddorupdate.Text = "Update";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                //con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Product_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Product deleted successfullty";
                    lblMsg.CssClass = "alert alert-success";
                    getrProducts();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                if (lblIsActive.Text == "True")
                {
                    lblIsActive.Text = "Active";
                    lblIsActive.CssClass = "badge badge-success";
                }
                else
                {
                    lblIsActive.Text = "In-Active";
                    lblIsActive.CssClass = "badge badge-danger";
                }
                if(Convert.ToInt32(lblQuantity.Text) <=5)
                {
                    lblQuantity.CssClass = "badge badge-danger";
                    lblQuantity.ToolTip = "Item about to be 'Out of Stock!'";
                }
            }
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}