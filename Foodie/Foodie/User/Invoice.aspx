<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Foodie.User.Invoice" %>
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
   
     <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                     <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>               
            </div>
        </div>
         <div class="container">
             <asp:Repeater ID="rOrderItem" runat="server">
                 <HeaderTemplate>
                     <table class="table table-responsive-sm table-bordered table-hover" id="tblInvoice">
                         <thead class="bg-dark text-white">
                             <tr>
                                 <th>Sr.NO</th>
                                  <th>Order Number</th>
                                  <th>Item Name</th>
                                  <th>Unit price</th>
                                  <th>Quantity</th>
                                  <th>Total price</th>
                             </tr>
                         </thead>
                         <tbody>
                        
                 </HeaderTemplate>
                 <ItemTemplate>
                     <tr>
                          <td><%#Eval("SrNo") %></td>
                         <td><%# Eval("OrderNo") %></td>
                         <td><%#Eval("Name") %></td>
                         <td><%# string.IsNullOrEmpty(Eval("Price").ToString())? "" : "$"+ Eval("Price") %></td>
                          <td><%#Eval("Quantity") %></td>
                          <td><%#Eval("TotalPrice") %></td>
                     </tr>
                 </ItemTemplate>
                 <FooterTemplate>
                      </tbody>
                     </table>
                 </FooterTemplate>
             </asp:Repeater>

             <div class="text-center">
                 <asp:LinkButton ID="lblDowloadInvoice" runat="server" CssClass="btn btn-info">
                    <i class="fa fa-file-pdf-o mr-2"></i> Dowload Invoice
                 </asp:LinkButton>
             </div>

         </div>
    </section>

</asp:Content>
