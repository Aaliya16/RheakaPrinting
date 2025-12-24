<label class="label-black">Product Type</label>
<select class="form-select" id="base_item" onchange="toggleApronColors()">
    <option value="16.00">Apron 1 Tone &ndash; RM 16.00</option>
    <option value="17.00">Apron 2 Tone &ndash; RM 17.00</option>
    <option value="8.00">Apron Standard &ndash; RM 8.00</option>
    <option value="25.00">Apron Denim &ndash; RM 25.00</option>
    <option value="29.00">Apron Oren AP04 &ndash; RM 29.00</option>
    <option value="30.00">Apron Oren AP05 &ndash; RM 30.00</option>
    <option value="30.00">Apron Premium 2 Button &ndash; RM 30.00</option>
</select>

<div id="color_section">
    <label class="label-black">Available Colors</label>

    <select class="form-select apron-color" id="colors_1tone">
        <option>Black</option><option>Blue</option><option>Brown</option>
        <option>Green</option><option>Indigo</option><option>Red</option>
    </select>

    <select class="form-select apron-color" id="colors_2tone" style="display:none;">
        <option>Black</option><option>Brown</option><option>Khaki</option><option>Red</option>
    </select>

    <select class="form-select apron-color" id="colors_rm8" style="display:none;">
        <option>Coffee</option><option>Hijau Muda</option><option>Hitam</option>
        <option>Maroon</option><option>Merah</option><option>Pink</option>
    </select>

    <select class="form-select apron-color" id="colors_premium" style="display:none;">
        <option>Black</option><option>Brown</option><option>Khaki</option>
    </select>
</div>

<label class="label-black">Add-On Services</label>
<select class="form-select" id="addon_service">
    <option value="0.00">None</option>
    <option value="14.00">DTF A3 &ndash; RM 14.00</option>
    <option value="7.00">DTF A4 &ndash; RM 7.00</option>
    <option value="5.00">DTF A5 &ndash; RM 5.00</option>
</select>

<input type="hidden" class="size_addon" value="0">

<script>
    function toggleApronColors() {
        const type = document.getElementById('base_item').options[document.getElementById('base_item').selectedIndex].text;
        const allColors = document.querySelectorAll('.apron-color');

        // Hide all color dropdowns first
        allColors.forEach(el => el.style.display = 'none');

        // Show the correct dropdown based on selection
        if (type.includes("1 Tone")) document.getElementById('colors_1tone').style.display = 'block';
        else if (type.includes("2 Tone")) document.getElementById('colors_2tone').style.display = 'block';
        else if (type.includes("Apron Standard")) document.getElementById('colors_rm8').style.display = 'block';
        else if (type.includes("Premium 2 Button")) document.getElementById('colors_premium').style.display = 'block';
    }
</script>