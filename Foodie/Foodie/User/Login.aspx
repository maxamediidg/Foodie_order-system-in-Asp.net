<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Foodie.User.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script>
        /* for disappearing alert  message*/
        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            } second * 1000);
        };
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
                <h2>Login</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                       <img id="userLogin" src="../Images/login.jpg" alt="" class="img-thumbnail" ></img>
                    </div>
                </div>

                 <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="username is required" ControlToValidate="txtUsername" 
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small">
                            </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password is required" 
                                ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small">
                            </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="btn_box">
                            <asp:Button ID="btnlogin" runat="server" Text="Login" 
                                CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                                OnClick="btnlogin_Click" />
                            <span class="pl-3 text-info">New User?<a href="Registration.aspx" 
                                class="badge badge-info">Register here..</a></span>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
