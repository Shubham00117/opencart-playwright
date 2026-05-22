import { Page, expect, Locator } from '@playwright/test';

/**
 * HomePage - Page Object for the OpenCart Home page.
 * Handles navigation, search, and general home page interactions.
 */
export class HomePage {
    private readonly page: Page;

    // Locators
    private readonly lnkMyAccount: Locator;
    private readonly lnkRegister: Locator;
    private readonly linkLogin: Locator;
    private readonly txtSearchbox: Locator;
    private readonly btnSearch: Locator;
    private readonly btnwishlist: Locator;
    private readonly lnkCart: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.lnkMyAccount = page.locator('span:has-text("My Account")');
        this.lnkRegister = page.locator('a:has-text("Register")');
        this.linkLogin = page.locator('a:has-text("Login")');
        this.txtSearchbox = page.locator('input[placeholder="Search"]');
        this.btnSearch = page.locator('#search button[type="button"]');
        this.btnwishlist = page.locator(':text("Wish List (0)")');
        this.lnkCart = page.locator('#cart > button');
    }

    /**
     * Checks if the HomePage title exists
     * @returns Promise<boolean>
     */
    async isHomePageExists(): Promise<boolean> {
        const title: string = await this.page.title();
        return Boolean(title);
    }

    /**
     * Click "My Account" link
     */
    async clickMyAccount(): Promise<void> {
        try {
            await this.lnkMyAccount.click();
        } catch (error) {
            console.error(`Exception occurred while clicking 'My Account': ${error}`);
            throw error;
        }
    }

    /**
     * Click "Register" link
     */
    async clickRegister(): Promise<void> {
        try {
            await this.lnkRegister.click();
        } catch (error) {
            console.error(`Exception occurred while clicking 'Register': ${error}`);
            throw error;
        }
    }

    /**
     * Click "Login" link
     */
    async clickLogin(): Promise<void> {
        try {
            await this.linkLogin.click();
        } catch (error) {
            console.error(`Exception occurred while clicking 'Login': ${error}`);
            throw error;
        }
    }

    /**
     * Enter product name in the search box
     * @param pName - Product name to search for
     */
    async enterProductName(pName: string): Promise<void> {
        try {
            await this.txtSearchbox.fill(pName);
        } catch (error) {
            console.error(`Exception occurred while entering product name: ${error}`);
            throw error;
        }
    }

    /**
     * Click the search button
     */
    async clickSearch(): Promise<void> {
        try {
            await this.btnSearch.click();
        } catch (error) {
            console.error(`Exception occurred while clicking 'Search': ${error}`);
            throw error;
        }
    }

    /**
     * Click the Wish List button
     */
    async clickWishlist(): Promise<void> {
        try {
            await this.btnwishlist.click();
        } catch (error) {
            console.error(`Exception occurred while clicking 'Wishlist': ${error}`);
            throw error;
        }
    }

    /**
     * Click the Cart button to open cart dropdown
     */
    async clickCart(): Promise<void> {
        try {
            await this.lnkCart.click();
        } catch (error) {
            console.error(`Exception occurred while clicking 'Cart': ${error}`);
            throw error;
        }
    }

    /**
     * Navigate to the login page directly
     */
    async navigateToLogin(): Promise<void> {
        await this.clickMyAccount();
        await this.clickLogin();
    }

    /**
     * Search for a product using search box
     * @param productName - Product name to search
     */
    async searchProduct(productName: string): Promise<void> {
        await this.enterProductName(productName);
        await this.clickSearch();
    }
}
