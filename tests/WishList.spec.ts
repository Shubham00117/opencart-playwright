import { test, expect } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { TestConfig } from '../test.config';
import { WishListPage } from '../pages/WishListPage';
import { LoginPage } from '../pages/LoginPage';

let config: TestConfig;
let homePage: HomePage;
let loginPage: LoginPage;
let wishlistpage: WishListPage;

// This hook runs before each test
test.beforeEach(async ({ page }) => {
  config = new TestConfig(); // Load config (URL, credentials)
  await page.goto(config.appUrl); // Navigate to base URL

  // Initialize page objects
  homePage = new HomePage(page);
  loginPage = new LoginPage(page);
  wishlistpage = new WishListPage(page);
});

// Optional cleanup after each test
test.afterEach(async ({ page }) => {
  await page.close(); // Close browser tab (good practice in local/dev run)
});

test('Verify wishlist button @master @sanity @regression', async () => {

  //Navigate to Login page via Home page

  await homePage.clickMyAccount();
  await homePage.clickLogin();

  //Enter valid credentials and log in
  await loginPage.setEmail(config.email);
  await loginPage.setPassword(config.password);
  await loginPage.clickLogin();

  //Navigate to Wishlist page via Home page
  await homePage.clickWishlist();

  //Validate the confirmation message 
  const confirmationMsg = await wishlistpage.getConfirmationMsg();
  expect(confirmationMsg).toContain('My Wish List');

});