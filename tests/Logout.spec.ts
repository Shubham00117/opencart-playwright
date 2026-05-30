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
