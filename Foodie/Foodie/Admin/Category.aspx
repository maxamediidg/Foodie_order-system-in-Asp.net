<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="Foodie.Admin.Category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <script>
        /* for disappearing alert  message*/
        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            } second * 1000);
        };
    </script>
<script>
    function imagepreview(input) {
        if (input.files && input.files([0]){

            var reader = new FileReader();
            reader.onload = function (e) {
                $('#<%= imagecategory.ClientID %>').prop('src', e.target.result)
                    .width(200)
                    .height(200);
            };
            reader.readAsDataURL(input.files[0]);
        })
    }
</script>     
   <div class="pcoded-inner-content pt-0">
       
 <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"> </asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
<div class="col-sm-12">
    <div class="card">
        <div class="card-header">
        </div>
        <div class="card-block">
            <div class="row">

                                 <div class="col-sm-6 col-md-4 col-lg-4">
                                  <h4 class="sub-title">Category</h4>
                                     <div>
                                                <div class="form-group">
                                                    <label>category Name</label>
                                                <div>
                                                <asp:textbox id="txtName" runat="server" cssclass="form-control"
                                                  placeholder="enter category name" required></asp:textbox>
                                                <asp:hiddenfield id="hdnId"  runat="server" value="0"></asp:hiddenfield>
                                            </div>
                                                    </div>
                                        
                                        <div class="form-group">
                                            <label>category image</label>
                                            <div>
                                                <asp:fileupload id="FuCategoryImage" runat="server" 
                                                    cssclass="form-control" onChange="imagepreview(this);"/>
                                            </div>
                                        </div>
                                        <div class="form-check pl-4 ">
                                            <asp:checkbox id="cbIsActive"  runat="server" text="&nbsp; isactive"
                                                cssclass="form-check-input" ></asp:checkbox>
                                        </div>
                                        <div class="pb-5">
                                            <asp:button id="btnaddorupdate" runat="server" text="Add" cssclass="btn btn-primary"
                                           OnClick="btnAddOrUpdate_Click1"  /> 
                                              &nbsp;  

                                            <asp:button id="btnclear" runat="server" text="Clear" cssclass="btn btn-primary"
                                                cousesvalidation="false" OnClick="btnclear_Click" />                                       
                                        </div>
                                        <div>
                                            <asp:image id="imagecategory" runat="server" cssclass="img-thumbnail" />
                                                
               </div>                                   
         </div>
</div>

                 <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                  <h4 class="sub-title">Category List</h4>
                     <div class="card-block table-border-style">
                         <div class="table-responsive">
                             <asp:Repeater ID="rCategory"  runat="server">
                                    <HeaderTemplate>
                                     <table>
                                         <tr>
                                             <th>Name</th>
                                              <th>Image</th> 
                                             <th>IsActive</th>
                                              <th>CreateDate</th>
                                              <th>Action</th>
                                         </tr>
                                     </table>
                                 </HeaderTemplate>
                                 <ItemTemplate>
                                     <tr>
                                         <td><%#Eval("Name") %></td>
                                         <td><%#Eval("ImageUrl") %></td>
                                         <td><%#Eval("IsActive") %></td>
                                         <td><%#Eval("CreateDate") %></td>
                                         <td></td>
                                     </tr>
                                  </ItemTemplate>
                             </asp:Repeater>   
                              
                         </div>
                     </div>
                     </div>



            </div>
        </div>
    </div>
</div>
 </div>
 </div>
   </div>
        </div>
    </div>
</asp:Content>
