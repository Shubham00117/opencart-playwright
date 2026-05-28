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
