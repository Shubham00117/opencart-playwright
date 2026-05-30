import { Page, Locator, expect } from '@playwright/test';

/**
 * LogoutPage - Page Object for the OpenCart Account Logout page.
 * Handles verification of successful logout.
 */
export class LogoutPage {
    private readonly page: Page;

    // Locators
    private readonly hLogout: Locator;
    private readonly btnContinue: Locator;
    private readonly logoutConfirmationText: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.hLogout = page.locator('#content h1');
        this.btnContinue = page.locator('a:has-text("Continue")');
        this.logoutConfirmationText = page.locator('#content p:first-of-type');
    }

    /**
     * Checks if the logout confirmation page is displayed
     * @returns Promise<boolean>
     */
    async isLogoutPageExists(): Promise<boolean> {
        try {
            await expect(this.hLogout).toContainText('Account Logout', { timeout: 5000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Gets the heading text of the logout page
     * @returns Promise<string | null>
     */
    async getLogoutHeading(): Promise<string | null> {
        return await this.hLogout.textContent();
    }

    /**
     * Clicks the Continue button to return to home page after logout
     */
    async clickContinue(): Promise<void> {
        await this.btnContinue.click();
    }

    /**
     * Gets the confirmation message text on the logout page
     * @returns Promise<string | null>
     */
    async getConfirmationMessage(): Promise<string | null> {
        return await this.logoutConfirmationText.textContent();
    }
}
