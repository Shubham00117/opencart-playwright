import { Page, Locator, expect } from '@playwright/test';

/**
 * MyAccountPage - Page Object for the OpenCart My Account dashboard page.
 * Handles account page verification and navigation to account sub-sections.
 */
export class MyAccountPage {
    private readonly page: Page;

    // Locators
    private readonly hMyAccount: Locator;
    private readonly lnkEditAccount: Locator;
    private readonly lnkChangePassword: Locator;
    private readonly lnkAddressBook: Locator;
    private readonly lnkWishList: Locator;
    private readonly lnkOrderHistory: Locator;
    private readonly lnkLogout: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.hMyAccount = page.locator('h2:has-text("My Account")');
        this.lnkEditAccount = page.locator('a:has-text("Edit your account information")');
        this.lnkChangePassword = page.locator('a:has-text("Change your password")');
        this.lnkAddressBook = page.locator('a:has-text("Modify your address book entries")');
        this.lnkWishList = page.locator('a:has-text("Modify your wish list")');
        this.lnkOrderHistory = page.locator('a:has-text("View your order history")');
        this.lnkLogout = page.locator('a:has-text("Logout")');
    }

    /**
     * Checks if the My Account page is displayed after login
     * @returns Promise<boolean>
     */
    async isMyAccountPageExists(): Promise<boolean> {
        try {
            await expect(this.hMyAccount).toBeVisible({ timeout: 5000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Clicks the "Edit Account Information" link
     */
    async clickEditAccount(): Promise<void> {
        await this.lnkEditAccount.click();
    }

    /**
     * Clicks the "Change Password" link
     */
    async clickChangePassword(): Promise<void> {
        await this.lnkChangePassword.click();
    }

    /**
     * Clicks the "Wish List" link
     */
    async clickWishList(): Promise<void> {
        await this.lnkWishList.click();
    }

    /**
     * Clicks the "Order History" link
     */
    async clickOrderHistory(): Promise<void> {
        await this.lnkOrderHistory.click();
    }

    /**
     * Clicks the "Logout" link from the account page
     */
    async clickLogout(): Promise<void> {
        await this.lnkLogout.click();
    }
}
