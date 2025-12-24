/**
 * Rheaka Design - Universal Price Calculation Engine (Final Updated Version)
 * Handles Sublimation Setup, Silkscreen Screen Fees, and Ready-made Logo printing.
 */

function updatePrice() {
    // Primary selectors
    const methodEl = document.getElementById('printing_method');
    const qtyInput = document.getElementById('quantity');
    const sizeAddonEl = document.getElementById('size_addon');

    let unitPrice = 0;
    let setupFee = 0; // Fixed fee that doesn't multiply by quantity

    if (methodEl) {
        const method = methodEl.value;

        // 1. SUBLIMATION FLOW
        if (method === 'sublimation') {
            const fabric = document.getElementById('sub_fabric');
            const shirt = document.getElementById('sub_base_item');
            const subAddon = document.getElementById('sub_addon');

            // Sublimation adds Fabric Premium + Base Shirt Price + Addon
            unitPrice = (parseFloat(fabric?.value) || 0) +
                (parseFloat(shirt?.value) || 0) +
                (parseFloat(subAddon?.value) || 0);

            // 2. SILKSCREEN FLOW
        } else if (method === 'silkscreen') {
            const shirt = document.getElementById('base_item');
            const silkAddon = document.getElementById('addon_silkscreen');
            const screenSetup = document.getElementById('silkscreen_setup');

            unitPrice = (parseFloat(shirt?.value) || 0) + (parseFloat(silkAddon?.value) || 0);
            // Setup fee added only ONCE at the end
            setupFee = parseFloat(screenSetup?.value) || 0;

            // 3. LOGO PRINTING (DTF) FLOW
        } else if (method === 'logo') {
            const shirt = document.getElementById('base_item');
            const logoAddon = document.getElementById('addon_logo');
            unitPrice = (parseFloat(shirt?.value) || 0) + (parseFloat(logoAddon?.value) || 0);

            // 4. DEFAULT FLOW (For Acrylic, Cards, etc.)
        } else {
            const baseEl = document.getElementById('base_item');
            const addonEl = document.getElementById('addon_service');
            unitPrice = (parseFloat(baseEl?.value) || 0) + (parseFloat(addonEl?.value) || 0);
        }
    }

    const sizeUpgrade = parseFloat(sizeAddonEl?.value) || 0;
    const quantity = parseInt(qtyInput?.value) || 1;

    // FORMULA: ((Unit Price + Size Upgrade) * Quantity) + Fixed Setup Fee
    const total = ((unitPrice + sizeUpgrade) * quantity) + setupFee;

    // Update UI Elements
    const priceText = document.getElementById('totalPrice');
    const hiddenPriceInput = document.getElementById('hiddenPrice');

    if (priceText) priceText.innerText = total.toFixed(2);
    if (hiddenPriceInput) hiddenPriceInput.value = total.toFixed(2);
}

// Global Event Listeners for Live Updates
document.addEventListener('change', function(e) {
    if (e.target.matches('select, input')) {
        // Automatically run toggleApparelFlow if on the Apparel page
        if (typeof toggleApparelFlow === "function") {
            toggleApparelFlow();
        }
        updatePrice();
    }
});

// Run once when page is ready
window.addEventListener('DOMContentLoaded', () => {
    updatePrice();
});