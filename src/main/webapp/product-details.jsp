<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String pName = "Printing Service";
    String pDesc = "High-quality custom printing solutions.";

    // Product mapping by ID
    if (id != null) {
        if (id.equals("14")) {
            pName = "Apron Custom";
            pDesc = "Professional kitchen wear."; }
        else if (id.equals("4")) {
            pName = "Banner & Bunting";
            pDesc = "Large format printing."; }
        else if (id.equals("3")) {
            pName = "Apparel Printing";
            pDesc = "Custom T-Shirts (XS - 7XL)."; }
        else if (id.equals("15")) {
            pName = "Acrylic Clear";
            pDesc = "3mm high-quality laser cut."; }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rheaka Design - <%= pName %></title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        :root { --mongoose: #baa987; --steelblue: #b0c4de; }
        body { background-color: var(--steelblue) !important; font-family: 'Segoe UI', sans-serif; }
        .card { border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: none; }
        .label-black { color: #000; font-weight: 700; text-transform: uppercase; font-size: 0.8rem; margin-top: 15px; display: block; }
        .price-box { font-size: 26px; font-weight: bold; color: var(--mongoose); margin: 20px 0; padding: 15px; background: #fff; border: 2px dashed var(--mongoose); text-align: center; border-radius: 10px; }
        .btn-add { background: var(--mongoose); color: white; border: none; width: 100%; padding: 15px; border-radius: 10px; font-weight: bold; }
    </style>
</head>

<body>
<%@ include file="header.jsp" %>
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

                <form action="add-to-cart" method="post" id="addToCartForm">
                    <input type="hidden" name="id" value="<%= id %>">

                    <input type="hidden" name="variation_name" id="hiddenVariationName" value="">
                    <input type="hidden" name="addon_name" id="hiddenAddonName" value="">
                    <input type="hidden" name="price" id="hiddenUnitPrice" value="">

                    <div class="options-panel">
                        <label class="label-black">1. Product Type </label>
                        <select class="form-select" id="base_item">
                            <% if ("14".equals(id)) { %>
                            <option value="16.00">Apron 1 Tone - RM 16.00</option>
                            <option value="17.00">Apron 2 Tone - RM 17.00</option>
                            <option value="25.00">Apron Denim - RM 25.00</option>
                            <% } else if ("3".equals(id)) { %>
                            <option value="11.90">Quick Dry - RM 11.90</option>
                            <option value="16.00">Siro Cotton - RM 16.00</option>
                            <% } else { %>
                            <option value="47.00">3mm Acrylic Clear - RM 47.00</option>
                            <option value="35.00">3mm High Impact - RM 35.00</option>
                            <% } %>
                        </select>

                        <label class="label-black">2. Select Size</label>
                        <select class="form-select" id="size_base">
                            <option value="0">XS</option>
                            <option value="0">S</option>
                            <option value="0">M</option>
                            <option value="0">L</option>
                            <option value="0">XL</option>
                            <option value="0">2XL</option>
                        </select>

                        <label class="label-black">3. Additional Services </label>
                        <select class="form-select" id="addon_service">
                            <option value="0.00">None</option>
                            <option value="3.00">Cetak Nama/Nombor (+RM 3.00)</option>
                            <option value="6.00">Tambah Poket (+RM 6.00)</option>
                        </select>

                            <label class="label-black">4. Oversize Upgrade</label>
                        <select class="form-select" id="size_addon">
                            <option value="0.00">Saiz Standard (XS-2XL)</option>
                            <option value="3.00">3XL (+RM 3.00)</option>
                            <option value="11.00">7XL (+RM 11.00)</option>
                        </select>

                        <label class="label-black">4.Upload Design (Optional) </label>
                        <input type="file" class="form-control" id="design_file">

                        <div class="mt-3">
                            <label class="label-black">5. Quantity</label>
                            <input type="number" class="form-control" name="quantity" id="quantity" value="1" min="1">
                        </div>

                        <div class="price-box">
                            Total: RM <span id="totalPrice">0.00</span>
                        </div>

                        <button type="submit" class="btn-add">Add to Cart</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    function updatePrice() {
        let baseEl = document.getElementById('base_item');
        let addonEl = document.getElementById('addon_service');
        let sizeEl = document.getElementById('size_addon');
        let qtyEl = document.getElementById('quantity');

        let basePrice = parseFloat(baseEl.value) || 0;
        let addonPrice = parseFloat(addonEl.value) || 0;
        let sizePrice = parseFloat(sizeEl.value) || 0;
        let quantity = parseInt(qtyEl.value) || 1;

        document.getElementById('hiddenVariationName').value = baseEl.options[baseEl.selectedIndex].text;
        document.getElementById('hiddenAddonName').value = addonEl.options[addonEl.selectedIndex].text;

        let unitPrice = basePrice + addonPrice + sizePrice;
        let total = unitPrice * quantity;

        document.getElementById('totalPrice').innerText = total.toFixed(2);
        document.getElementById('hiddenUnitPrice').value = total.toFixed(2);
    }

    document.querySelectorAll('select, input').forEach(el => {
        el.addEventListener('change', updatePrice);
        el.addEventListener('input', updatePrice);
    });

    window.addEventListener('DOMContentLoaded', updatePrice);

    document.getElementById('addToCartForm').addEventListener('submit', function(e) {
        let unitPrice = document.getElementById('hiddenUnitPrice').value;
        if (!unitPrice || unitPrice === '0.00') {
            e.preventDefault();
            alert('Sila pilih variasi produk terlebih dahulu!');
        }
    });
</script>
<%@ include file="footer.jsp" %>
</body>
</html>