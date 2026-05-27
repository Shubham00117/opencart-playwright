import { Page, Locator, expect } from '@playwright/test';

/**
 * ShoppingCartPage - Page Object for the OpenCart Shopping Cart page.
 * Handles cart item verification, quantity updates, and checkout navigation.
 */
export class ShoppingCartPage {
    private readonly page: Page;

    // Locators
    private readonly tblCartItems: Locator;
    private readonly btnCheckout: Locator;
    private readonly btnContinueShopping: Locator;
    private readonly lblSubTotal: Locator;
    private readonly lblTotal: Locator;
    private readonly lnkRemoveItem: Locator;
    private readonly emptyCartMessage: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.tblCartItems = page.locator('#content table tbody tr');
        this.btnCheckout = page.locator('a:has-text("Checkout")');
        this.btnContinueShopping = page.locator('a:has-text("Continue Shopping")');
        this.lblSubTotal = page.locator('#content table tfoot tr:has-text("Sub-Total") td:last-child');
        this.lblTotal = page.locator('#content table tfoot tr:has-text("Total") td:last-child');
        this.lnkRemoveItem = page.locator('button[data-original-title="Remove"]');
        this.emptyCartMessage = page.locator('.col-sm-12 p:has-text("Your shopping cart is empty")');
    }

    /**
     * Checks if the cart page is currently displayed
     * @returns Promise<boolean>
     */
    async isCartPageDisplayed(): Promise<boolean> {
        try {
            await expect(this.page).toHaveTitle(/.*Shopping Cart.*/);
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Gets the number of items in the cart
     * @returns Promise<number>
     */
    async getCartItemCount(): Promise<number> {
        return await this.tblCartItems.count();
    }

    /**
     * Clicks the Checkout button
     */
    async clickCheckout(): Promise<void> {
        await this.btnCheckout.click();
    }

    /**
     * Clicks Continue Shopping button
     */
    async clickContinueShopping(): Promise<void> {
        await this.btnContinueShopping.click();
    }

    /**
     * Gets the sub-total price text
     * @returns Promise<string | null>
     */
    async getSubTotal(): Promise<string | null> {
        return await this.lblSubTotal.textContent();
    }

    /**
     * Gets the total price text
     * @returns Promise<string | null>
     */
    async getTotal(): Promise<string | null> {
        return await this.lblTotal.textContent();
    }

    /**
     * Removes the first item from the cart
     */
    async removeFirstItem(): Promise<void> {
        await this.lnkRemoveItem.first().click();
    }

    /**
     * Checks if the empty cart message is visible
     * @returns Promise<boolean>
     */
    async isCartEmpty(): Promise<boolean> {
        try {
            await expect(this.emptyCartMessage).toBeVisible({ timeout: 3000 });
            return true;
        } catch {
            return false;
        }
    }
}
