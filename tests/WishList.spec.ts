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
