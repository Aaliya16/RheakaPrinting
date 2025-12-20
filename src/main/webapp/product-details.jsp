<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String pName = "Printing Service";
    String pDesc = "High-quality custom printing solutions.";

    if (id != null) {
        if (id.equals("14")) { pName = "Apron Custom"; pDesc = "Professional kitchen wear in various materials."; }
        else if (id.equals("4")) { pName = "Banner & Bunting"; pDesc = "Outdoor and indoor large format printing."; }
        else if (id.equals("15")) { pName = "Acrylic Clear"; pDesc = "3mm high-quality laser cut acrylic."; }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rheaka Design - <%= pName %></title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <style>
        :root { --mongoose: #baa987; --steelblue: #b0c4de; }
        body { background-color: var(--steelblue) !important; font-family: 'Roboto', sans-serif; }
        .card { border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); border: none; }
        .label-black { color: #000; font-weight: 700; text-transform: uppercase; font-size: 0.85rem; }
        .btn-mongoose { background-color: var(--mongoose) !important; color: white; font-weight: bold; border: none; }
    </style>
</head>
<body>

<section class="container py-5">
    <div class="row">
        <div class="col-lg-5">
            <div class="card p-2">
                <img src="assets/img/product_single_10.jpg" class="img-fluid rounded" alt="Product">
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4">
                <h1 class="h2 text-dark"><%= pName %></h1>
                <p class="text-muted"><%= pDesc %></p>
                <hr>

                <form action="cart.jsp" method="POST">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="label-black">Select Specific Type</label>
                            <select class="form-select" name="base_item">
                                <% if (id != null && id.equals("14")) { %>
                                <option value="16.00">Apron 1 Tone (Blue/Red/Brown) - RM 16.00 [cite: 8]</option>
                                <option value="17.00">Apron 2 Tone (Khaki/Black) - RM 17.00 [cite: 8]</option>
                                <option value="25.00">Apron Denim - RM 25.00 [cite: 8]</option>
                                <option value="30.00">Apron Premium 2 Button - RM 30.00 [cite: 10]</option>
                                <% } else if (id != null && id.equals("4")) { %>
                                <option value="90.00">Banner 10' x 3' - RM 90.00 [cite: 10]</option>
                                <option value="120.00">Banner 10' x 4' - RM 120.00 [cite: 10]</option>
                                <option value="264.00">Backdrop 11' x 8' - RM 264.00 [cite: 10]</option>
                                <% } else { %>
                                <option value="47.00">3mm Acrylic Clear - RM 47.00 [cite: 6]</option>
                                <option value="35.00">3mm High Impact - RM 35.00 [cite: 6]</option>
                                <% } %>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="label-black">Service Add-Ons</label>
                            <select class="form-select" name="addon_service">
                                <option value="0.00">None</option>
                                <option value="3.00">Add On Name (+RM 3.00) [cite: 6]</option>
                                <option value="6.00">Add On Pocket (+RM 6.00) [cite: 6]</option>
                                <option value="0.50">Add On Eyelet (+RM 0.50) [cite: 6]</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="label-black">Size Upgrade</label>
                            <select class="form-select" name="size_addon">
                                <option value="0.00">Standard Size</option>
                                <option value="3.00">3XL (+RM 3.00) [cite: 6]</option>
                                <option value="5.00">4XL (+RM 5.00) [cite: 6]</option>
                                <option value="11.00">7XL (+RM 11.00) [cite: 6]</option>
                            </select>
                        </div>

                        <div class="col-12 mt-4">
                            <label class="label-black">Quantity</label>
                            <input type="number" class="form-control w-25" name="qty" value="1" min="1">
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-mongoose btn-lg w-100 p-3">ADD TO CART</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

</body>
</html>