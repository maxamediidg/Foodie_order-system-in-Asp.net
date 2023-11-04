<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Foodie.User.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script>
        /* for disappearing alert  message*/
        window.onload = function () {
            var second = 5;
            settimeout(function () {
                document.getelementbyid("<%=lblMsg.ClientID%>").style.display = "none";
            } second * 1000);
        };
    </script>
<script>
    function imagepreview(input) {
        if (input.files && input.files([0]){

            var reader = new filereader();
            reader.onload = function (e) {
                $('#<%= ImgUser.ClientID %>').prop('src', e.target.result)
                    .width(200)
                    .height(200);
            };
            reader.readasdataurl(input.files[0]);
        })
    }
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                   <asp:Label ID="lblMsg" runat="server" Visible="false"> </asp:Label>    
                </div>
         <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>User Registration</h2>"> </asp:Label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" 
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtName">
                               </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" errormessage="Name must be in characters only"
                                  ForeColor="red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$" 
                                ControlToValidate="txtName"></asp:RegularExpressionValidator>
                                                        <asp:TextBox ID="txtName" CssClass="form-control" placeholder="Enter Full Name"
                                ToolTip="Full Name" runat="server"></asp:TextBox>
                        </div>

                         <div>                           
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required" 
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtUsername">
                               </asp:RequiredFieldValidator>    
                              <asp:TextBox ID="txtUsername" CssClass="form-control" placeholder="Enter Username"
                                ToolTip="Username" runat="server"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required" 
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtEmail">
                               </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Enter Email"
                                ToolTip="Email" runat="server" TextMode="Email"></asp:TextBox>
                           
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile No. is required" 
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtMobile">
                               </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="Mobile NO. have 10 digits"
                                  ForeColor="red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{10}$" 
                                ControlToValidate="txtMobile"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtMobile" CssClass="form-control" placeholder="Mobile Number"
                                ToolTip="Mobile Number" runat="server" TextMode="Number"></asp:TextBox>
                        </div>


                    </div>
                </div>

               
                <div class="col-md-6">
                    <div class="form_container">

                         <div>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is required" ControlToValidate="txtAddress"
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true">
                               </asp:RequiredFieldValidator>                            
                            <asp:TextBox ID="txtAddress" CssClass="form-control" placeholder="Enter Address"
                                ToolTip="Address" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </div>

                         <div>
                            <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Post/Zip Code is required" 
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPostCode"></asp:RequiredFieldValidator>  
                               <asp:RegularExpressionValidator ID="revPostCode" runat="server" ErrorMessage="Post/Zip Code have 6 digits"
                                  ForeColor="red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{6}$" 
                                ControlToValidate="txtPostCode"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtPostCode" CssClass="form-control" placeholder="Enter Post/Zip Code"
                                ToolTip="Post/Zip Code" runat="server" TextMode="Number"></asp:TextBox>
                        </div>

                        <div>
                            <asp:FileUpload ID="FuUserImage" runat="server" CssClass="form-control" 
                                ToolTip="User Image" onchange="ImagePreview(this);"/>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required" 
                                ForeColor="red" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPassword">
                               </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Enter Password"
                                ToolTip="Password" runat="server" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="row pl-4">
                    <div class="btn_box">
                        <asp:Button ID="btnRegister" runat="server" Text="Register" 
                            CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" OnClick="btnRegister_Click" />
                        <asp:Label ID="lblAlreadyUser" runat="server" 
                            CssClass="pl-3 text-black-100" 
                            Text="Already Registered ? <a href='Login.aspx' class='badge badge-info'>Login Here...</a>"></asp:Label> 
                    </div>
                </div>

                <div class="row p-5">
                    <div style="align-items:center">
                        <asp:Image ID="ImgUser" runat="server" CssClass="img-thumbnail" />
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
