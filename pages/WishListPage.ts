import { th } from '@faker-js/faker';
import { Page, expect, Locator } from '@playwright/test';


export class WishListPage {
  private readonly page: Page;

  private readonly msgConfirmation: Locator;


  constructor(page: Page) {
    this.page = page;
    this.msgConfirmation = page.locator('h2:has-text("My Wish List")');
  }

  async getConfirmationMsg(): Promise<string> {
    return await this.msgConfirmation.textContent() ?? '';
  }
}