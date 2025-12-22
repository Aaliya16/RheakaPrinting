<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String pName = "Printing Service";
    String pDesc = "High-quality custom printing solutions.";

    if (id != null) {
        if (id.equals("14")) {
            pName = "Apron Custom";
            pDesc = "Professional kitchen wear - Denim, Cotton & 2-Tone options.";
        } else if (id.equals("4")) {
            pName = "Banner & Bunting";
            pDesc = "Large format printing for events and promotions.";
        } else if (id.equals("3")) {
            pName = "Apparel Printing";
            pDesc = "Custom T-Shirts with DTF or Sublimation printing.";
        } else if (id.equals("15")) {
            pName = "Acrylic Clear";
            pDesc = "3mm Laser-cut acrylic and High Impact boards.";
        }
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
        .card { border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .label-black { color: #000; font-weight: 700; text-transform: uppercase; font-size: 0.8rem; margin-top: 15px; display: block; }
        .price-box {
            font-size: 28px; font-weight: bold; color: var(--mongoose);
            margin: 20px 0; padding: 15px; background: #f8f9fa;
            border: 2px dashed var(--mongoose); text-align: center; border-radius: 10px;
        }
        .btn-add { background: var(--mongoose); color: white; border: none; width: 100%; padding: 15px; border-radius: 10px; font-weight: bold; transition: 0.3s; }
        .btn-add:hover { background: #a49374; transform: translateY(-2px); }
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

                <form action="add-to-cart" method="post" id="addToCartForm" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="variation_name" id="hiddenVariationName" value="">
                    <input type="hidden" name="addon_name" id="hiddenAddonName" value="">
                    <input type="hidden" name="final_unit_price" id="hiddenUnitPrice" value="">

                    <div class="options-panel">
                        <label class="label-black">1. Select Specific Type</label>
                        <select class="form-select" name="base_item" id="base_item">
                            <% if ("14".equals(id)) { %>
                            <option value="16.00">Apron 1 Tone - RM 16.00</option>
                            <option value="17.00">Apron 2 Tone - RM 17.00</option>
                            <option value="8.00">Apron Coffee/Hitam - RM 8.00</option>
                            <option value="25.00">Apron Denim - RM 25.00</option>
                            <option value="30.00">Apron Premium 2 Button - RM 30.00</option>
                            <% } else if ("4".equals(id)) { %>
                            <option value="18.00">Banner 2' x 3' - RM 18.00</option>
                            <option value="90.00">Banner 10' x 3' - RM 90.00</option>
                            <option value="21.00">Bunting 2' x 3' - RM 21.00</option>
                            <% } else if ("3".equals(id)) { %>
                            <option value="11.90">Basic Quick Dry Round Neck - RM 11.90</option>
                            <option value="16.00">Siro Cotton (White) - RM 16.00</option>
                            <option value="40.00">Oversized T-Shirt - RM 40.00</option>
                            <% } else { %>
                            <option value="47.00">3mm Acrylic Clear - RM 47.00</option>
                            <option value="35.00">3mm High Impact - RM 35.00</option>
                            <% } %>
                        </select>

                        <label class="label-black">2. Add-On Services</label>
                        <select class="form-select" name="addon_service" id="addon_service">
                            <option value="0.00">None</option>
                            <option value="3.00">Add On Name/Number (+RM 3.00)</option>
                            <% if ("14".equals(id) || "3".equals(id)) { %>
                            <option value="6.00">Add On Pocket (+RM 6.00)</option>
                            <option value="12.00">Nombor Belakang (+RM 12.00)</option>
                            <% } %>
                            <% if ("4".equals(id) || "16".equals(id)) { %>
                            <option value="70.00">Installation Service (+RM 70.00)</option>
                            <% } %>
                        </select>

                        <label class="label-black">3. Size Upgrade (T-Shirt Only)</label>
                        <select class="form-select" name="size_addon" id="size_addon">
                            <option value="0.00">Standard Size</option>
                            <option value="3.00">Size 3XL (+RM 3.00)</option>
                            <option value="6.00">Size 5XL (+RM 6.00)</option>
                            <option value="11.00">Size 7XL (+RM 11.00)</option>
                        </select>

                        <label class="label-black">4. Upload Design</label>
                        <input type="file" class="form-control" name="design_file">
                        <small class="text-muted">Required for custom DTF/Sublimation printing.</small>

                        <label class="label-black">5. Quantity</label>
                        <input type="number" class="form-control" name="quantity" id="quantity" value="1" min="1">

                        <div class="price-box">
                            Total: RM <span id="totalPrice">0.00</span>
                        </div>

                        <button type="submit" class="btn-add">Confirm & Add to Cart</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    function updatePrice() {
        // Elements
        let baseEl = document.getElementById('base_item');
        let addonEl = document.getElementById('addon_service');
        let sizeEl = document.getElementById('size_addon');
        let qtyEl = document.getElementById('quantity');

        // Prices
        let basePrice = parseFloat(baseEl.value) || 0;
        let addonPrice = parseFloat(addonEl.value) || 0;
        let sizePrice = parseFloat(sizeEl.value) || 0;
        let quantity = parseInt(qtyEl.value) || 1;

        document.getElementById('hiddenVariationName').value = baseEl.options[baseEl.selectedIndex].text;
        document.getElementById('hiddenAddonName').value = addonEl.options[addonEl.selectedIndex].text;

        // Calculations
        let unitPrice = basePrice + addonPrice + sizePrice;
        let total = unitPrice * quantity;

        // Update UI
        document.getElementById('totalPrice').innerText = total.toFixed(2);
        document.getElementById('hiddenUnitPrice').value = unitPrice.toFixed(2);
    }

    // Listen for any change
    document.querySelectorAll('select, input').forEach(el => {
        el.addEventListener('change', updatePrice);
        el.addEventListener('input', updatePrice);