import { Page, Locator, expect } from '@playwright/test';

/**
 * WishListPage - Page Object for the OpenCart Wish List page.
 * Handles wishlist item verification and management.
 */
export class WishListPage {
    private readonly page: Page;

    // Locators
    private readonly lstWishListItems: Locator;
    private readonly tblWishList: Locator;
    private readonly emptyWishListMessage: Locator;
    private readonly btnRemoveItem: Locator;
    private readonly btnAddToCartFromWishList: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.lstWishListItems = page.locator('#wishlist-product tbody tr');
        this.tblWishList = page.locator('#wishlist-product');
        this.emptyWishListMessage = page.locator('.col-sm-12 p:has-text("Your wish list is empty")');
        this.btnRemoveItem = page.locator('a[data-original-title="Remove"]');
        this.btnAddToCartFromWishList = page.locator('button[data-original-title="Add to Cart"]');
    }

    /**
     * Checks if the wish list page is displayed
     * @returns Promise<boolean>
     */
    async isWishListPageDisplayed(): Promise<boolean> {
        try {
            await expect(this.page).toHaveURL(/.*route=account\/wishlist.*/);
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Gets the number of items in the wish list
     * @returns Promise<number>
     */
    async getWishListItemCount(): Promise<number> {
        return await this.lstWishListItems.count();
    }

    /**
     * Checks if the wish list is empty
     * @returns Promise<boolean>
     */
    async isWishListEmpty(): Promise<boolean> {
        try {
            await expect(this.emptyWishListMessage).toBeVisible({ timeout: 3000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Removes the first item from the wish list
     */
    async removeFirstItem(): Promise<void> {
        await this.btnRemoveItem.first().click();
    }

    /**
     * Adds the first item from wish list to the cart
     */
    async addFirstItemToCart(): Promise<void> {
        await this.btnAddToCartFromWishList.first().click();
    }
}
