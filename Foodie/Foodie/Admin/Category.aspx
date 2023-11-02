<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" Codefile="Category.aspx.cs" Inherits="Foodie.Admin.Category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        
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
                                  <h4 class="sub-title">category</h4>
                                     <div>
                                                <div class="form-group">
                                                    <label>category label</label>
                                                </div>
                                                <asp:textbox id="txtName" runat="server" cssclass="form-control"
                                                  placeholder="enter category name" required></asp:textbox>
                                                <asp:hiddenfield id="hdnId"  runat="server" value="0"></asp:hiddenfield>
                                            </div>
                                        
                                        <div class="form-group">
                                            <label>category image</label>
                                            <div>
                                                <asp:fileupload id="FuCategoryImage" runat="server" 
                                                    cssclass="form-control" onchange="imagepreview(this);"/></asp:fileupload>
                                            </div>
                                        </div>
                                        <div class="form-check pl-4 ">
                                            <asp:checkbox id="cbIsActive"  runat="server" text="&nbsp; isactive"
                                                cssclass="form-check-input" ></asp:checkbox>
                                        </div>
                                        <div class="pb-5">
                                            <asp:button id="btnaddorupdate" runat="server" text="add" cssclass="btn btn-primary"
                                           OnClick="btnAddOrUpdate_Click1"  /> 
                                              &nbsp;  

                                            <asp:button id="btnclear" runat="server" text="clear" cssclass="btn btn-primary"
                                                cousesvalidation="false" />                                       
                                        </div>
                                        <div>
                                            <asp:image id="imagecategory" runat="server" CssClass="img-thumbnail" />
                                                
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
