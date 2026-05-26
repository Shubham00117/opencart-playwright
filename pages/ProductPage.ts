import { Page, Locator, expect } from '@playwright/test';

/**
 * ProductPage - Page Object for the OpenCart Product Detail page.
 * Handles product interactions including add to cart, wishlist, and quantity selection.
 */
export class ProductPage {
    private readonly page: Page;

    // Locators
    private readonly txtProductName: Locator;
    private readonly txtProductPrice: Locator;
    private readonly btnAddToCart: Locator;
    private readonly btnAddToWishList: Locator;
    private readonly btnAddToCompare: Locator;
    private readonly txtQuantity: Locator;
    private readonly lblSuccessAlert: Locator;
    private readonly lblErrorAlert: Locator;
    private readonly txtProductDescription: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.txtProductName = page.locator('#content h1');
        this.txtProductPrice = page.locator('.price-new, li:has(h2)');
        this.btnAddToCart = page.locator('#button-cart');
        this.btnAddToWishList = page.locator('button[data-original-title="Add to Wish List"]');
        this.btnAddToCompare = page.locator('button[data-original-title="Compare this Product"]');
        this.txtQuantity = page.locator('#input-quantity');
        this.lblSuccessAlert = page.locator('.alert-success');
        this.lblErrorAlert = page.locator('.alert-danger');
        this.txtProductDescription = page.locator('#tab-description');
    }

    /**
     * Gets the product name from the page heading
     * @returns Promise<string | null>
     */
    async getProductName(): Promise<string | null> {
        return await this.txtProductName.textContent();
    }

    /**
     * Clicks the "Add to Cart" button
     */
    async clickAddToCart(): Promise<void> {
        await this.btnAddToCart.click();
    }

    /**
     * Clicks the "Add to Wish List" button
     */
    async clickAddToWishList(): Promise<void> {
        await this.btnAddToWishList.click();
    }

    /**
     * Clicks the "Compare this Product" button
     */
    async clickAddToCompare(): Promise<void> {
        await this.btnAddToCompare.click();
    }

    /**
     * Sets the product quantity
     * @param qty - Quantity to set (as a string)
     */
    async setQuantity(qty: string): Promise<void> {
        await this.txtQuantity.clear();
        await this.txtQuantity.fill(qty);
    }

    /**
     * Gets the success alert message text
     * @returns Promise<string | null>
     */
    async getSuccessMessage(): Promise<string | null> {
        return await this.lblSuccessAlert.textContent();
    }

    /**
     * Checks if a success alert is visible on the page
     * @returns Promise<boolean>
     */
    async isSuccessAlertVisible(): Promise<boolean> {
        try {
            await expect(this.lblSuccessAlert).toBeVisible({ timeout: 4000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Gets the error alert message text
     * @returns Promise<string | null>
     */
    async getErrorMessage(): Promise<string | null> {
        return await this.lblErrorAlert.textContent();
    }

    /**
     * Adds a product to cart with specified quantity
     * @param qty - Quantity to add (default: "1")
     */
    async addToCart(qty: string = '1'): Promise<void> {
        await this.setQuantity(qty);
        await this.clickAddToCart();
    }
}
