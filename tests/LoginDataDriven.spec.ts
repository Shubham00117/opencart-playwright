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
