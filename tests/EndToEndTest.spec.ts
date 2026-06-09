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
