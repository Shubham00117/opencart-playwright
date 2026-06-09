import { Page } from '@playwright/test';
import { HomePage } from '../pages/HomePage';
import { LoginPage } from '../pages/LoginPage';
import { TestConfig } from '../test.config';

/**
 * TestHelpers - Utility class for common test setup and teardown actions.
 * Provides reusable methods shared across multiple test specs.
 */
export class TestHelpers {

    /**
     * Performs login for a user using page objects.
     * @param page - Playwright Page instance
     * @param config - Test configuration with credentials
     */
    static async loginUser(page: Page, config: TestConfig): Promise<void> {
        const homePage = new HomePage(page);
        const loginPage = new LoginPage(page);
        await homePage.navigateToLogin();
        await loginPage.login(config.email, config.password);
    }

    /**
     * Navigates to the application URL.
     * @param page - Playwright Page instance
     * @param config - Test configuration
     */
    static async navigateToApp(page: Page, config: TestConfig): Promise<void> {
        await page.goto(config.appUrl);
    }

    /**
     * Waits for a fixed duration (use sparingly; prefer waiting for conditions).
     * @param ms - Duration in milliseconds
     */
    static async sleep(ms: number): Promise<void> {
        await new Promise(resolve => setTimeout(resolve, ms));
    }

    /**
     * Scrolls an element into view and highlights it for visual debugging.
     * @param page - Playwright Page instance
     * @param selector - CSS selector of the element
     */
    static async highlightElement(page: Page, selector: string): Promise<void> {
        await page.evaluate((sel) => {
            const el = document.querySelector(sel) as HTMLElement | null;
            if (el) {
                el.style.border = '3px solid red';
                el.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }, selector);
    }

    /**
     * Takes a full-page screenshot and saves it with a timestamped name.
     * @param page - Playwright Page instance
     * @param name - Base name for the screenshot file
     */
    static async takeScreenshot(page: Page, name: string): Promise<void> {
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
        await page.screenshot({
            path: `test-results/${name}_${timestamp}.png`,
            fullPage: true,
        });
    }
}
