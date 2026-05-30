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
