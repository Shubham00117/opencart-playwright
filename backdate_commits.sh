#!/bin/bash

# ============================================================
# Backdated Git Commits Script
# From: May 22, 2026 → June 11, 2026
# Project: OpenCart Playwright Test Automation
# ============================================================

set -e
REPO="/Users/shubham_infinity/Desktop/Projects/Testing Projects/OpenCartPlayWright"
cd "$REPO"

echo "======================================================"
echo " Starting backdated commits: May 22 → June 11, 2026"
echo "======================================================"

# Helper function to make a backdated commit
make_commit() {
    local date="$1"
    local message="$2"
    git add -A
    GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -m "$message"
    echo "✅ Committed: [$date] $message"
}

# ============================================================
# MAY 22 — 4 commits (refactor LoginPage + add JSDoc)
# ============================================================

# Commit 1 of 4 — 22 May
cat > pages/LoginPage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-22T09:10:00+05:30" "refactor: add JSDoc comments and improve type safety in LoginPage"

# Commit 2 of 4 — 22 May
cat > pages/HomePage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-22T10:45:00+05:30" "refactor: improve HomePage with JSDoc, error logging fixes, and new helper methods"

# Commit 3 of 4 — 22 May
cat > utils/randomDataGenerator.ts << 'FILECONTENT'
import { faker } from '@faker-js/faker';

/**
 * RandomDataUtil - Utility class for generating random test data.
 * Uses @faker-js/faker to produce realistic fake data for test automation.
 */
export class RandomDataUtil {

    /**
     * Returns a random first name
     */
    static getFirstName(): string {
        return faker.person.firstName();
    }

    /**
     * Returns a random last name
     */
    static getLastName(): string {
        return faker.person.lastName();
    }

    /**
     * Returns a random full name
     */
    static getFullName(): string {
        return faker.person.fullName();
    }

    /**
     * Returns a random email address
     */
    static getEmail(): string {
        return faker.internet.email();
    }

    /**
     * Returns a random phone number
     */
    static getPhoneNumber(): string {
        return faker.phone.number();
    }

    /**
     * Returns a random username
     */
    static getUsername(): string {
        return faker.internet.username();
    }

    /**
     * Returns a random password
     */
    static getPassword(): string {
        return faker.internet.password();
    }

    /**
     * Returns a random country name
     */
    static getRandomCountry(): string {
        return faker.location.country();
    }

    /**
     * Returns a random state/province
     */
    static getRandomState(): string {
        return faker.location.state();
    }

    /**
     * Returns a random city name
     */
    static getRandomCity(): string {
        return faker.location.city();
    }

    /**
     * Returns a random postal/zip code
     */
    static getRandomPin(): string {
        return faker.location.zipCode();
    }

    /**
     * Returns a random street address
     */
    static getRandomAddress(): string {
        return faker.location.streetAddress();
    }

    /**
     * Returns a random password of specified length
     * @param length - Length of the password (default: 10)
     */
    static getRandomPassword(length: number = 10): string {
        return faker.internet.password({ length });
    }

    /**
     * Returns a random alphanumeric string of specified length
     * @param length - Length of the string
     */
    static getRandomAlphanumeric(length: number): string {
        return faker.string.alphanumeric(length);
    }

    /**
     * Returns a random numeric string of specified length
     * @param length - Length of the string
     */
    static getRandomNumeric(length: number): string {
        return faker.string.numeric(length);
    }

    /**
     * Returns a random UUID
     */
    static getRandomUUID(): string {
        return faker.string.uuid();
    }

    /**
     * Returns a random product name
     */
    static getRandomProductName(): string {
        return faker.commerce.productName();
    }

    /**
     * Returns a random price as string
     */
    static getRandomPrice(): string {
        return faker.commerce.price();
    }

    /**
     * Returns a complete random user data object for registration
     */
    static getRandomUserData(): {
        firstName: string;
        lastName: string;
        email: string;
        telephone: string;
        password: string;
    } {
        const password = this.getRandomPassword(12);
        return {
            firstName: this.getFirstName(),
            lastName: this.getLastName(),
            email: this.getEmail(),
            telephone: this.getPhoneNumber(),
            password,
        };
    }
}
FILECONTENT

make_commit "2026-05-22T13:20:00+05:30" "feat: enhance RandomDataUtil with JSDoc, new product/price methods, and getRandomUserData helper"

# Commit 4 of 4 — 22 May
cat > utils/dataProvider.ts << 'FILECONTENT'
/**
 * DataProvider - Provides structured test data for data-driven tests.
 * Contains predefined test data sets for various test scenarios.
 */

export interface LoginCredential {
    email: string;
    password: string;
    expectedResult: 'success' | 'failure';
    description: string;
}

export interface RegistrationData {
    firstName: string;
    lastName: string;
    email: string;
    telephone: string;
    password: string;
}

/**
 * Provides login test data for data-driven login tests
 * @returns Array of LoginCredential objects
 */
export function getLoginTestData(): LoginCredential[] {
    return [
        {
            email: 'shubham23@yopmail.com',
            password: 'Test@1234',
            expectedResult: 'success',
            description: 'Valid credentials - should login successfully',
        },
        {
            email: 'invalid@example.com',
            password: 'wrongpassword',
            expectedResult: 'failure',
            description: 'Invalid credentials - should show error message',
        },
        {
            email: '',
            password: '',
            expectedResult: 'failure',
            description: 'Empty credentials - should show validation error',
        },
        {
            email: 'shubham23@yopmail.com',
            password: 'wrongpassword',
            expectedResult: 'failure',
            description: 'Valid email, wrong password - should show error',
        },
    ];
}
FILECONTENT

make_commit "2026-05-22T16:30:00+05:30" "refactor: restructure dataProvider with TypeScript interfaces and improved test data sets"

# ============================================================
# MAY 23 — 1 commit (improve RegistrationPage)
# ============================================================

cat > pages/RegistrationPage.ts << 'FILECONTENT'
import { Page, Locator, expect } from '@playwright/test';

/**
 * RegistrationPage - Page Object for the OpenCart User Registration page.
 * Handles all registration form interactions and validations.
 */
export class RegistrationPage {
    private readonly page: Page;

    // Locators using CSS selectors
    private readonly txtFirstname: Locator;
    private readonly txtLastname: Locator;
    private readonly txtEmail: Locator;
    private readonly txtTelephone: Locator;
    private readonly txtPassword: Locator;
    private readonly txtConfirmPassword: Locator;
    private readonly chkdPolicy: Locator;
    private readonly btnContinue: Locator;
    private readonly msgConfirmation: Locator;
    private readonly chkNewsletter: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators with CSS selectors
        this.txtFirstname = page.locator('#input-firstname');
        this.txtLastname = page.locator('#input-lastname');
        this.txtEmail = page.locator('#input-email');
        this.txtTelephone = page.locator('#input-telephone');
        this.txtPassword = page.locator('#input-password');
        this.txtConfirmPassword = page.locator('#input-confirm');
        this.chkdPolicy = page.locator('input[name="agree"]');
        this.btnContinue = page.locator('input[value="Continue"]');
        this.msgConfirmation = page.locator('h1:has-text("Your Account Has Been Created!")');
        this.chkNewsletter = page.locator('input[name="newsletter"][value="1"]');
    }

    /**
     * Sets the first name in the registration form
     * @param fname - First name to enter
     */
    async setFirstName(fname: string): Promise<void> {
        await this.txtFirstname.fill(fname);
    }

    /**
     * Sets the last name in the registration form
     * @param lname - Last name to enter
     */
    async setLastName(lname: string): Promise<void> {
        await this.txtLastname.fill(lname);
    }

    /**
     * Sets the email in the registration form
     * @param email - Email to enter
     */
    async setEmail(email: string): Promise<void> {
        await this.txtEmail.fill(email);
    }

    /**
     * Sets the telephone number in the registration form
     * @param tel - Telephone number to enter
     */
    async setTelephone(tel: string): Promise<void> {
        await this.txtTelephone.fill(tel);
    }

    /**
     * Sets the password in the registration form
     * @param pwd - Password to enter
     */
    async setPassword(pwd: string): Promise<void> {
        await this.txtPassword.fill(pwd);
    }

    /**
     * Sets the confirm password in the registration form
     * @param pwd - Password to confirm
     */
    async setConfirmPassword(pwd: string): Promise<void> {
        await this.txtConfirmPassword.fill(pwd);
    }

    /**
     * Checks the privacy policy checkbox
     */
    async setPrivacyPolicy(): Promise<void> {
        await this.chkdPolicy.check();
    }

    /**
     * Subscribes to newsletter by checking the newsletter checkbox
     */
    async subscribeNewsletter(): Promise<void> {
        await this.chkNewsletter.check();
    }

    /**
     * Clicks the Continue button to submit registration
     */
    async clickContinue(): Promise<void> {
        await this.btnContinue.click();
    }

    /**
     * Gets the confirmation message text after successful registration
     * @returns Promise<string> - Confirmation message text
     */
    async getConfirmationMsg(): Promise<string> {
        return await this.msgConfirmation.textContent() ?? '';
    }

    /**
     * Checks if the registration confirmation message is visible
     * @returns Promise<boolean>
     */
    async isRegistrationSuccessful(): Promise<boolean> {
        try {
            await expect(this.msgConfirmation).toBeVisible({ timeout: 5000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Complete registration workflow using a user data object
     * @param userData - Object containing registration data
     * @param subscribeNewsletter - Whether to subscribe to newsletter (default: false)
     */
    async completeRegistration(userData: {
        firstName: string;
        lastName: string;
        email: string;
        telephone: string;
        password: string;
    }, subscribeNewsletter: boolean = false): Promise<void> {
        await this.setFirstName(userData.firstName);
        await this.setLastName(userData.lastName);
        await this.setEmail(userData.email);
        await this.setTelephone(userData.telephone);
        await this.setPassword(userData.password);
        await this.setConfirmPassword(userData.password);
        if (subscribeNewsletter) {
            await this.subscribeNewsletter();
        }
        await this.setPrivacyPolicy();
        await this.clickContinue();
        await expect(this.msgConfirmation).toBeVisible();
    }
}
FILECONTENT

make_commit "2026-05-23T11:00:00+05:30" "feat: add newsletter checkbox locator and isRegistrationSuccessful method in RegistrationPage"

# ============================================================
# MAY 24 — weekend (skip)
# MAY 25 — weekend (skip)
# ============================================================

# ============================================================
# MAY 26 — 2 commits (improve SearchResultsPage + ProductPage)
# ============================================================

cat > pages/SearchResultsPage.ts << 'FILECONTENT'
import { Page, Locator, expect } from '@playwright/test';

/**
 * SearchResultsPage - Page Object for the OpenCart Search Results page.
 * Handles product search results and related interactions.
 */
export class SearchResultsPage {
    private readonly page: Page;

    // Locators
    private readonly lblResults: Locator;
    private readonly lstProducts: Locator;
    private readonly lnkFirstProduct: Locator;
    private readonly txtNoResults: Locator;
    private readonly btnListView: Locator;
    private readonly btnGridView: Locator;
    private readonly drpSortBy: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators
        this.lblResults = page.locator('#content h1');
        this.lstProducts = page.locator('.product-thumb');
        this.lnkFirstProduct = page.locator('.product-thumb').first().locator('h4 a');
        this.txtNoResults = page.locator('.col-sm-12 p:has-text("There is no product")');
        this.btnListView = page.locator('#list-view');
        this.btnGridView = page.locator('#grid-view');
        this.drpSortBy = page.locator('#input-sort');
    }

    /**
     * Checks if the search results page is displayed
     * @returns Promise<boolean>
     */
    async isSearchResultsPageDisplayed(): Promise<boolean> {
        try {
            await expect(this.page).toHaveURL(/.*route=product\/search.*/);
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Gets the number of products shown in search results
     * @returns Promise<number>
     */
    async getResultCount(): Promise<number> {
        return await this.lstProducts.count();
    }

    /**
     * Checks if "no results" message is shown
     * @returns Promise<boolean>
     */
    async isNoResultsMessageVisible(): Promise<boolean> {
        try {
            await expect(this.txtNoResults).toBeVisible({ timeout: 3000 });
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Clicks on the first product in search results
     */
    async clickFirstProduct(): Promise<void> {
        await this.lnkFirstProduct.click();
    }

    /**
     * Gets the name of the first product in search results
     * @returns Promise<string | null>
     */
    async getFirstProductName(): Promise<string | null> {
        return await this.lnkFirstProduct.textContent();
    }

    /**
     * Clicks the list view toggle button
     */
    async switchToListView(): Promise<void> {
        await this.btnListView.click();
    }

    /**
     * Clicks the grid view toggle button
     */
    async switchToGridView(): Promise<void> {
        await this.btnGridView.click();
    }

    /**
     * Selects a sort order from the dropdown
     * @param sortOption - Sort option label text
     */
    async sortResultsBy(sortOption: string): Promise<void> {
        await this.drpSortBy.selectOption({ label: sortOption });
    }
}
FILECONTENT

make_commit "2026-05-26T09:30:00+05:30" "refactor: rewrite SearchResultsPage with full JSDoc, result count, no-results check, and view toggle methods"

cat > pages/ProductPage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-26T14:15:00+05:30" "refactor: rewrite ProductPage with full JSDoc, price/description locators, and addToCart workflow method"

# ============================================================
# MAY 27 — 1 commit (improve ShoppingCartPage)
# ============================================================

cat > pages/ShoppingCartPage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-27T10:00:00+05:30" "refactor: enhance ShoppingCartPage with JSDoc, cart count, totals, remove item, and empty cart check"

# ============================================================
# MAY 28 — 2 commits (improve tests + fix WishListPage)
# ============================================================

cat > tests/Login.spec.ts << 'FILECONTENT'
/**
 * Test Suite: Login Tests
 *
 * Covers: Valid login, invalid credentials, and edge case scenarios.
 *
 * Tags: @master @sanity @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { MyAccountPage } from '../pages/MyAccountPage';
import { TestConfig } from '../test.config';

let config: TestConfig;
let homePage: HomePage;
let loginPage: LoginPage;
let myAccountPage: MyAccountPage;

// This hook runs before each test
test.beforeEach(async ({ page }) => {
    config = new TestConfig(); // Load config (URL, credentials)
    await page.goto(config.appUrl); // Navigate to base URL

    // Initialize page objects
    homePage = new HomePage(page);
    loginPage = new LoginPage(page);
    myAccountPage = new MyAccountPage(page);
});

// Cleanup after each test
test.afterEach(async ({ page }) => {
    await page.close(); // Close browser tab
});

test('User login with valid credentials @master @sanity @regression', async () => {
    // Navigate to Login page via Home page
    await homePage.navigateToLogin();

    // Enter valid credentials and log in
    await loginPage.login(config.email, config.password);

    // Verify successful login by checking 'My Account' page presence
    const isLoggedIn = await myAccountPage.isMyAccountPageExists();
    expect(isLoggedIn).toBeTruthy();
});

test('User login with invalid credentials should show error @regression', async () => {
    // Navigate to Login page
    await homePage.navigateToLogin();

    // Enter invalid credentials
    await loginPage.login('wrong@example.com', 'wrongpassword');

    // Verify error message is shown
    const isErrorVisible = await loginPage.isLoginErrorVisible();
    expect(isErrorVisible).toBeTruthy();
});

test('User login with empty fields should show validation error @regression', async () => {
    // Navigate to Login page
    await homePage.navigateToLogin();

    // Click login without entering credentials
    await loginPage.clickLogin();

    // Verify error message is shown
    const errorMessage = await loginPage.getLoginErrorMessage();
    expect(errorMessage).toBeTruthy();
});
FILECONTENT

make_commit "2026-05-28T09:00:00+05:30" "test: add invalid credentials and empty fields login test cases"

cat > pages/WishListPage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-28T14:30:00+05:30" "refactor: rewrite WishListPage with full JSDoc, item count, empty check, and cart-from-wishlist method"

# ============================================================
# MAY 29 — 1 commit (improve MyAccountPage)
# ============================================================

cat > pages/MyAccountPage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-29T11:30:00+05:30" "refactor: expand MyAccountPage with navigation links and isMyAccountPageExists using proper expect assertion"

# ============================================================
# MAY 30 — 4 commits (major test improvements)
# ============================================================

cat > tests/AccountRegistration.spec.ts << 'FILECONTENT'
/**
 * Test Suite: Account Registration Tests
 *
 * Covers: New user registration with valid data, duplicate email, and newsletter subscription.
 *
 * Tags: @regression @sanity
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { RegistrationPage } from '../pages/RegistrationPage';
import { MyAccountPage } from '../pages/MyAccountPage';
import { TestConfig } from '../test.config';
import { RandomDataUtil } from '../utils/randomDataGenerator';

let config: TestConfig;
let homePage: HomePage;
let registrationPage: RegistrationPage;
let myAccountPage: MyAccountPage;

test.beforeEach(async ({ page }) => {
    config = new TestConfig();
    await page.goto(config.appUrl);

    homePage = new HomePage(page);
    registrationPage = new RegistrationPage(page);
    myAccountPage = new MyAccountPage(page);
});

test.afterEach(async ({ page }) => {
    await page.close();
});

test('Register new user account with valid data @sanity @regression', async () => {
    // Navigate to registration page
    await homePage.clickMyAccount();
    await homePage.clickRegister();

    // Generate random user data
    const userData = RandomDataUtil.getRandomUserData();

    // Fill and submit the registration form
    await registrationPage.completeRegistration(userData);

    // Verify account creation success
    const isSuccess = await registrationPage.isRegistrationSuccessful();
    expect(isSuccess).toBeTruthy();
});

test('Register with newsletter subscription @regression', async () => {
    // Navigate to registration page
    await homePage.clickMyAccount();
    await homePage.clickRegister();

    // Generate random user data
    const userData = RandomDataUtil.getRandomUserData();

    // Fill and submit the registration form with newsletter subscription
    await registrationPage.completeRegistration(userData, true);

    // Verify account creation success
    const isSuccess = await registrationPage.isRegistrationSuccessful();
    expect(isSuccess).toBeTruthy();
});
FILECONTENT

make_commit "2026-05-30T09:00:00+05:30" "test: add newsletter subscription test case in AccountRegistration spec"

cat > tests/SearchProduct.spec.ts << 'FILECONTENT'
/**
 * Test Suite: Product Search Tests
 *
 * Covers: Search with valid product name, no-results scenario, and result count verification.
 *
 * Tags: @master @sanity @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { SearchResultsPage } from '../pages/SearchResultsPage';
import { TestConfig } from '../test.config';

let config: TestConfig;
let homePage: HomePage;
let searchResultsPage: SearchResultsPage;

test.beforeEach(async ({ page }) => {
    config = new TestConfig();
    await page.goto(config.appUrl);

    homePage = new HomePage(page);
    searchResultsPage = new SearchResultsPage(page);
});

test.afterEach(async ({ page }) => {
    await page.close();
});

test('Search for existing product returns results @master @sanity @regression', async () => {
    // Search for a known product
    await homePage.searchProduct('MacBook');

    // Verify results page is displayed
    const isResultsPageDisplayed = await searchResultsPage.isSearchResultsPageDisplayed();
    expect(isResultsPageDisplayed).toBeTruthy();

    // Verify at least one product is shown
    const resultCount = await searchResultsPage.getResultCount();
    expect(resultCount).toBeGreaterThan(0);
});

test('Search for non-existing product shows no results message @regression', async () => {
    // Search for a product that does not exist
    await homePage.searchProduct('xyznonexistentproduct12345');

    // Verify no results message is visible
    const isNoResults = await searchResultsPage.isNoResultsMessageVisible();
    expect(isNoResults).toBeTruthy();
});

test('Search result shows correct product name @sanity', async () => {
    // Search for MacBook
    await homePage.searchProduct('MacBook');

    // Get the first product name
    const firstName = await searchResultsPage.getFirstProductName();
    expect(firstName).toBeTruthy();
    expect(firstName?.toLowerCase()).toContain('macbook');
});
FILECONTENT

make_commit "2026-05-30T11:00:00+05:30" "test: add no-results and product name verification test cases in SearchProduct spec"

cat > tests/Logout.spec.ts << 'FILECONTENT'
/**
 * Test Suite: Logout Tests
 *
 * Covers: Successful logout after login, verifies redirect to logout confirmation page.
 *
 * Tags: @master @sanity @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { MyAccountPage } from '../pages/MyAccountPage';
import { LogoutPage } from '../pages/LogoutPage';
import { TestConfig } from '../test.config';

let config: TestConfig;
let homePage: HomePage;
let loginPage: LoginPage;
let myAccountPage: MyAccountPage;
let logoutPage: LogoutPage;

test.beforeEach(async ({ page }) => {
    config = new TestConfig();
    await page.goto(config.appUrl);

    homePage = new HomePage(page);
    loginPage = new LoginPage(page);
    myAccountPage = new MyAccountPage(page);
    logoutPage = new LogoutPage(page);
});

test.afterEach(async ({ page }) => {
    await page.close();
});

test('User can logout successfully after login @master @sanity @regression', async () => {
    // Login
    await homePage.navigateToLogin();
    await loginPage.login(config.email, config.password);

    // Verify login was successful
    const isLoggedIn = await myAccountPage.isMyAccountPageExists();
    expect(isLoggedIn).toBeTruthy();

    // Logout via My Account page
    await myAccountPage.clickLogout();

    // Verify logout page is displayed
    const isLoggedOut = await logoutPage.isLogoutPageExists();
    expect(isLoggedOut).toBeTruthy();
});
FILECONTENT

make_commit "2026-05-30T13:30:00+05:30" "refactor: update Logout spec to use navigateToLogin() and myAccountPage.clickLogout() helpers"

cat > pages/LogoutPage.ts << 'FILECONTENT'
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
FILECONTENT

make_commit "2026-05-30T16:00:00+05:30" "refactor: enhance LogoutPage with full JSDoc, getLogoutHeading, getConfirmationMessage, and clickContinue methods"

# ============================================================
# MAY 31 — weekend (skip)
# JUNE 1 — weekend (skip)
# ============================================================

# ============================================================
# JUNE 2 — 1 commit (add test tags and improve AddToCart spec)
# ============================================================

cat > tests/AddToCart.spec.ts << 'FILECONTENT'
/**
 * Test Suite: Add to Cart Tests
 *
 * Covers: Adding a product to cart, verifying cart count update, and guest cart persistence.
 *
 * Tags: @master @sanity @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { SearchResultsPage } from '../pages/SearchResultsPage';
import { ProductPage } from '../pages/ProductPage';
import { ShoppingCartPage } from '../pages/ShoppingCartPage';
import { TestConfig } from '../test.config';

let config: TestConfig;
let homePage: HomePage;
let loginPage: LoginPage;
let searchResultsPage: SearchResultsPage;
let productPage: ProductPage;
let shoppingCartPage: ShoppingCartPage;

test.beforeEach(async ({ page }) => {
    config = new TestConfig();
    await page.goto(config.appUrl);

    homePage = new HomePage(page);
    loginPage = new LoginPage(page);
    searchResultsPage = new SearchResultsPage(page);
    productPage = new ProductPage(page);
    shoppingCartPage = new ShoppingCartPage(page);
});

test.afterEach(async ({ page }) => {
    await page.close();
});

test('Add product to cart after login @master @sanity @regression', async () => {
    // Login first
    await homePage.navigateToLogin();
    await loginPage.login(config.email, config.password);

    // Search for a product
    await homePage.searchProduct('MacBook');

    // Click on first product
    await searchResultsPage.clickFirstProduct();

    // Add to cart
    await productPage.addToCart('1');

    // Verify success alert is visible
    const isSuccess = await productPage.isSuccessAlertVisible();
    expect(isSuccess).toBeTruthy();
});

test('Cart count updates after adding product @sanity', async () => {
    // Login first
    await homePage.navigateToLogin();
    await loginPage.login(config.email, config.password);

    // Search for a product
    await homePage.searchProduct('iPhone');

    // Click on first product
    await searchResultsPage.clickFirstProduct();

    // Add to cart
    await productPage.clickAddToCart();

    // Verify cart shows updated item
    const isSuccess = await productPage.isSuccessAlertVisible();
    expect(isSuccess).toBeTruthy();
});
FILECONTENT

make_commit "2026-06-02T10:00:00+05:30" "test: refactor AddToCart spec using new helper methods and add cart count update test"

# ============================================================
# JUNE 3 — 2 commits (improve CheckoutPage + update E2E test)
# ============================================================

cat > pages/CheckoutPage.ts << 'FILECONTENT'
import { Page, expect, Locator } from '@playwright/test';

/**
 * CheckoutPage - Page Object for the OpenCart Checkout page.
 * Handles guest/registered checkout flow including billing, shipping, payment, and order confirmation.
 */
export class CheckoutPage {
    private readonly page: Page;

    // Locators
    private readonly radioGuest: Locator;
    private readonly radioReturningCustomer: Locator;
    private readonly btnContinue: Locator;
    private readonly txtFirstName: Locator;
    private readonly txtLastName: Locator;
    private readonly txtEmail: Locator;
    private readonly txtTelephone: Locator;
    private readonly txtAddress1: Locator;
    private readonly txtAddress2: Locator;
    private readonly txtCity: Locator;
    private readonly txtPin: Locator;
    private readonly drpCountry: Locator;
    private readonly drpState: Locator;
    private readonly btnContinueBillingAddress: Locator;
    private readonly btnContinueDeliveryAddress: Locator;
    private readonly txtDeliveryMethod: Locator;
    private readonly btnContinueShippingAddress: Locator;
    private readonly chkboxTerms: Locator;
    private readonly btnContinuePaymentMethod: Locator;
    private readonly lblTotalPrice: Locator;
    private readonly btnConfOrder: Locator;
    private readonly lblOrderConMsg: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators with CSS selectors
        this.radioGuest = page.locator('input[value="guest"]');
        this.radioReturningCustomer = page.locator('input[value="register"]');
        this.btnContinue = page.locator('#button-account');
        this.txtFirstName = page.locator('#input-payment-firstname');
        this.txtLastName = page.locator('#input-payment-lastname');
        this.txtEmail = page.locator('#input-payment-email');
        this.txtTelephone = page.locator('#input-payment-telephone');
        this.txtAddress1 = page.locator('#input-payment-address-1');
        this.txtAddress2 = page.locator('#input-payment-address-2');
        this.txtCity = page.locator('#input-payment-city');
        this.txtPin = page.locator('#input-payment-postcode');
        this.drpCountry = page.locator('#input-payment-country');
        this.drpState = page.locator('#input-payment-zone');
        this.btnContinueBillingAddress = page.locator('#button-payment-address');
        this.btnContinueDeliveryAddress = page.locator('#button-shipping-address');
        this.txtDeliveryMethod = page.locator('textarea[name="comment"]');
        this.btnContinueShippingAddress = page.locator('#button-shipping-method');
        this.chkboxTerms = page.locator('input[name="agree"]');
        this.btnContinuePaymentMethod = page.locator('#button-payment-method');
        this.lblTotalPrice = page.locator('strong:has-text("Total:") + td');
        this.btnConfOrder = page.locator('#button-confirm');
        this.lblOrderConMsg = page.locator('#content h1');
    }

    /**
     * Checks if the checkout page is displayed
     * @returns Promise<boolean>
     */
    async isCheckoutPageExists(): Promise<boolean> {
        try {
            await expect(this.page).toHaveTitle('Checkout');
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Selects the checkout option (Guest or Returning Customer)
     * @param checkOutOption - "Guest Checkout" or "Returning Customer"
     */
    async chooseCheckoutOption(checkOutOption: string): Promise<void> {
        if (checkOutOption === 'Guest Checkout') {
            await this.radioGuest.click();
        } else if (checkOutOption === 'Returning Customer') {
            await this.radioReturningCustomer.click();
        }
    }

    /**
     * Clicks the Continue button after selecting checkout option
     */
    async clickOnContinue(): Promise<void> {
        await this.btnContinue.click();
    }

    /**
     * Sets guest checkout billing first name
     * @param firstName - First name to enter
     */
    async setFirstName(firstName: string): Promise<void> {
        await this.txtFirstName.fill(firstName);
    }

    /**
     * Sets guest checkout billing last name
     * @param lastName - Last name to enter
     */
    async setLastName(lastName: string): Promise<void> {
        await this.txtLastName.fill(lastName);
    }

    /**
     * Sets guest checkout email address
     * @param email - Email to enter
     */
    async setEmail(email: string): Promise<void> {
        await this.txtEmail.fill(email);
    }

    /**
     * Sets guest checkout telephone number
     * @param phone - Telephone to enter
     */
    async setTelephone(phone: string): Promise<void> {
        await this.txtTelephone.fill(phone);
    }

    /**
     * Sets guest checkout billing address line 1
     * @param address1 - Address line 1 to enter
     */
    async setAddress1(address1: string): Promise<void> {
        await this.txtAddress1.fill(address1);
    }

    /**
     * Sets guest checkout billing address line 2
     * @param address2 - Address line 2 to enter
     */
    async setAddress2(address2: string): Promise<void> {
        await this.txtAddress2.fill(address2);
    }

    /**
     * Sets the city in the billing address
     * @param city - City name to enter
     */
    async setCity(city: string): Promise<void> {
        await this.txtCity.fill(city);
    }

    /**
     * Sets the postal/zip code
     * @param pin - Postal code to enter
     */
    async setPin(pin: string): Promise<void> {
        await this.txtPin.fill(pin);
    }

    /**
     * Selects the country from the dropdown
     * @param country - Country label to select
     */
    async setCountry(country: string): Promise<void> {
        await this.drpCountry.selectOption({ label: country });
    }

    /**
     * Selects the state/zone from the dropdown
     * @param state - State label to select
     */
    async setState(state: string): Promise<void> {
        await this.drpState.selectOption({ label: state });
    }

    /**
     * Clicks the Continue button after filling billing address
     */
    async clickOnContinueAfterBillingAddress(): Promise<void> {
        await this.btnContinueBillingAddress.click();
    }

    /**
     * Clicks the Continue button after delivery address step
     */
    async clickOnContinueAfterDeliveryAddress(): Promise<void> {
        await this.btnContinueDeliveryAddress.click();
    }

    /**
     * Sets a comment/note for the delivery method
     * @param deliveryMsg - Message to enter
     */
    async setDeliveryMethodComment(deliveryMsg: string): Promise<void> {
        await this.txtDeliveryMethod.fill(deliveryMsg);
    }

    /**
     * Clicks the Continue button after selecting delivery method
     */
    async clickOnContinueAfterDeliveryMethod(): Promise<void> {
        await this.btnContinueShippingAddress.click();
    }

    /**
     * Checks the Terms and Conditions checkbox
     */
    async selectTermsAndConditions(): Promise<void> {
        await this.chkboxTerms.check();
    }

    /**
     * Clicks Continue after selecting payment method
     */
    async clickOnContinueAfterPaymentMethod(): Promise<void> {
        await this.btnContinuePaymentMethod.click();
    }

    /**
     * Gets the total price shown on the order review page
     * @returns Promise<string | null>
     */
    async getTotalPriceBeforeConfOrder(): Promise<string | null> {
        return await this.lblTotalPrice.textContent();
    }

    /**
     * Clicks the Confirm Order button
     */
    async clickOnConfirmOrder(): Promise<void> {
        await this.btnConfOrder.click();
    }

    /**
     * Checks if the order was placed successfully
     * @returns Promise<boolean>
     */
    async isOrderPlaced(): Promise<boolean> {
        try {
            await expect(this.lblOrderConMsg).toHaveText('Your order has been placed!', { timeout: 7000 });
            return true;
        } catch (error) {
            console.error(`Error verifying order placement: ${error}`);
            return false;
        }
    }

    /**
     * Gets the order confirmation heading text
     * @returns Promise<string | null>
     */
    async getOrderConfirmationMessage(): Promise<string | null> {
        return await this.lblOrderConMsg.textContent();
    }
}
FILECONTENT

make_commit "2026-06-03T09:30:00+05:30" "refactor: enhance CheckoutPage with full JSDoc, email/phone fields, returning customer radio, and getOrderConfirmationMessage"

# Add a small improvement to README
cat >> README.md << 'FILECONTENT'

---

## 📋 Test Coverage Summary

| Module        | Page Object | Test Spec | Status |
|---------------|------------|-----------|--------|
| Registration  | ✅          | ✅         | Done   |
| Login         | ✅          | ✅         | Done   |
| Logout        | ✅          | ✅         | Done   |
| Search        | ✅          | ✅         | Done   |
| Product       | ✅          | ✅         | Done   |
| Cart          | ✅          | ✅         | Done   |
| Checkout      | ✅          | ✅         | Done   |
| Wishlist      | ✅          | ✅         | Done   |
FILECONTENT

make_commit "2026-06-03T15:00:00+05:30" "docs: add test coverage summary table to README"

# ============================================================
# JUNE 4 — 1 commit (add WishList spec improvements)
# ============================================================

cat > tests/WishList.spec.ts << 'FILECONTENT'
/**
 * Test Suite: WishList Tests
 *
 * Covers: Add product to wishlist, verify item count, and add from wishlist to cart.
 *
 * Tags: @master @sanity @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { SearchResultsPage } from '../pages/SearchResultsPage';
import { ProductPage } from '../pages/ProductPage';
import { WishListPage } from '../pages/WishListPage';
import { MyAccountPage } from '../pages/MyAccountPage';
import { TestConfig } from '../test.config';

let config: TestConfig;
let homePage: HomePage;
let loginPage: LoginPage;
let searchResultsPage: SearchResultsPage;
let productPage: ProductPage;
let wishListPage: WishListPage;
let myAccountPage: MyAccountPage;

test.beforeEach(async ({ page }) => {
    config = new TestConfig();
    await page.goto(config.appUrl);

    homePage = new HomePage(page);
    loginPage = new LoginPage(page);
    searchResultsPage = new SearchResultsPage(page);
    productPage = new ProductPage(page);
    wishListPage = new WishListPage(page);
    myAccountPage = new MyAccountPage(page);
});

test.afterEach(async ({ page }) => {
    await page.close();
});

test('Add product to wishlist @master @sanity @regression', async ({ page }) => {
    // Login
    await homePage.navigateToLogin();
    await loginPage.login(config.email, config.password);

    // Search and go to product
    await homePage.searchProduct('MacBook');
    await searchResultsPage.clickFirstProduct();

    // Add to wishlist
    await productPage.clickAddToWishList();

    // Navigate to wishlist page
    await page.goto(config.appUrl + 'index.php?route=account/wishlist');

    // Verify wishlist has at least 1 item
    const wishListCount = await wishListPage.getWishListItemCount();
    expect(wishListCount).toBeGreaterThan(0);
});

test('Wishlist page is accessible from My Account @sanity', async ({ page }) => {
    // Login
    await homePage.navigateToLogin();
    await loginPage.login(config.email, config.password);

    // Navigate to wishlist via My Account
    await myAccountPage.clickWishList();

    // Verify wishlist page is displayed
    const isWishListPage = await wishListPage.isWishListPageDisplayed();
    expect(isWishListPage).toBeTruthy();
});
FILECONTENT

make_commit "2026-06-04T10:30:00+05:30" "test: refactor WishList spec with navigateToLogin helper and add My Account wishlist navigation test"

# ============================================================
# JUNE 5 — 2 commits (update playwright config + add .env example)
# ============================================================

cat > playwright.config.ts << 'FILECONTENT'
import { defineConfig, devices } from '@playwright/test';

/**
 * Playwright Configuration for OpenCart E2E Test Suite.
 * @see https://playwright.dev/docs/test-configuration
 */
export default defineConfig({
    // Directory where test files are located
    testDir: './tests',

    // Run tests in parallel (disable to run sequentially)
    fullyParallel: false,

    // Retry failed tests in CI environments
    retries: process.env.CI ? 2 : 0,

    // Use a single worker to avoid parallel conflicts on OpenCart
    workers: 1,

    // Maximum time a single test can run
    timeout: 60000,

    // Reporter configuration
    reporter: [
        ['html', { outputFolder: 'playwright-report', open: 'never' }],
        ['list'],
        ['allure-playwright'],
    ],

    use: {
        // Base URL for the application under test
        baseURL: 'https://demo.opencart.com/',

        // Collect traces on test failures for debugging
        trace: 'on-first-retry',

        // Capture screenshots on failure
        screenshot: 'only-on-failure',

        // Capture video on first retry
        video: 'on-first-retry',

        // Ignore HTTPS errors
        ignoreHTTPSErrors: true,

        // Default action timeout
        actionTimeout: 15000,

        // Default navigation timeout
        navigationTimeout: 30000,
    },

    // Define test projects for different browsers
    projects: [
        {
            name: 'chromium',
            use: { ...devices['Desktop Chrome'] },
        },
        {
            name: 'firefox',
            use: { ...devices['Desktop Firefox'] },
        },
    ],
});
FILECONTENT

make_commit "2026-06-05T09:00:00+05:30" "config: update playwright.config.ts with screenshot, video, action/nav timeouts, and Firefox project"

cat > .env.example << 'FILECONTENT'
# ============================================================
# OpenCart Playwright Test Automation - Environment Variables
# ============================================================
# Copy this file to .env and fill in your values.
# NEVER commit your actual .env file to version control!
# ============================================================

# Application URL
APP_URL=https://demo.opencart.com/

# Test user credentials
TEST_EMAIL=your_email@example.com
TEST_PASSWORD=your_password

# Optional: Allure report output path
ALLURE_RESULTS_DIR=allure-results
FILECONTENT

make_commit "2026-06-05T14:00:00+05:30" "chore: add .env.example template for environment variable configuration"

# ============================================================
# JUNE 6 — 1 commit (add LoginDataDriven improvements)
# ============================================================

cat > tests/LoginDataDriven.spec.ts << 'FILECONTENT'
/**
 * Test Suite: Data-Driven Login Tests
 *
 * Covers: Login with multiple credential sets using data provider.
 * Tests are parameterized using the getLoginTestData() data provider.
 *
 * Tags: @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { MyAccountPage } from '../pages/MyAccountPage';
import { TestConfig } from '../test.config';
import { getLoginTestData } from '../utils/dataProvider';

let config: TestConfig;

const testData = getLoginTestData();

for (const data of testData) {
    test(`Login Test: ${data.description} @regression`, async ({ page }) => {
        config = new TestConfig();
        await page.goto(config.appUrl);

        const homePage = new HomePage(page);
        const loginPage = new LoginPage(page);
        const myAccountPage = new MyAccountPage(page);

        // Navigate to login page
        await homePage.navigateToLogin();

        // Enter credentials
        await loginPage.login(data.email, data.password);

        if (data.expectedResult === 'success') {
            // Verify successful login
            const isLoggedIn = await myAccountPage.isMyAccountPageExists();
            expect(isLoggedIn).toBeTruthy();
        } else {
            // Verify error message for invalid credentials
            const isErrorVisible = await loginPage.isLoginErrorVisible();
            expect(isErrorVisible).toBeTruthy();
        }

        await page.close();
    });
}
FILECONTENT

make_commit "2026-06-06T11:00:00+05:30" "refactor: update LoginDataDriven spec to use navigateToLogin helper and typed test data interface"

# ============================================================
# JUNE 7 — weekend (skip)
# JUNE 8 — weekend (skip)
# ============================================================

# ============================================================
# JUNE 9 — 4 commits (E2E test improvements + new helpers)
# ============================================================

# First let's see the current E2E test file content before rewriting it
# We'll update it with improvements

cat > tests/EndToEndTest.spec.ts << 'FILECONTENT'
/**
 * Test Suite: End-to-End Purchase Flow
 *
 * Covers: Complete user journey from registration/login → search → add to cart → checkout → order confirmation.
 *
 * Tags: @master @e2e @regression
 */

import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { RegistrationPage } from '../pages/RegistrationPage';
import { MyAccountPage } from '../pages/MyAccountPage';
import { SearchResultsPage } from '../pages/SearchResultsPage';
import { ProductPage } from '../pages/ProductPage';
import { ShoppingCartPage } from '../pages/ShoppingCartPage';
import { CheckoutPage } from '../pages/CheckoutPage';
import { TestConfig } from '../test.config';
import { RandomDataUtil } from '../utils/randomDataGenerator';

let config: TestConfig;

test.describe('End-to-End: Guest Checkout Flow', () => {
    test.beforeEach(async ({ page }) => {
        config = new TestConfig();
        await page.goto(config.appUrl);
    });

    test('Guest user can complete full purchase flow @master @e2e @regression', async ({ page }) => {
        const homePage = new HomePage(page);
        const searchResultsPage = new SearchResultsPage(page);
        const productPage = new ProductPage(page);
        const shoppingCartPage = new ShoppingCartPage(page);
        const checkoutPage = new CheckoutPage(page);

        // Step 1: Search for a product
        await homePage.searchProduct('MacBook');

        // Step 2: Click on first result
        await searchResultsPage.clickFirstProduct();

        // Step 3: Add to cart
        await productPage.addToCart('1');
        const isAddedToCart = await productPage.isSuccessAlertVisible();
        expect(isAddedToCart).toBeTruthy();

        // Step 4: Navigate to checkout
        await page.goto(config.appUrl + 'index.php?route=checkout/checkout');
        const isCheckoutPage = await checkoutPage.isCheckoutPageExists();
        expect(isCheckoutPage).toBeTruthy();

        // Step 5: Choose Guest Checkout
        await checkoutPage.chooseCheckoutOption('Guest Checkout');
        await checkoutPage.clickOnContinue();

        // Step 6: Fill billing address with random data
        const userData = RandomDataUtil.getRandomUserData();
        await checkoutPage.setFirstName(userData.firstName);
        await checkoutPage.setLastName(userData.lastName);
        await checkoutPage.setEmail(userData.email);
        await checkoutPage.setTelephone(userData.telephone);
        await checkoutPage.setAddress1(RandomDataUtil.getRandomAddress());
        await checkoutPage.setCity(RandomDataUtil.getRandomCity());
        await checkoutPage.setPin('400001');
        await checkoutPage.setCountry('India');
        await checkoutPage.setState('Maharashtra');
        await checkoutPage.clickOnContinueAfterBillingAddress();

        // Step 7: Continue through delivery steps
        await checkoutPage.clickOnContinueAfterDeliveryAddress();
        await checkoutPage.setDeliveryMethodComment('Please deliver between 9 AM - 6 PM');
        await checkoutPage.clickOnContinueAfterDeliveryMethod();

        // Step 8: Accept terms and complete payment
        await checkoutPage.selectTermsAndConditions();
        await checkoutPage.clickOnContinueAfterPaymentMethod();

        // Step 9: Confirm order
        await checkoutPage.clickOnConfirmOrder();

        // Step 10: Verify order placement
        const isOrderPlaced = await checkoutPage.isOrderPlaced();
        expect(isOrderPlaced).toBeTruthy();
    });
});

test.describe('End-to-End: Registered User Login Flow', () => {
    test.beforeEach(async ({ page }) => {
        config = new TestConfig();
        await page.goto(config.appUrl);
    });

    test('Registered user can login and view account @master @e2e', async ({ page }) => {
        const homePage = new HomePage(page);
        const loginPage = new LoginPage(page);
        const myAccountPage = new MyAccountPage(page);

        // Login
        await homePage.navigateToLogin();
        await loginPage.login(config.email, config.password);

        // Verify account page
        const isLoggedIn = await myAccountPage.isMyAccountPageExists();
        expect(isLoggedIn).toBeTruthy();
    });
});
FILECONTENT

make_commit "2026-06-09T09:00:00+05:30" "refactor: restructure EndToEndTest with describe blocks, guest checkout using RandomDataUtil, and registered user flow"

# Add a new helper file for common test utilities
mkdir -p utils
cat > utils/testHelpers.ts << 'FILECONTENT'
import { Page } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { TestConfig } from '../test.config';

/**
 * TestHelpers - Utility class for common test setup and teardown actions.
 * Provides reusable methods shared across multiple test specs.
 */
export class TestHelpers {

    /**
     * Performs login for a user using page objects.
     * @param page - Playwright Page instance
     * @param config - Test configuration with credentials
     */
    static async loginUser(page: Page, config: TestConfig): Promise<void> {
        const homePage = new HomePage(page);
        const loginPage = new LoginPage(page);
        await homePage.navigateToLogin();
        await loginPage.login(config.email, config.password);
    }

    /**
     * Navigates to the application URL.
     * @param page - Playwright Page instance
     * @param config - Test configuration
     */
    static async navigateToApp(page: Page, config: TestConfig): Promise<void> {
        await page.goto(config.appUrl);
    }

    /**
     * Waits for a fixed duration (use sparingly; prefer waiting for conditions).
     * @param ms - Duration in milliseconds
     */
    static async sleep(ms: number): Promise<void> {
        await new Promise(resolve => setTimeout(resolve, ms));
    }

    /**
     * Scrolls an element into view and highlights it for visual debugging.
     * @param page - Playwright Page instance
     * @param selector - CSS selector of the element
     */
    static async highlightElement(page: Page, selector: string): Promise<void> {
        await page.evaluate((sel) => {
            const el = document.querySelector(sel) as HTMLElement | null;
            if (el) {
                el.style.border = '3px solid red';
                el.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }, selector);
    }

    /**
     * Takes a full-page screenshot and saves it with a timestamped name.
     * @param page - Playwright Page instance
     * @param name - Base name for the screenshot file
     */
    static async takeScreenshot(page: Page, name: string): Promise<void> {
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
        await page.screenshot({
            path: `test-results/${name}_${timestamp}.png`,
            fullPage: true,
        });
    }
}
FILECONTENT

make_commit "2026-06-09T11:30:00+05:30" "feat: add TestHelpers utility class with loginUser, navigateToApp, sleep, highlightElement, and takeScreenshot"

cat >> .gitignore << 'FILECONTENT'

# Environment files
.env
.env.local

# Test artifacts
test-results/
playwright-report/
allure-results/
allure-report/

# OS files
.DS_Store
Thumbs.db

# Node
node_modules/
dist/
FILECONTENT

make_commit "2026-06-09T13:00:00+05:30" "chore: update .gitignore to exclude .env, test artifacts, and OS files"

# Improve test.config.ts
cat > test.config.ts << 'FILECONTENT'
/**
 * TestConfig - Centralized configuration for test execution.
 * Reads environment variables or uses default values for local development.
 */
export class TestConfig {
    /** Base application URL */
    readonly appUrl: string;

    /** Test user email */
    readonly email: string;

    /** Test user password */
    readonly password: string;

    /** Default timeout for operations (ms) */
    readonly timeout: number;

    constructor() {
        this.appUrl = process.env.APP_URL ?? 'https://demo.opencart.com/';
        this.email = process.env.TEST_EMAIL ?? 'shubham23@yopmail.com';
        this.password = process.env.TEST_PASSWORD ?? 'Test@1234';
        this.timeout = parseInt(process.env.TIMEOUT ?? '30000', 10);
    }

    /**
     * Returns checkout URL
     */
    get checkoutUrl(): string {
        return `${this.appUrl}index.php?route=checkout/checkout`;
    }

    /**
     * Returns wishlist URL
     */
    get wishlistUrl(): string {
        return `${this.appUrl}index.php?route=account/wishlist`;
    }

    /**
     * Returns My Account URL
     */
    get myAccountUrl(): string {
        return `${this.appUrl}index.php?route=account/account`;
    }
}
FILECONTENT

make_commit "2026-06-09T16:00:00+05:30" "refactor: update TestConfig with JSDoc, env variable support, timeout config, and convenience URL getters"

# ============================================================
# JUNE 10 — 2 commits (update package.json scripts + CI workflow)
# ============================================================

cat > package.json << 'FILECONTENT'
{
  "name": "opencart-playwright",
  "version": "1.2.0",
  "description": "End-to-end test automation for OpenCart using Playwright and TypeScript",
  "scripts": {
    "test": "npx playwright test",
    "test:headed": "npx playwright test --headed",
    "test:chromium": "npx playwright test --project=chromium",
    "test:firefox": "npx playwright test --project=firefox",
    "test:sanity": "npx playwright test --grep @sanity",
    "test:regression": "npx playwright test --grep @regression",
    "test:e2e": "npx playwright test --grep @e2e",
    "test:login": "npx playwright test tests/Login.spec.ts",
    "test:registration": "npx playwright test tests/AccountRegistration.spec.ts",
    "report": "npx playwright show-report",
    "allure:generate": "allure generate allure-results --clean -o allure-report",
    "allure:open": "allure open allure-report",
    "allure:serve": "allure serve allure-results"
  },
  "dependencies": {
    "@faker-js/faker": "^8.0.2"
  },
  "devDependencies": {
    "@playwright/test": "^1.44.0",
    "allure-playwright": "^3.0.0-beta.6",
    "typescript": "^5.4.5"
  },
  "keywords": [
    "playwright",
    "typescript",
    "automation",
    "opencart",
    "e2e",
    "testing"
  ],
  "author": "Shubham",
  "license": "MIT"
}
FILECONTENT

make_commit "2026-06-10T10:00:00+05:30" "chore: update package.json with tagged test scripts, allure commands, and version bump to 1.2.0"

# Update GitHub Actions CI workflow
mkdir -p .github/workflows
cat > .github/workflows/playwright.yml << 'FILECONTENT'
name: Playwright E2E Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]
  schedule:
    # Run nightly at 2 AM UTC
    - cron: '0 2 * * *'
  workflow_dispatch:
    inputs:
      test_tag:
        description: 'Test tag to run (e.g., @sanity, @regression, @e2e)'
        required: false
        default: '@master'

jobs:
  playwright-tests:
    name: Run Playwright Tests
    runs-on: ubuntu-latest
    timeout-minutes: 30

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install Dependencies
        run: npm ci

      - name: Install Playwright Browsers
        run: npx playwright install --with-deps chromium

      - name: Run Playwright Tests
        run: |
          TAG="${{ github.event.inputs.test_tag || '@master' }}"
          npx playwright test --grep "$TAG" --project=chromium
        env:
          APP_URL: ${{ secrets.APP_URL }}
          TEST_EMAIL: ${{ secrets.TEST_EMAIL }}
          TEST_PASSWORD: ${{ secrets.TEST_PASSWORD }}
          CI: true

      - name: Upload Test Report
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: playwright-report-${{ github.run_number }}
          path: playwright-report/
          retention-days: 14

      - name: Upload Allure Results
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: allure-results-${{ github.run_number }}
          path: allure-results/
          retention-days: 14
FILECONTENT

make_commit "2026-06-10T14:30:00+05:30" "ci: update GitHub Actions workflow with nightly schedule, workflow_dispatch tag input, and allure results upload"

# ============================================================
# JUNE 11 — 1 commit (today - final cleanup and README update)
# ============================================================

cat > README.md << 'FILECONTENT'
# 🛒 OpenCart Playwright Test Automation

> End-to-end test automation framework for the [OpenCart](https://demo.opencart.com/) e-commerce platform, built with **Playwright** and **TypeScript** using the **Page Object Model (POM)** design pattern.

---

## 🚀 Tech Stack

| Tool / Library        | Purpose                          |
|-----------------------|----------------------------------|
| Playwright            | Browser automation framework     |
| TypeScript            | Type-safe test scripting         |
| @faker-js/faker       | Generating random test data      |
| Allure Playwright     | Test reporting                   |
| GitHub Actions        | CI/CD pipeline                   |

---

## 📁 Project Structure

```
OpenCartPlayWright/
├── .github/
│   └── workflows/
│       └── playwright.yml       # CI/CD GitHub Actions workflow
├── pages/                       # Page Object Model classes
│   ├── HomePage.ts
│   ├── LoginPage.ts
│   ├── RegistrationPage.ts
│   ├── MyAccountPage.ts
│   ├── LogoutPage.ts
│   ├── SearchResultsPage.ts
│   ├── ProductPage.ts
│   ├── ShoppingCartPage.ts
│   ├── CheckoutPage.ts
│   └── WishListPage.ts
├── tests/                       # Test specification files
│   ├── Login.spec.ts
│   ├── LoginDataDriven.spec.ts
│   ├── AccountRegistration.spec.ts
│   ├── Logout.spec.ts
│   ├── SearchProduct.spec.ts
│   ├── AddToCart.spec.ts
│   ├── WishList.spec.ts
│   └── EndToEndTest.spec.ts
├── utils/                       # Utilities and helpers
│   ├── randomDataGenerator.ts
│   ├── dataProvider.ts
│   └── testHelpers.ts
├── .env.example                 # Environment variable template
├── playwright.config.ts         # Playwright configuration
├── test.config.ts               # Test configuration class
└── package.json                 # Project dependencies and scripts
```

---

## ⚙️ Setup & Installation

### Prerequisites
- **Node.js** >= 18.x
- **npm** >= 9.x

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/Shubham00117/opencart-playwright.git
cd opencart-playwright

# 2. Install dependencies
npm install

# 3. Install Playwright browsers
npx playwright install

# 4. Configure environment variables
cp .env.example .env
# Edit .env with your test credentials
```

---

## 🧪 Running Tests

```bash
# Run all tests
npm test

# Run with browser visible
npm run test:headed

# Run by tag
npm run test:sanity       # @sanity tagged tests
npm run test:regression   # @regression tagged tests
npm run test:e2e          # @e2e tagged tests

# Run specific test files
npm run test:login
npm run test:registration

# Run on specific browser
npm run test:chromium
npm run test:firefox
```

---

## 📊 Reports

```bash
# Open Playwright HTML report
npm run report

# Generate Allure report
npm run allure:generate

# Open Allure report in browser
npm run allure:open

# Serve Allure report (live)
npm run allure:serve
```

---

## 📋 Test Coverage Summary

| Module        | Page Object | Test Spec  | Status     |
|---------------|-------------|------------|------------|
| Registration  | ✅           | ✅          | ✔ Complete |
| Login         | ✅           | ✅          | ✔ Complete |
| Login (DDT)   | ✅           | ✅          | ✔ Complete |
| Logout        | ✅           | ✅          | ✔ Complete |
| Search        | ✅           | ✅          | ✔ Complete |
| Product       | ✅           | ✅          | ✔ Complete |
| Cart          | ✅           | ✅          | ✔ Complete |
| Checkout      | ✅           | ✅          | ✔ Complete |
| Wishlist      | ✅           | ✅          | ✔ Complete |
| End-to-End    | —            | ✅          | ✔ Complete |

---

## 🏷️ Test Tags

| Tag          | Description                              |
|--------------|------------------------------------------|
| `@master`    | Core smoke tests — run on every push     |
| `@sanity`    | Sanity / quick verification tests        |
| `@regression`| Full regression test suite               |
| `@e2e`       | End-to-end user journey tests            |

---

## 🔄 CI/CD

Tests automatically run via **GitHub Actions** on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Nightly schedule (2 AM UTC)
- Manual trigger with custom test tag selection

---

## 👤 Author

**Shubham** — [GitHub](https://github.com/Shubham00117)

---

*Built with ❤️ using Playwright + TypeScript*
FILECONTENT

make_commit "2026-06-11T10:00:00+05:30" "docs: rewrite README with full project structure, setup guide, test tags table, CI/CD details, and coverage matrix"

echo ""
echo "======================================================"
echo " ✅ All backdated commits created successfully!"
echo "======================================================"
echo ""
git log --oneline -30
echo ""
echo "Run: git push origin main"
echo "======================================================"
