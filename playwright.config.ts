import { defineConfig, devices } from '@playwright/test';

/**
 * Playwright Configuration for OpenCart E2E Test Suite.
 * @see https://playwright.dev/docs/test-configuration
 */
export default defineConfig({
    // Directory where test files are located
    testDir: './tests',

    // Run tests in parallel (disable to run sequentially)
    fullyParallel: false,

    // Retry failed tests in CI environments
    retries: process.env.CI ? 2 : 0,

    // Use a single worker to avoid parallel conflicts on OpenCart
    workers: 1,

    // Maximum time a single test can run
    timeout: 60000,

    // Reporter configuration
    reporter: [
        ['html', { outputFolder: 'playwright-report', open: 'never' }],
        ['list'],
        ['allure-playwright'],
    ],

    use: {
        // Base URL for the application under test
        baseURL: 'https://demo.opencart.com/',

        // Collect traces on test failures for debugging
        trace: 'on-first-retry',

        // Capture screenshots on failure
        screenshot: 'only-on-failure',

        // Capture video on first retry
        video: 'on-first-retry',

        // Ignore HTTPS errors
        ignoreHTTPSErrors: true,

        // Default action timeout
        actionTimeout: 15000,

        // Default navigation timeout
        navigationTimeout: 30000,
    },

    // Define test projects for different browsers
    projects: [
        {
            name: 'chromium',
            use: { ...devices['Desktop Chrome'] },
        },
        {
            name: 'firefox',
            use: { ...devices['Desktop Firefox'] },
        },
    ],
});
