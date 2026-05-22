import { Page, Locator, expect } from '@playwright/test';

/**
 * LoginPage - Page Object for the OpenCart Login page.
 * Handles all login-related interactions and validations.
 */
export class LoginPage {
    private readonly page: Page;

    // Locators
    private readonly txtEmailAddress: Locator;
    private readonly txtPassword: Locator;
    private readonly btnLogin: Locator;
    private readonly txtErrorMessage: Locator;
    private readonly lnkForgotPassword: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators with CSS selectors
        this.txtEmailAddress = page.locator('#input-email');
        this.txtPassword = page.locator('#input-password');
        this.btnLogin = page.locator('input[value="Login"]');
        this.txtErrorMessage = page.locator('.alert.alert-danger.alert-dismissible');
        this.lnkForgotPassword = page.locator('a:has-text("Forgotten Password")');
    }

    /**
     * Sets the email address in the email field
     * @param email - Email address to enter
     */
    async setEmail(email: string): Promise<void> {
        await this.txtEmailAddress.fill(email);
    }

    /**
     * Sets the password in the password field
     * @param pwd - Password to enter
     */
    async setPassword(pwd: string): Promise<void> {
        await this.txtPassword.fill(pwd);
    }

    /**
     * Clicks the login button
     */
    async clickLogin(): Promise<void> {
        await this.btnLogin.click();
    }

    /**
     * Performs complete login action with a single method call
     * @param email - Email address to enter
     * @param password - Password to enter
     */
    async login(email: string, password: string): Promise<void> {
        await this.setEmail(email);
        await this.setPassword(password);
        await this.clickLogin();
    }

    /**
     * Returns the login error message text
     * @returns Promise<string | null> - Error message or null if not present
     */
    async getLoginErrorMessage(): Promise<string | null> {
        return this.txtErrorMessage.textContent();
    }

    /**
     * Checks if an error message is visible on the login page
     * @returns Promise<boolean>
     */
    async isLoginErrorVisible(): Promise<boolean> {
        try {
            await expect(this.txtErrorMessage).toBeVisible({ timeout: 3000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Clicks the "Forgotten Password" link
     */
    async clickForgotPassword(): Promise<void> {
        await this.lnkForgotPassword.click();
    }
}
