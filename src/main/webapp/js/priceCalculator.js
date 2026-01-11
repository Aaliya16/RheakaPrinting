// Global flag to prevent multiple simultaneous calculations
let isCalculating = false;

function updatePrice() {
    // Prevent duplicate calculations (race condition protection)
    if (isCalculating) {
        console.log('⚠️ Calculation already in progress, skipping...');
        return;
    }

    isCalculating = true;

    try {
        // 1. Primary Selectors - These exist on almost every product page
        const methodEl = document.getElementById('printing_method');
        const baseEl = document.getElementById('base_item'); // Main item for non-apparel products
        const sizeAddonEl = document.getElementById('size_addon');
        const nametagEl = document.getElementById('nametag_addon');
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
                unitPrice = (parseFloat(baseEl?.value) || 0) +
                    (parseFloat(silkAddon?.value) || 0);

                // Screen setup fee is paid only ONCE
                setupFee = parseFloat(screenSetup?.value) || 0;

                // --- LOGO PRINTING (DTF) FLOW ---
            } else if (method === 'logo') {
                const logoAddon = document.getElementById('addon_logo');

                // Logo printing unit cost = Shirt + Logo Charge per piece
                unitPrice = (parseFloat(baseEl?.value) || 0) +
                    (parseFloat(logoAddon?.value) || 0);
            }
        }
        // 3. Default Flow for the other 7 products (Acrylic, Banners, Cards, etc.)
        else {
            const addonEl = document.getElementById('addon_service');
            unitPrice = (parseFloat(baseEl?.value) || 0) +
                (parseFloat(addonEl?.value) || 0);
        }

        // 4. Global Add-ons
        const sizeUpgrade = parseFloat(sizeAddonEl?.value) || 0;
        const nametagPrice = parseFloat(nametagEl?.value) || 0;
        const quantity = parseInt(qtyInput?.value) || 1;

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

        // 7. Debug logging
        console.log('💰 Price Calculation Breakdown:', {
            unitPrice: unitPrice.toFixed(2),
            sizeUpgrade: sizeUpgrade.toFixed(2),
            nametagPrice: nametagPrice.toFixed(2),
            quantity: quantity,
            setupFee: setupFee.toFixed(2),
            total: total.toFixed(2)
        });

    } catch (error) {
        console.error('❌ Error in updatePrice():', error);
        alert('Calculation error. Please refresh the page.');
    } finally {
        // Always release the lock
        isCalculating = false;
    }
}

/**
 * Event Listeners with Debouncing
 * Prevents rapid-fire calculations during quick input changes
 */
let debounceTimer;

document.addEventListener('change', function(e) {
    if (e.target.matches('select, input')) {
        // Clear any pending calculation
        clearTimeout(debounceTimer);

        // Wait 150ms before calculating
        debounceTimer = setTimeout(() => {
            if (typeof toggleApparelFlow === "function") {
                toggleApparelFlow();
            }
            updatePrice();
        }, 150);
    }
});

// Run calculation once page is loaded
window.addEventListener('DOMContentLoaded', () => {
    console.log('✅ Price calculator loaded');
    updatePrice();
});

/**
 * Form Validation and Submission Handling
 */
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('addToCartForm');

    if (!form) {
        console.warn('⚠️ Add to cart form not found on this page');
        return;
    }

    form.addEventListener('submit', function(e) {
        // 1. Check login status
        const statusInput = document.getElementById("loginStatus");

        // Safety check: Exit if the hidden input is missing
        if (!statusInput) {
            console.error("❌ ERROR: Hidden input 'loginStatus' not found!");
            alert("System Error: Login status check failed.");
            e.preventDefault();
            return false;
        }

        // 2. Verify user is logged in
        const isLoggedIn = (statusInput.value === "true");

        if (!isLoggedIn) {
            e.preventDefault(); // Block submission
            alert("⚠️ Please LOGIN first to proceed with the purchase.");
            return false;
        }

        // 3. Price and Quantity Validation
        const priceCheck = document.getElementById('hiddenPrice')?.value;
        const quantity = document.getElementById('quantity')?.value;

        if (!priceCheck || parseFloat(priceCheck) <= 0) {
            e.preventDefault();
            alert('⚠️ Please select product options first!');
            return false;
        }

        if (!quantity || parseInt(quantity) < 1) {
            e.preventDefault();
            alert('⚠️ Quantity must be at least 1!');
            return false;
        }

        // 4. Log successful submission
        console.log('✅ Form validation passed. Submitting with:', {
            price: priceCheck,
            quantity: quantity
        });

        return true;
    });
});