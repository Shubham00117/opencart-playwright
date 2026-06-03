# 🛒 OpenCart Playwright Automation Framework

A complete, robust, and scalable E-Commerce Automation Testing Framework built for OpenCart (TutorialsNinja Demo) utilizing [Playwright](https://playwright.dev/) and **TypeScript**.

This project demonstrates a production-ready test automation framework using the **Page Object Model (POM)** design pattern, integrating Data-Driven Testing, Faker data generation, and comprehensive Reporting via Allure.

---

## 🚀 Key Features

- **TypeScript:** Fully typed test automation for better code quality and intellisense.
- **Page Object Model (POM):** Clean separation of UI locators and test logic, ensuring maintainability.
- **Data-Driven Testing:** Reads test data dynamically from external sources (CSV/JSON/Excel) located in the `testdata` folder.
- **Dynamic Data Generation:** Uses `@faker-js/faker` to generate random user data on the fly (e.g., dynamic emails for registration).
- **Test Tagging:** Organized test execution using Playwright's `grep` feature (e.g., `@master`, `@sanity`, `@regression`, `@datadriven`, `@end-to-end`).
- **Comprehensive Reporting:** Integrated with both Playwright's default HTML/List reporters and **Allure Reporter** (`allure-playwright`) for detailed execution dashboards.
- **CI/CD Integration:** Ready-to-use GitHub Actions workflow (`.github/workflows/playwright.yml`) for continuous integration.
- **Cross-Browser Testing:** Configured to run tests across multiple browsers (Chromium by default, easy to scale to Firefox/WebKit).

---

## 📁 Project Architecture & Folder Structure

```text
OpenCartPlayWright/
├── .github/
│   └── workflows/
│       └── playwright.yml         # GitHub Actions CI pipeline configuration
├── pages/                         # Page Object Model classes (UI Elements & Actions)
│   ├── CheckoutPage.ts            
│   ├── HomePage.ts
│   ├── LoginPage.ts
│   ├── LogoutPage.ts
│   ├── MyAccountPage.ts
│   ├── ProductPage.ts
│   ├── RegistrationPage.ts
│   ├── SearchResultsPage.ts
│   ├── ShoppingCartPage.ts
│   └── WishListPage.ts
├── tests/                         # Test Spec files containing assertions and scenarios
│   ├── AccountRegistration.spec.ts
│   ├── AddToCart.spec.ts
│   ├── EndToEndTest.spec.ts       # Complete user journey (Register -> Cart -> Checkout)
│   ├── Login.spec.ts
│   ├── LoginDataDriven.spec.ts    # Reads multiple credential sets from testdata
│   ├── Logout.spec.ts
│   ├── SearchProduct.spec.ts
│   └── WishList.spec.ts
├── testdata/                      # External test data files
│   ├── logindata.csv
│   └── logindata.json
├── utils/                         # Helper functions and utilities
│   ├── dataProvider.ts            # Logic to parse CSV/JSON data files
│   └── randomDataGenerator.ts     # Faker.js wrappers to generate random test data
├── test.config.ts                 # Project specific variables (App URLs, Global Credentials)
├── playwright.config.ts           # Playwright framework configurations (Timeouts, Browsers, Reporters)
└── package.json                   # Project dependencies and custom execution scripts
```

---

## 🛠️ Setup & Installation

### Prerequisites
- [Node.js](https://nodejs.org/en/) (v16 or above recommended)
- Optional: Allure Commandline (to view allure reports)

### 1. Clone the Repository
```bash
git clone <repository_url>
cd OpenCartPlayWright
```

### 2. Install Project Dependencies
```bash
npm install
```

### 3. Install Playwright Browsers
This command downloads the Chromium, Firefox, and WebKit binaries needed to run the tests.
```bash
npx playwright install
```

---

## ⚙️ Configuration Files

### `test.config.ts`
Manages application environment variables:
- **`appUrl`**: The base URL of the application under test (e.g., `https://tutorialsninja.com/demo/`).
- **Global Data**: Test accounts, default product names, and pricing used globally across test specs.

### `playwright.config.ts`
Manages Playwright execution capabilities:
- **Timeouts**: Global test and action timeouts.
- **Workers/Parallelism**: `fullyParallel: true` configuration for maximum speed.
- **Retries**: Configured to retry failed tests automatically to handle flakiness (`retries: 1`).
- **Reporters**: Configured to output `html`, `list`, and `allure-playwright` reports.
- **Browsers**: Defined browser projects.
- **Tracing/Video/Screenshots**: Artifacts collected on test failure.

---

## 🧪 Test Execution Guidelines

We have mapped standard Playwright commands to NPM scripts in `package.json` for easier execution. 

### Run Tests via NPM Scripts

- **Run all Master tests:**
  ```bash
  npm run test:master
  ```
- **Run Sanity suite:**
  ```bash
  npm run test:sanity
  ```
- **Run Regression suite:**
  ```bash
  npm run test:regression
  ```
- **Run Data-Driven tests (Multiple Iterations):**
  ```bash
  npm run test:datadriven
  ```
- **Run complete End-to-End User Flow (Headed Mode):**
  ```bash
  npm run test:end-to-end
  ```
- **Run tests in Debug mode (Playwright Inspector):**
  ```bash
  npm run test:sanity:debug
  ```

### Standard Playwright CLI Commands

- **Run tests with Playwright UI mode:**
  ```bash
  npx playwright test --ui
  ```
- **Run specific test file:**
  ```bash
  npx playwright test tests/Login.spec.ts
  ```

---

## 📊 Viewing Test Reports

The framework captures traces, videos, and screenshots on failure and attaches them to the reports.

### 1. Playwright Built-in HTML Report
Automatically generates a static HTML site summarizing the run.
```bash
npx playwright show-report
```

### 2. Allure Report
A more detailed and interactive report displaying test histories, steps, and graphical analytics.

**Step A:** Generate the Allure report from the raw results.
```bash
npx allure generate allure-results --clean -o allure-report
```
*Note: If `allure` is not installed globally, you can use `npx allure-commandline generate ...` or install it via npm `npm install -g allure-commandline`.*

**Step B:** Serve and open the report in your browser.
```bash
npx allure open allure-report
```

---

## 🔄 CI/CD Pipeline (GitHub Actions)

This project contains a GitHub Actions workflow `.github/workflows/playwright.yml`.

**What the pipeline does:**
1. Triggers on `push` or `pull_request` to the main branch.
2. Checks out the code and sets up the Node environment.
3. Installs dependencies (`npm ci`).
4. Installs Playwright browsers.
5. Executes the test suite.
6. Publishes the Playwright HTML report as a build artifact, available for download from the Actions tab.

---

## 💡 Best Practices Followed
- **Strict POM Implementation:** Locators and action methods are strictly kept inside `pages/`. Tests (`tests/`) only call POM methods, keeping the tests readable and easy to maintain.
- **Dynamic Assertions:** Use of Playwright's auto-retrying web-first assertions (`expect(locator).toBeVisible()`).
- **No Hardcoded Data:** Use of Faker for dynamic data generation and external configuration files for static environment data.
- **Test Isolation:** Tests are independent and do not rely on the state of previous tests.

---
*Happy Automating! 🤖✨*

---

## 📋 Test Coverage Summary

| Module        | Page Object | Test Spec | Status |
|---------------|------------|-----------|--------|
| Registration  | ✅          | ✅         | Done   |
| Login         | ✅          | ✅         | Done   |
| Logout        | ✅          | ✅         | Done   |
| Search        | ✅          | ✅         | Done   |
| Product       | ✅          | ✅         | Done   |
| Cart          | ✅          | ✅         | Done   |
| Checkout      | ✅          | ✅         | Done   |
| Wishlist      | ✅          | ✅         | Done   |
