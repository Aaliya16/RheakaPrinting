/**
 * Rheaka Design - Universal Price Calculation Engine
 */

function updatePrice() {

    const baseEl = document.getElementById('base_item');

    const addonEl =
        document.getElementById('addon_service') ||
        document.querySelector('.addon_service');

    const sizeAddonEl =
        document.getElementById('size_addon') ||
        document.querySelector('.size_addon');

    const qtyInput = document.getElementById('quantity');

    const basePrice = baseEl ? parseFloat(baseEl.value) || 0 : 0;
    const addonPrice = addonEl ? parseFloat(addonEl.value) || 0 : 0;
    const sizeUpgradePrice = sizeAddonEl ? parseFloat(sizeAddonEl.value) || 0 : 0;
    const quantity = qtyInput ? parseInt(qtyInput.value) || 1 : 1;

    // Variation name
    if (baseEl) {
        let variationName = baseEl.options[baseEl.selectedIndex].text;

        const activeSubStyle =
            document.querySelector('.form-select[style*="display: block"]:not(#base_item)');

        if (activeSubStyle && activeSubStyle.options.length > 0) {
            variationName += " (" +
                activeSubStyle.options[activeSubStyle.selectedIndex].text + ")";
        }

        document.getElementById('hiddenVariationName').value = variationName;
    }

    if (addonEl) {
        document.getElementById('hiddenAddonName').value =
            addonEl.options
                ? addonEl.options[addonEl.selectedIndex].text
                : "None";
    }

    const unitPrice = basePrice + addonPrice + sizeUpgradePrice;
    const total = unitPrice * quantity;

    const priceText = document.getElementById('totalPrice');
    const hiddenPriceInput = document.getElementById('hiddenPrice');

    if (priceText) priceText.innerText = total.toFixed(2);
    if (hiddenPriceInput) hiddenPriceInput.value = total.toFixed(2);
}

function toggleApronColors() {
    const baseEl = document.getElementById('base_item');
    if (!baseEl) return;

    const typeText = baseEl.options[baseEl.selectedIndex].text;
    const allColorDropdowns = document.querySelectorAll('.apron-color');

    allColorDropdowns.forEach(el => el.style.display = 'none');

    if (typeText.includes("1 Tone")) document.getElementById('colors_1tone').style.display = 'block';
    else if (typeText.includes("2 Tone")) document.getElementById('colors_2tone').style.display = 'block';
    else if (typeText.includes("Standard")) document.getElementById('colors_rm8').style.display = 'block';
    else if (typeText.includes("Premium")) document.getElementById('colors_premium').style.display = 'block';
}

function toggleApparelStyles() {
    const baseEl = document.getElementById('base_item');
    if (!baseEl) return;

    const selectedType = baseEl.options[baseEl.selectedIndex].text;
    const allStyles = document.querySelectorAll('.apparel-style');

    allStyles.forEach(el => el.style.display = 'none');

    if (selectedType.includes("Quick Dry")) document.getElementById('style_quickdry').style.display = 'block';
    else if (selectedType.includes("Siro")) document.getElementById('style_siro').style.display = 'block';
    else if (selectedType.includes("Oversized")) document.getElementById('style_oversized').style.display = 'block';
}

document.addEventListener('change', function(e) {
    if (e.target.matches('select, input')) {
        if (e.target.id === 'base_item') {
            toggleApronColors();
            toggleApparelStyles();
        }
        updatePrice();
    }
});

window.addEventListener('DOMContentLoaded', () => {
    toggleApronColors();
    toggleApparelStyles();
    updatePrice();
});
