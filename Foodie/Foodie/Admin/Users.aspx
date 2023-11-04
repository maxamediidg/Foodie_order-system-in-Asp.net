<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Foodie.Admin.Users" %>
<%@ Import Namespace="Foodie" %>
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> <div class="pcoded-inner-content pt-0">
       
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

                                 
                 <div class="col-12 mobile-inputs">
                                  <h4 class="sub-title">Category List</h4>
                     <div class="card-block table-border-style">
                         <div class="table-responsive">
                             <asp:Repeater ID="rUsers"  runat="server" OnItemCommand="rUsers_ItemCommand">
                                    <HeaderTemplate>
                                     <table class="table data-table-export table-hover nowrap">
                                         <thead>
                                         <tr>
                                             <th class="table-plus">SrNo</th>
                                              <th>Full Name</th> 
                                             <th>UserName</th>
                                              <th>Email</th>
                                              <th>Join Date</th>
                                              <th class="table-nosort">Delete</th>
                                         </tr>
                                             </thead>
                                         <tbody>
                                 </HeaderTemplate>
                                 <ItemTemplate>
                                     <tr>
                                         <td class="tab-plus"><%#Eval("SrNo") %></td>                                         
                                         <td><%#Eval("Name") %></td>
                                         <td><%#Eval("UserName") %></td>
                                         <td><%#Eval("Email") %></td>
                                         <td><%#Eval("CreateDate") %></td>
                                         <td>                                            
                                             <asp:LinkButton  ID="lnkDelete" runat="server" CommandName="delete" CssClass="badge bg-danger"
                                                 CommandArgument='<%# Eval("Userid") %>' OnClientClick="return confirm('do you went to delete this User?');">
                                                 <i class="ti-trash"></i>
                                             </asp:LinkButton>
                                         </td>
                                     </tr>
                                  </ItemTemplate>
                                 <FooterTemplate>
                                     </body>
                                     </table>
                                 </FooterTemplate>
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
