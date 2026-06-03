import { Page, expect, Locator } from '@playwright/test';

/**
 * CheckoutPage - Page Object for the OpenCart Checkout page.
 * Handles guest/registered checkout flow including billing, shipping, payment, and order confirmation.
 */
export class CheckoutPage {
    private readonly page: Page;

    // Locators
    private readonly radioGuest: Locator;
    private readonly radioReturningCustomer: Locator;
    private readonly btnContinue: Locator;
    private readonly txtFirstName: Locator;
    private readonly txtLastName: Locator;
    private readonly txtEmail: Locator;
    private readonly txtTelephone: Locator;
    private readonly txtAddress1: Locator;
    private readonly txtAddress2: Locator;
    private readonly txtCity: Locator;
    private readonly txtPin: Locator;
    private readonly drpCountry: Locator;
    private readonly drpState: Locator;
    private readonly btnContinueBillingAddress: Locator;
    private readonly btnContinueDeliveryAddress: Locator;
    private readonly txtDeliveryMethod: Locator;
    private readonly btnContinueShippingAddress: Locator;
    private readonly chkboxTerms: Locator;
    private readonly btnContinuePaymentMethod: Locator;
    private readonly lblTotalPrice: Locator;
    private readonly btnConfOrder: Locator;
    private readonly lblOrderConMsg: Locator;

    constructor(page: Page) {
        this.page = page;

        // Initialize locators with CSS selectors
        this.radioGuest = page.locator('input[value="guest"]');
        this.radioReturningCustomer = page.locator('input[value="register"]');
        this.btnContinue = page.locator('#button-account');
        this.txtFirstName = page.locator('#input-payment-firstname');
        this.txtLastName = page.locator('#input-payment-lastname');
        this.txtEmail = page.locator('#input-payment-email');
        this.txtTelephone = page.locator('#input-payment-telephone');
        this.txtAddress1 = page.locator('#input-payment-address-1');
        this.txtAddress2 = page.locator('#input-payment-address-2');
        this.txtCity = page.locator('#input-payment-city');
        this.txtPin = page.locator('#input-payment-postcode');
        this.drpCountry = page.locator('#input-payment-country');
        this.drpState = page.locator('#input-payment-zone');
        this.btnContinueBillingAddress = page.locator('#button-payment-address');
        this.btnContinueDeliveryAddress = page.locator('#button-shipping-address');
        this.txtDeliveryMethod = page.locator('textarea[name="comment"]');
        this.btnContinueShippingAddress = page.locator('#button-shipping-method');
        this.chkboxTerms = page.locator('input[name="agree"]');
        this.btnContinuePaymentMethod = page.locator('#button-payment-method');
        this.lblTotalPrice = page.locator('strong:has-text("Total:") + td');
        this.btnConfOrder = page.locator('#button-confirm');
        this.lblOrderConMsg = page.locator('#content h1');
    }

    /**
     * Checks if the checkout page is displayed
     * @returns Promise<boolean>
     */
    async isCheckoutPageExists(): Promise<boolean> {
        try {
            await expect(this.page).toHaveTitle('Checkout');
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Selects the checkout option (Guest or Returning Customer)
     * @param checkOutOption - "Guest Checkout" or "Returning Customer"
     */
    async chooseCheckoutOption(checkOutOption: string): Promise<void> {
        if (checkOutOption === 'Guest Checkout') {
            await this.radioGuest.click();
        } else if (checkOutOption === 'Returning Customer') {
            await this.radioReturningCustomer.click();
        }
    }

    /**
     * Clicks the Continue button after selecting checkout option
     */
    async clickOnContinue(): Promise<void> {
        await this.btnContinue.click();
    }

    /**
     * Sets guest checkout billing first name
     * @param firstName - First name to enter
     */
    async setFirstName(firstName: string): Promise<void> {
        await this.txtFirstName.fill(firstName);
    }

    /**
     * Sets guest checkout billing last name
     * @param lastName - Last name to enter
     */
    async setLastName(lastName: string): Promise<void> {
        await this.txtLastName.fill(lastName);
    }

    /**
     * Sets guest checkout email address
     * @param email - Email to enter
     */
    async setEmail(email: string): Promise<void> {
        await this.txtEmail.fill(email);
    }

    /**
     * Sets guest checkout telephone number
     * @param phone - Telephone to enter
     */
    async setTelephone(phone: string): Promise<void> {
        await this.txtTelephone.fill(phone);
    }

    /**
     * Sets guest checkout billing address line 1
     * @param address1 - Address line 1 to enter
     */
    async setAddress1(address1: string): Promise<void> {
        await this.txtAddress1.fill(address1);
    }

    /**
     * Sets guest checkout billing address line 2
     * @param address2 - Address line 2 to enter
     */
    async setAddress2(address2: string): Promise<void> {
        await this.txtAddress2.fill(address2);
    }

    /**
     * Sets the city in the billing address
     * @param city - City name to enter
     */
    async setCity(city: string): Promise<void> {
        await this.txtCity.fill(city);
    }

    /**
     * Sets the postal/zip code
     * @param pin - Postal code to enter
     */
    async setPin(pin: string): Promise<void> {
        await this.txtPin.fill(pin);
    }

    /**
     * Selects the country from the dropdown
     * @param country - Country label to select
     */
    async setCountry(country: string): Promise<void> {
        await this.drpCountry.selectOption({ label: country });
    }

    /**
     * Selects the state/zone from the dropdown
     * @param state - State label to select
     */
    async setState(state: string): Promise<void> {
        await this.drpState.selectOption({ label: state });
    }

    /**
     * Clicks the Continue button after filling billing address
     */
    async clickOnContinueAfterBillingAddress(): Promise<void> {
        await this.btnContinueBillingAddress.click();
    }

    /**
     * Clicks the Continue button after delivery address step
     */
    async clickOnContinueAfterDeliveryAddress(): Promise<void> {
        await this.btnContinueDeliveryAddress.click();
    }

    /**
     * Sets a comment/note for the delivery method
     * @param deliveryMsg - Message to enter
     */
    async setDeliveryMethodComment(deliveryMsg: string): Promise<void> {
        await this.txtDeliveryMethod.fill(deliveryMsg);
    }

    /**
     * Clicks the Continue button after selecting delivery method
     */
    async clickOnContinueAfterDeliveryMethod(): Promise<void> {
        await this.btnContinueShippingAddress.click();
    }

    /**
     * Checks the Terms and Conditions checkbox
     */
    async selectTermsAndConditions(): Promise<void> {
        await this.chkboxTerms.check();
    }

    /**
     * Clicks Continue after selecting payment method
     */
    async clickOnContinueAfterPaymentMethod(): Promise<void> {
        await this.btnContinuePaymentMethod.click();
    }

    /**
     * Gets the total price shown on the order review page
     * @returns Promise<string | null>
     */
    async getTotalPriceBeforeConfOrder(): Promise<string | null> {
        return await this.lblTotalPrice.textContent();
    }

    /**
     * Clicks the Confirm Order button
     */
    async clickOnConfirmOrder(): Promise<void> {
        await this.btnConfOrder.click();
    }

    /**
     * Checks if the order was placed successfully
     * @returns Promise<boolean>
     */
    async isOrderPlaced(): Promise<boolean> {
        try {
            await expect(this.lblOrderConMsg).toHaveText('Your order has been placed!', { timeout: 7000 });
            return true;
        } catch (error) {
            console.error(`Error verifying order placement: ${error}`);
            return false;
        }
    }

    /**
     * Gets the order confirmation heading text
     * @returns Promise<string | null>
     */
    async getOrderConfirmationMessage(): Promise<string | null> {
        return await this.lblOrderConMsg.textContent();
    }
}
