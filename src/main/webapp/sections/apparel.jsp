<label class="label-black">Product Type</label>
<select class="form-select" id="base_item" onchange="toggleApparelStyles()">
    <option value="11.90">Basic Quick Dry</option>
    <option value="16.00">Premium Siro Cotton</option>
    <option value="25.00">Short Sleeve Oversized</option>
</select>

<div id="style_section">
    <label class="label-black">Select Style</label>

    <select class="form-select apparel-style" id="style_quickdry">
        <option>Round Neck</option><option>Round Neck Long Sleeve</option>
        <option>Sleeve</option><option>Round Neck Muslimah</option>
        <option>Polo</option><option>Polo Long Sleeve</option>
        <option>Sleeveless</option><option>Kids Long Sleeve</option><option>Kids Polo</option>
    </select>

    <select class="form-select apparel-style" id="style_siro" style="display:none;">
        <option>Long Sleeve (All Colors)</option><option>Round Neck (All Colors)</option>
        <option>Round Neck (White)</option><option>Kids Round Neck</option>
    </select>

    <select class="form-select apparel-style" id="style_oversized" style="display:none;">
        <option value="0">210 gsm Unisex Oversized</option>
        <option value="5.00">260 gsm Unisex Oversized (+RM 5.00)</option>
    </select>
</div>

<label class="label-black">Select Size</label>
<select class="form-select" id="size_base">
    <option value="0">XS</option><option value="0">S</option>
    <option value="0">M</option><option value="0">L</option>
    <option value="0">XL</option><option value="0">2XL</option>
</select>

<label class="label-black">Size Upgrade</label>
<select class="form-select" id="size_addon">
    <option value="0">Standard Size (Included)</option>
    <option value="3.00">Add On Size 3XL (+RM 3.00)</option>
    <option value="6.00">Add On Size 4XL (+RM 6.00)</option>
    <option value="7.00">Add On Size 5XL (+RM 7.00)</option>
    <option value="9.00">Add On Size 6XL (+RM 9.00)</option>
    <option value="11.00">Add On Size 7XL (+RM 11.00)</option>
</select>

<input type="hidden" class="addon_service" value="0">

<script>
    function toggleApparelStyles() {
        const type = document.getElementById('base_item').value;
        const allStyles = document.querySelectorAll('.apparel-style');
        allStyles.forEach(el => el.style.display = 'none');

        if (type === "11.90") document.getElementById('style_quickdry').style.display = 'block';
        else if (type === "16.00") document.getElementById('style_siro').style.display = 'block';
        else if (type === "25.00") document.getElementById('style_oversized').style.display = 'block';
    }
</script>