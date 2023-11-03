<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Foodie.Admin.Product" %>
<%@ Import Namespace="Foodie" %>
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
                $('#<%= imgProduct.ClientID %>').prop('src', e.target.result)
                    .width(200)
                    .height(200);
            };
            reader.readasdataurl(input.files[0]);
        })
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="pcoded-inner-content pt-0">
       
 <div class="align-align-self-end">
            <asp:label id="lblMsg" runat="server" visible="false"> </asp:label>
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
                                  <h4 class="sub-title">Product</h4>
                                     <div>
                                                <div class="form-group">
                                                    <label>product name</label>
                                                <div>
                                                <asp:textbox id="txtName" runat="server" cssclass="form-control"
                                                  placeholder="enter product name" ></asp:textbox>
                                                    <asp:requiredfieldvalidator id="requiredfieldvalidator1" runat="server"
                                                        errormessage="name is required" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="txtname">
                                                    </asp:requiredfieldvalidator>
                                                <asp:hiddenfield id="hdnid"   runat="server" value="0"></asp:hiddenfield>
                                            </div>
                                        </div>
                                             <div class="form-group">
                                              <label>product Description</label>
                                                <div>
                                                <asp:textbox id="txtDescription" runat="server" cssclass="form-control"
                                                  placeholder="enter product Description" TextMode="MultiLine" ></asp:textbox>
                                                    <asp:requiredfieldvalidator id="requiredfieldvalidator2" runat="server"
                                                        errormessage="Description is required" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="txtDescription">
                                                    </asp:requiredfieldvalidator>
                                            </div>
                                            </div>
                                          <div class="form-group">
                                                    <label>product Price(SH)</label>
                                                <div>
                                                <asp:textbox id="txtPrice" runat="server" cssclass="form-control"
                                                  placeholder="enter product Price" ></asp:textbox>
                                                    <asp:requiredfieldvalidator id="requiredfieldvalidator3" runat="server"
                                                        errormessage="Price is required" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="txtPrice">
                                                    </asp:requiredfieldvalidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                        ErrorMessage="Price must be in decimal" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="txtPrice" ValidationExpression="^\d{0,8}(\.\d{1,4})?$"
                                                        ></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        
                                         <div class="form-group">
                                                    <label>product Quantity(SH)</label>
                                                <div>
                                                <asp:textbox id="txtQuantity" runat="server" cssclass="form-control"
                                                  placeholder="enter product Quantity" ></asp:textbox>
                                                    <asp:requiredfieldvalidator id="requiredfieldvalidator4" runat="server"
                                                        errormessage="Quantity is required" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="txtQuantity">
                                                    </asp:requiredfieldvalidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                                        ErrorMessage="Quantity must non negative" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="txtQuantity" ValidationExpression="^([1-9]\d*|0)$"
                                                        ></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        

                                        <div class="form-group">
                                            <label>Product image</label>
                                            <div>
                                                <asp:fileupload id="fuProductimage" runat="server" 
                                                    cssclass="form-control" onchange="imagepreview(this);"/>
                                            </div>
                                        </div>

                                          <div class="form-group">
                                              <label>product Category</label>
                                                <div>    
                                                    <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control"
                                                        DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId" AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Select Category</asp:ListItem>
                                                                               </asp:DropDownList>

                                                    <asp:requiredfieldvalidator id="txtddlCategories" runat="server"
                                                        errormessage="Category is required" forecolor="red" display="dynamic" 
                                                        setfocusonerror="true" controltovalidate="ddlCategories" InitialValue="0">
                                                    </asp:requiredfieldvalidator>
                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT [CategoryId], [Name] FROM [Category]"></asp:SqlDataSource>
                                            </div>
                                            </div>

                                        <div class="form-check pl-4 ">
                                            <asp:checkbox id="cbisactive"  runat="server" text="&nbsp; isactive"
                                                cssclass="form-check-input" ></asp:checkbox>
                                        </div>
                                        <div class="pb-5">
                                            <asp:button id="btnaddorupdate" runat="server" text="add" cssclass="btn btn-primary" 
                                               OnClick="btnaddorupdate_Click" />    
                                              &nbsp;  

                                            <asp:button id="btnclear" runat="server" text="clear" cssclass="btn btn-primary" 
                                               OnClick="btnclear_Click" />                                                                     
                                        </div>
                                        <div>
                                            <asp:image id="imgProduct" runat="server" cssclass="img-thumbnail" />                                                
               </div>                                   
         </div>
</div>

                 <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                  <h4 class="sub-title">category list</h4>
                     <div class="card-block table-border-style">
                         <div class="table-responsive">
                             <asp:repeater id="rProduct"  runat="server" OnItemCommand="rProduct_ItemCommand" OnItemDataBound="rProduct_ItemDataBound">
                                    <headertemplate>
                                     <table class="table data-table-export table-hover nowrap">
                                         <thead>
                                         <tr>
                                             <th class="table-plus">name</th>
                                              <th>image</th>
                                              <th>Price(SH)</th> 
                                              <th>Qty</th>
                                              <th>Category</th> 
                                             <th>isactive</th>
                                              <th>Description</th>
                                              <th>createdate</th>
                                              <th class="table-nosort">action</th>
                                         </tr>
                                             </thead>
                                         <tbody>
                                 </headertemplate>
                                <ItemTemplate>
                                     <tr>
                                         <td class="tab-plus"><%#Eval("Name") %></td>
                                         <td>
                                             <img alt="" width="42px" src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" />
                                         </td>

                                          <td><%#Eval("Price") %></td>

                                          <td>
                                             <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                         </td>

                                         <td><%#Eval("CategoryName") %></td>

                                         <td>
                                             <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                         </td>

                                         <td><%#Eval("Description") %></td>

                                         <td><%#Eval("CreateDate") %></td>

                                         <td>
                                             <asp:LinkButton ID="lnkEdit" Text="Edit" CssClass="badge badge-primary" runat="server"
                                               CommandArgument='<%# Eval("ProductId") %>' CommandName="edit" CausesValidation="false"> <i class="ti-pencil"></i>                                            
                                                 </asp:LinkButton>
                                             <asp:LinkButton  ID="lnkDelete" runat="server" CommandName="delete" CssClass="badge bg-danger"
                                                 CommandArgument='<%# Eval("ProductId") %>' OnClientClick="return confirm('do you went to delete this product?'); " CausesValidation="false">
                                                 <i class="ti-trash"></i>
                                             </asp:LinkButton>
                                         </td>
                                     </tr>
                                  </ItemTemplate>
                                 <footertemplate>
                                     </body>
                                     </table>
                                 </footertemplate>
                             </asp:repeater>   
                              
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
