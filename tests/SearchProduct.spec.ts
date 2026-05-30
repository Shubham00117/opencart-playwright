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
