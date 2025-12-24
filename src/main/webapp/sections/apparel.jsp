<label class="label-black">1. Select Printing Type</label>
<select class="form-select" id="printing_method" onchange="toggleApparelFlow()">
    <option value="">Please Select </option>
    <option value="sublimation">Sublimation (Full Print)</option>
    <option value="silkscreen">Silkscreen Printing</option>
    <option value="logo">Logo Printing (DTF)</option>
</select>

<hr>

<div id="flow_sublimation" style="display:none;">
    <label class="label-black">2. Jersey Fabric Type</label>
    <select class="form-select" id="sub_fabric">
        <option value="0">Eyelet 180gsm</option>
        <option value="3.00">Diamond 180gsm (+RM 3.00)</option>
        <option value="0">Interlock 180gsm</option>
        <option value="0">Lycra 230gsm</option>
        <option value="0">Lycra 280gsm</option>
        <option value="0">Mini eyelet 180gsm</option>
        <option value="0">RJPK 180gsm</option>
        <option value="0">RJPK 230gsm</option>
    </select>

    <label class="label-black">3. Apparel Type (Sublimation)</label>
    <select class="form-select" id="sub_base_item">
        <option value="33.00">Round Neck Short Sleeve &ndash; RM 33.00</option>
        <option value="38.00">Round Neck Long Sleeve &ndash; RM 38.00</option>
        <option value="31.00">Round Neck Short Sleeve Kids &ndash; RM 31.00</option>
        <option value="40.00">Round Neck Muslimah &ndash; RM 40.00</option>
        <option value="38.00">Collar Short Sleeve &ndash; RM 38.00</option>
        <option value="41.00">Collar Long Sleeve &ndash; RM 41.00</option>
        <option value="35.00">V Neck Short Sleeve &ndash; RM 35.00</option>
        <option value="45.00">V Neck Muslimah &ndash; RM 45.00</option>
    </select>

    <label class="label-black">4. Sublimation Add&ndash;On (Per Piece)</label>
    <select class="form-select" id="sub_addon">
        <option value="0">None</option>
        <option value="3.00">Name (+RM 3.00)</option>
        <option value="4.00">Number (+RM 4.00)</option>
        <option value="6.00">Pocket (+RM 6.00)</option>
        <option value="7.00">Pocket Muslimah (+RM 7.00)</option>
    </select>
</div>

<div id="flow_ready_made" style="display:none;">
    <label class="label-black">2. Apparel Type & Fabric</label>
    <select class="form-select" id="base_item">
        <optgroup label="Cotton 160gsm">
            <option value="18.00">Cotton 160gsm &ndash; RN Short Sleeve &ndash; RM 18.00</option>
            <option value="22.00">Cotton 160gsm &ndash; RN Long Sleeve &ndash; RM 22.00</option>
            <option value="26.00">Cotton 160gsm &ndash; Collar Long Sleeve &ndash; RM 26.00</option>
        </optgroup>
        <optgroup label="Jersey Microfiber 150gsm">
            <option value="15.00">Microfiber 150gsm &ndash; RN Short Sleeve &ndash; RM 15.00</option>
            <option value="18.00">Microfiber 150gsm &ndash; RN Long Sleeve &ndash; RM 18.00</option>
        </optgroup>
    </select>

    <div id="addon_silkscreen_div" style="display:none;">
        <label class="label-black">3. Number of Colors/Screens (RM 40.00 Setup Fee)</label>
        <select class="form-select" id="silkscreen_setup">
            <option value="0">Select Setup Screen</option>
            <option value="40.00">1 Color / 1 Position (RM 40.00)</option>
            <option value="80.00">2 Colors / 2 Positions (RM 80.00)</option>
            <option value="120.00">3 Colors / 3 Positions (RM 120.00)</option>
        </select>

        <label class="label-black">4. Silkscreen Add-On (Per Piece)</label>
        <select class="form-select" id="addon_silkscreen">
            <option value="0">None</option>
            <option value="7.00">LOGO A3 &ndash; RM 7.00</option>
            <option value="4.50">LOGO A4 &ndash; RM 4.50</option>
            <option value="2.00">Logo 7cm x 7cm &ndash; RM 2.00</option>
            <option value="3.00">NAME BACK &ndash; RM 3.00</option>
            <option value="5.00">Back Number &ndash; RM 5.00</option>
        </select>
    </div>

    <div id="addon_logo_div" style="display:none;">
        <label class="label-black">3. Logo Printing Add-On (Per Piece)</label>
        <select class="form-select" id="addon_logo">
            <option value="0">None</option>
            <option value="14.00">LOGO A3 &ndash; RM 14.00</option>
            <option value="7.00">LOGO A4 &ndash; RM 7.00</option>
            <option value="4.00">NAME BACK &ndash; RM 4.00</option>
            <option value="12.00">Back Number &ndash; RM 12.00</option>
        </select>
    </div>
</div>

<div id="common_apparel" style="display:none;">
    <label class="label-black">5. Oversize Upgrade</label>
    <select class="form-select" id="size_addon">
        <option value="0">Standard Size (XS)</option>
        <option value="0">Standard Size (S)</option>
        <option value="0">Standard Size (M)</option>
        <option value="0">Standard Size (L)</option>
        <option value="0">Standard Size (XL)</option>
        <option value="0">Standard Size (2XL)</option>
        <option value="3.00">3XL (+RM 3.00)</option>
        <option value="5.50">4XL (+RM 5.50)</option>
        <option value="6.50">5XL (+RM 6.50)</option>
        <option value="9.00">6XL (+RM 9.00)</option>
        <option value="11.00">7XL (+RM 11.00)</option>
    </select>
</div>

<script>
    function toggleApparelFlow() {
        const method = document.getElementById('printing_method').value;
        document.getElementById('flow_sublimation').style.display = (method === 'sublimation') ? 'block' : 'none';
        document.getElementById('flow_ready_made').style.display = (method === 'silkscreen' || method === 'logo') ? 'block' : 'none';
        document.getElementById('addon_silkscreen_div').style.display = (method === 'silkscreen') ? 'block' : 'none';
        document.getElementById('addon_logo_div').style.display = (method === 'logo') ? 'block' : 'none';
        document.getElementById('common_apparel').style.display = (method !== '') ? 'block' : 'none';

        if (typeof updatePrice === "function") updatePrice();
    }
</script>