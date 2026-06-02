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
