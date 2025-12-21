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
    <title>Product Details - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root { --mongoose: #baa987; --steelblue: #b0c4de; }
        body { background-color: var(--steelblue) !important; font-family: 'Roboto', sans-serif; }
        .card { border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); border: none; }
        .label-black { color: #000; font-weight: 700; text-transform: uppercase; font-size: 0.85rem; }
        .btn-mongoose { background-color: var(--mongoose) !important; color: white; font-weight: bold; border: none; }
        :root { --mongoose : #baa987; }
        .details-container {
            display: flex;
            padding: 50px;
            gap: 50px;
            justify-content: center;
        }
        .options-panel {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 15px;
            width: 400px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .price-box {
            font-size: 24px;
            font-weight: bold;
            color: var(--mongoose);
            margin: 20px 0;
            padding: 15px;
            background: #fff;
            border: 2px dashed var(--mongoose);
            text-align: center;
        }
        select, input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .btn-add {
            background: var(--mongoose);
            color: white;
            border: none;
            width: 100%;
            padding: 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-add:hover {
            background: #a49374; /* darker mongoose */
        }
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
                <div class="details-container">
                    <div>
                        <h2>Custom Business Card</h2>
                        <p>High-quality printing with various finishing options.</p>
                        <img src="https://via.placeholder.com/350x250" alt="Product Image" style="border-radius: 10px;">
                    </div>

                    <form action="add-to-cart" method="get">
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
                            <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
                            <div class="options-panel">
                                <h3>Customize Your Order</h3>

                                <div class="col-md-6">
                                    <label class="label-black">Service Add-Ons</label>
                                    <select class="form-select" name="addon_service">
                                        <option value="0.00">None</option>
                                        <option value="3.00">Add On Name (+RM 3.00) [cite: 6]</option>
                                        <option value="6.00">Add On Pocket (+RM 6.00) [cite: 6]</option>
                                        <option value="0.50">Add On Eyelet (+RM 0.50) [cite: 6]</option>
                                    </select>
                                </div>
                                <label>Size:</label>
                                <select id="size" name="size" class="form-select">
                                    <option value="0">Standard (85mm x 55mm)</option>
                                    <option value="5">Large (+RM5)</option>
                                </select>

                                <div class="col-md-6">
                                    <label class="label-black">Size Upgrade</label>
                                    <select class="form-select" name="size_addon">
                                        <option value="0.00">Standard Size</option>
                                        <option value="3.00">3XL (+RM 3.00) [cite: 6]</option>
                                        <option value="5.00">4XL (+RM 5.00) [cite: 6]</option>
                                        <option value="11.00">7XL (+RM 11.00) [cite: 6]</option>
                                    </select>
                                </div>
                                <label>Material:</label>
                                <select id="material" name="material" class="form-select">
                                    <option value="0">Art Card 260gsm</option>
                                    <option value="10">Premium Linen (+RM10)</option>
                                </select>

                                <div class="col-12 mt-4">
                                    <label class="label-black">Quantity</label>
                                    <input type="number" class="form-control w-25" name="qty" value="1" min="1">
                                </div>
                                <label>Quantity:</label>
                                <input type="number" id="qty" value="100" min="100" step="100">

                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-mongoose btn-lg w-100 p-3">ADD TO CART</button>
                                </div>
                            </div>
                            </div>
                    </form>
                </div>
                <div class="price-box">
                    Total Price: RM <span id="totalPrice">10.00</span>
                </div>

                <button class="btn-add">Add to Cart</button>
            </div>
        </div>
    </div>
</section>



<script>

    function updatePrice() {
        let base = 10.00;
        let size = parseFloat(document.getElementById('size').value);
        let material = parseFloat(document.getElementById('material').value);
        let qty = parseInt(document.getElementById('qty').value) / 100;

        let finalPrice = (base + size + material) * qty;
        document.getElementById('totalPrice').innerText = finalPrice.toFixed(2);
    }

    document.getElementById('size').addEventListener('change', updatePrice);
    document.getElementById('material').addEventListener('change', updatePrice);
    document.getElementById('qty').addEventListener('input', updatePrice);
</script>

</body>
</html>
