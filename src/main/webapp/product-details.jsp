<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details - Rheaka Design</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
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

<div class="details-container">
    <div>
        <h2>Custom Business Card</h2>
        <p>High-quality printing with various finishing options.</p>
        <img src="https://via.placeholder.com/350x250" alt="Product Image" style="border-radius: 10px;">
    </div>

    <div class="options-panel">
        <h3>Customize Your Order</h3>

        <label>Size:</label>
        <select id="size">
            <option value="0">Standard (85mm x 55mm)</option>
            <option value="5">Large (+RM5)</option>
        </select>

        <label>Material:</label>
        <select id="material">
            <option value="0">Art Card 260gsm</option>
            <option value="10">Premium Linen (+RM10)</option>
        </select>

        <label>Quantity:</label>
        <input type="number" id="qty" value="100" min="100" step="100">

        <div class="price-box">
            Total Price: RM <span id="totalPrice">10.00</span>
        </div>

        <button class="btn-add">Add to Cart</button>
    </div>
</div>

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

