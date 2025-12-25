/**
 * Rheaka Design - Universal Price Calculation Engine
 * Updated to handle Apparel (Sublimation, Silkscreen, Logo), Nametag Add-ons,
 * and all other 7 standard products.
 */

function updatePrice() {
    // 1. Primary Selectors - These exist on almost every product page
    const methodEl = document.getElementById('printing_method');
    const baseEl = document.getElementById('base_item'); // Main item for non-apparel products
    const sizeAddonEl = document.getElementById('size_addon');
    const nametagEl = document.getElementById('nametag_addon'); // Addressed the missing selector
    const qtyInput = document.getElementById('quantity');

    let unitPrice = 0;
    let setupFee = 0; // One-time fee (not multiplied by quantity)

    // 2. Logic for Apparel Specific Methods
    if (methodEl && methodEl.value !== "") {
        const method = methodEl.value;

        // --- SUBLIMATION FLOW ---
        if (method === 'sublimation') {
            const fabric = document.getElementById('sub_fabric');
            const shirt = document.getElementById('sub_base_item');
            const subAddon = document.getElementById('sub_addon');

            // Sublimation cost = Fabric Premium + Shirt Type + Pattern Addon
            unitPrice = (parseFloat(fabric?.value) || 0) +
                (parseFloat(shirt?.value) || 0) +
                (parseFloat(subAddon?.value) || 0);

            // --- SILKSCREEN FLOW ---
        } else if (method === 'silkscreen') {
            const silkAddon = document.getElementById('addon_silkscreen');
            const screenSetup = document.getElementById('silkscreen_setup');

            // Silkscreen unit cost = Shirt + Printing Charge per piece
            unitPrice = (parseFloat(baseEl?.value) || 0) + (parseFloat(silkAddon?.value) || 0);

            // Screen setup fee is paid only ONCE
            setupFee = parseFloat(screenSetup?.value) || 0;

            // --- LOGO PRINTING (DTF) FLOW ---
        } else if (method === 'logo') {
            const logoAddon = document.getElementById('addon_logo');

            // Logo printing unit cost = Shirt + Logo Charge per piece
            unitPrice = (parseFloat(baseEl?.value) || 0) + (parseFloat(logoAddon?.value) || 0);
        }
    }
    // 3. Default Flow for the other 7 products (Acrylic, Banners, Cards, etc.)
    else {
        const addonEl = document.getElementById('addon_service');
        unitPrice = (parseFloat(baseEl?.value) || 0) + (parseFloat(addonEl?.value) || 0);
    }

    // 4. Global Add-ons
    const sizeUpgrade = parseFloat(sizeAddonEl?.value) || 0;
    const nametagPrice = parseFloat(nametagEl?.value) || 0; // Now safely defined
    const quantity = parseInt(qtyInput?.value) || 1;

    // 5. Final Calculation Formula
    // Total = ((Base Item + Size + Nametag) * Qty) + Fixed Setup Fee
    const total = ((unitPrice + sizeUpgrade + nametagPrice) * quantity) + setupFee;

    // 6. Update UI Elements
    const priceText = document.getElementById('totalPrice');
    const hiddenPriceInput = document.getElementById('hiddenPrice');

    if (priceText) {
        priceText.innerText = total.toFixed(2);
    }
    if (hiddenPriceInput) {
        hiddenPriceInput.value = total.toFixed(2);
    }
}

/**
 * Event Listeners for Live Updates
 */
document.addEventListener('change', function(e) {
    if (e.target.matches('select, input')) {
        // Toggle specific apparel visibility logic if the function exists
        if (typeof toggleApparelFlow === "function") {
            toggleApparelFlow();
        }
        updatePrice();
    }
});

// Run once when the page is fully loaded
window.addEventListener('DOMContentLoaded', () => {
    updatePrice();
});