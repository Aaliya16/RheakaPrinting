<label class="label-black">Choose Printing Method</label>
<select class="form-select" id="printing_method" onchange="toggleApparelFlow()">
    <option value="">-- Select Method --</option>
    <option value="sublimation">Sublimation (Full Print Custom)</option>
    <option value="cop">Cop / Logo / Silkscreen / DTF</option>
</select>

<hr>

<div id="flow_sublimation" style="display:none;">
    <label class="label-black">Choose Fabric Type </label>
    <select class="form-select" id="sub_fabric">
        <option value="25.00">Microfibre &ndash; RM 25.00</option>
        <option value="28.00">Interlock &ndash; RM 28.00</option>
        <option value="30.00">Honeycomb &ndash; RM 30.00</option>
        <option value="32.00">Cotton-touch &ndash; RM 32.00</option>
        <option value="27.00">Jersey Fabric &ndash; RM 27.00</option>
    </select>

    <label class="label-black">Choose Cutting</label>
    <select class="form-select" id="sub_cutting">
        <option>Round Neck</option>
        <option>Polo / Collar</option>
        <option>Long Sleeve</option>
        <option>Muslimah Cutting</option>
    </select>
</div>

<div id="flow_cop" style="display:none;">
    <label class="label-black">2. Product Type (Baju Kosong)</label>
    <select class="form-select" id="base_item" onchange="toggleApparelStyles()">
        <option value="11.90">Basic Quick Dry &ndash; RM 11.90</option>
        <option value="16.00">Premium Siro Cotton &ndash; RM 16.00</option>
        <option value="25.00">Short Sleeve Oversized &ndash; RM 25.00</option>
    </select>

    <label class="label-black">Select Style</label>
    <select class="form-select apparel-style" id="style_quickdry">
        <option>Round Neck</option><option>Round Neck Long Sleeve</option>
        <option>Round Neck Muslimah</option><option>Polo</option>
        <option>Polo Long Sleeve</option><option>Sleeveless</option>
    </select>
    <select class="form-select apparel-style" id="style_siro" style="display:none;">
        <option>Long Sleeve</option><option>Round Neck</option>
    </select>
    <select class="form-select apparel-style" id="style_oversized" style="display:none;">
        <option value="0">210gsm Oversized</option>
        <option value="5.50">260gsm Oversized (+RM 5.50)</option>
    </select>
</div>

<div id="common_apparel_options" style="display:none;">
    <label class="label-black">Select Size</label>
    <select class="form-select" id="size_base">
        <option value="0">XS</option><option value="0">S</option>
        <option value="0">M</option><option value="0">L</option>
        <option value="0">XL</option><option value="0">2XL</option>
    </select>

    <label class="label-black">Oversize Upgrade</label>
    <select class="form-select" id="size_addon">
        <option value="0">Normal Size (No Extra Charge)</option>
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
        const flowSub = document.getElementById('flow_sublimation');
        const flowCop = document.getElementById('flow_cop');
        const common = document.getElementById('common_apparel_options');

        // Reset visibility
        flowSub.style.display = 'none';
        flowCop.style.display = 'none';
        common.style.display = 'none';

        if (method === 'sublimation') {
            flowSub.style.display = 'block';
            common.style.display = 'block';
        } else if (method === 'cop') {
            flowCop.style.display = 'block';
            common.style.display = 'block';
            toggleApparelStyles(); // Ensure sub-styles show
        }

        if (typeof updatePrice === "function") updatePrice();
    }

    function toggleApparelStyles() {
        const baseEl = document.getElementById('base_item');
        const selectedText = baseEl.options[baseEl.selectedIndex].text;
        document.querySelectorAll('.apparel-style').forEach(el => el.style.display = 'none');

        if (selectedText.includes("Quick Dry")) document.getElementById('style_quickdry').style.display = 'block';
        else if (selectedText.includes("Siro Cotton")) document.getElementById('style_siro').style.display = 'block';
        else if (selectedText.includes("Oversized")) document.getElementById('style_oversized').style.display = 'block';
    }
</script>