<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /* DATA RETRIEVAL & INITIALIZATION
       Retrieve the product ID from the URL parameters (e.g., product-details.jsp?id=14)
    */
    String id = request.getParameter("id");
    String pName = "Printing Service"; // Default name
    String pDesc = "High-quality custom printing solutions."; // Default description

    /* DYNAMIC CONTENT LOGIC
       Update name and description based on the specific ID received
    */
    if (id != null) {
        if (id.equals("14")) {
            pName = "Apron Custom";
            pDesc = "Professional kitchen wear in various materials.";
        }
        else if (id.equals("4")) {
            pName = "Banner & Bunting";
            pDesc = "Outdoor and indoor large format printing.";
        }
        else if (id.equals("15")) {
            pName = "Acrylic Clear";
            pDesc = "3mm high-quality laser cut acrylic.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Rheaka Design - <%= pName %></title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        /* CSS Variables for brand consistency */
        :root { --mongoose: #baa987; --steelblue: #b0c4de; }
        body { background-color: var(--steelblue) !important; font-family: 'Roboto', sans-serif; }

        /* UI Component Styling */
        .card { border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); border: none; }
        .label-black { color: #000; font-weight: 700; text-transform: uppercase; font-size: 0.85rem; }
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
        .btn-add {
            background: var(--mongoose);
            color: white;
            border: none;
            width: 100%;
            padding: 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn-add:hover { background: #a49374; }
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

                <form action="add-to-cart" method="post" id="addToCartForm">
                    <input type="hidden" name="id" value="<%= id != null ? id : "15" %>">
                    <input type="hidden" name="price" id="hiddenPrice" value="47.00">

                    <div class="details-container">
                        <div class="options-panel">
                            <h3>Customize Your Order</h3>

                            <div class="col-12">
                                <label class="label-black">Select Specific Type</label>
                                <select class="form-select" name="base_item" id="base_item">
                                    <% if (id != null && id.equals("14")) { %>
                                    <option value="16.00">Apron 1 Tone (Blue/Red/Brown) - RM 16.00</option>
                                    <option value="17.00">Apron 2 Tone (Khaki/Black) - RM 17.00</option>
                                    <option value="25.00">Apron Denim - RM 25.00</option>
                                    <option value="30.00">Apron Premium 2 Button - RM 30.00</option>
                                    <% } else if (id != null && id.equals("4")) { %>
                                    <option value="90.00">Banner 10' x 3' - RM 90.00</option>
                                    <option value="120.00">Banner 10' x 4' - RM 120.00</option>
                                    <option value="264.00">Backdrop 11' x 8' - RM 264.00</option>
                                    <% } else { %>
                                    <option value="47.00">3mm Acrylic Clear - RM 47.00</option>
                                    <option value="35.00">3mm High Impact - RM 35.00</option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-12">
                                <label class="label-black">Service Add-Ons</label>
                                <select class="form-select" name="addon_service" id="addon_service">
                                    <option value="0.00">None</option>
                                    <option value="3.00">Add On Name (+RM 3.00)</option>
                                    <option value="6.00">Add On Pocket (+RM 6.00)</option>
                                    <option value="0.50">Add On Eyelet (+RM 0.50)</option>
                                </select>
                            </div>

                            <div class="col-md-12">
                                <label class="label-black">Size Upgrade</label>
                                <select class="form-select" name="size_addon" id="size_addon">
                                    <option value="0.00">Standard Size</option>
                                    <option value="3.00">3XL (+RM 3.00)</option>
                                    <option value="5.00">4XL (+RM 5.00)</option>
                                    <option value="11.00">7XL (+RM 11.00)</option>
                                </select>
                            </div>

                            <div class="col-12 mt-4">
                                <label class="label-black">Quantity</label>
                                <input type="number" class="form-control" name="quantity" id="quantity" value="1" min="1">
                            </div>

                            <div class="price-box">
                                Total Price: RM <span id="totalPrice">47.00</span>
                            </div>

                            <button type="submit" class="btn-add">Add to Cart</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    /* PRICE CALCULATION LOGIC
       Calculates the final price based on user selections in real-time.
    */
    function updatePrice() {
        // Retrieve values from dropdowns and parse them as numbers
        let basePrice = parseFloat(document.getElementById('base_item').value) || 0;
        let addonService = parseFloat(document.getElementById('addon_service').value) || 0;
        let sizeAddon = parseFloat(document.getElementById('size_addon').value) || 0;
        let quantity = parseInt(document.getElementById('quantity').value) || 1;

        // Formula: (Base + Extras) multiplied by Quantity
        let finalPrice = (basePrice + addonService + sizeAddon) * quantity;

        // Display the formatted price to the user (2 decimal places)
        document.getElementById('totalPrice').innerText = finalPrice.toFixed(2);

        // Update the hidden input field so the Servlet receives the correct price
        document.getElementById('hiddenPrice').value = finalPrice.toFixed(2);
    }

    /* EVENT LISTENERS
       Trigger the calculation whenever an option is changed or quantity is typed
    */
    document.getElementById('base_item').addEventListener('change', updatePrice);
    document.getElementById('addon_service').addEventListener('change', updatePrice);
    document.getElementById('size_addon').addEventListener('change', updatePrice);
    document.getElementById('quantity').addEventListener('input', updatePrice);

    // Initial calculation on page load to ensure price display is correct
    updatePrice();
</script>
</body>
</html>