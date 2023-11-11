<%@ page import="com.example.mydemoshop.connection.DbCon" %>
<%@ page import="com.example.mydemoshop.models.User" %>
<%@ page import="com.example.mydemoshop.models.Product" %>
<%@ page import="com.example.mydemoshop.dao.ProductDao" %>
<%@ page import="com.example.mydemoshop.models.Cart" %>
<%@ page import="java.util.*" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }
    ProductDao pd = new ProductDao(DbCon.getConnection());
    List<Product> products = pd.getAllProducts();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/includes/header.jsp"%>
    <title>E-Commerce Cart</title>
</head>
<body>
<%@include file="/includes/navbar.jsp"%>

<div class="container">
    <div class="card-header my-3">All Products</div>
    <div class="row">
        <%
            if (!products.isEmpty()) {
                for (Product p : products) {
        %>
        <div class="col-md-3 my-3">
            <div class="card w-100">
                <img class="card-img-top" src="product_img/<%=p.getImage() %>"
                     alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title"><%=p.getName() %></h5>
                    <h6 class="price">Price: $<%=p.getPrice() %></h6>
                    <h6 class="category">Category: <%=p.getCategory() %></h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a> <a
                            class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
                out.println("There is no proucts");
            }
        %>

    </div>
</div>

<%@include file="/includes/footer.jsp"%>
</body>
</html>