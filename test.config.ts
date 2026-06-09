/**
 * TestConfig - Centralized configuration for test execution.
 * Reads environment variables or uses default values for local development.
 */
export class TestConfig {
    /** Base application URL */
    readonly appUrl: string;

    /** Test user email */
    readonly email: string;

    /** Test user password */
    readonly password: string;

    /** Default timeout for operations (ms) */
    readonly timeout: number;

    constructor() {
        this.appUrl = process.env.APP_URL ?? 'https://demo.opencart.com/';
        this.email = process.env.TEST_EMAIL ?? 'shubham23@yopmail.com';
        this.password = process.env.TEST_PASSWORD ?? 'Test@1234';
        this.timeout = parseInt(process.env.TIMEOUT ?? '30000', 10);
    }

    /**
     * Returns checkout URL
     */
    get checkoutUrl(): string {
        return `${this.appUrl}index.php?route=checkout/checkout`;
    }

    /**
     * Returns wishlist URL
     */
    get wishlistUrl(): string {
        return `${this.appUrl}index.php?route=account/wishlist`;
    }

    /**
     * Returns My Account URL
     */
    get myAccountUrl(): string {
        return `${this.appUrl}index.php?route=account/account`;
    }
}
