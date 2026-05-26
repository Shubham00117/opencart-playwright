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
