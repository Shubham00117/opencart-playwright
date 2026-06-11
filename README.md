# 🛒 OpenCart Playwright Test Automation

> End-to-end test automation framework for the [OpenCart](https://demo.opencart.com/) e-commerce platform, built with **Playwright** and **TypeScript** using the **Page Object Model (POM)** design pattern.

---

## 🚀 Tech Stack

| Tool / Library        | Purpose                          |
|-----------------------|----------------------------------|
| Playwright            | Browser automation framework     |
| TypeScript            | Type-safe test scripting         |
| @faker-js/faker       | Generating random test data      |
| Allure Playwright     | Test reporting                   |
| GitHub Actions        | CI/CD pipeline                   |

---

## 📁 Project Structure

```
OpenCartPlayWright/
├── .github/
│   └── workflows/
│       └── playwright.yml       # CI/CD GitHub Actions workflow
├── pages/                       # Page Object Model classes
│   ├── HomePage.ts
│   ├── LoginPage.ts
│   ├── RegistrationPage.ts
│   ├── MyAccountPage.ts
│   ├── LogoutPage.ts
│   ├── SearchResultsPage.ts
│   ├── ProductPage.ts
│   ├── ShoppingCartPage.ts
│   ├── CheckoutPage.ts
│   └── WishListPage.ts
├── tests/                       # Test specification files
│   ├── Login.spec.ts
│   ├── LoginDataDriven.spec.ts
│   ├── AccountRegistration.spec.ts
│   ├── Logout.spec.ts
│   ├── SearchProduct.spec.ts
│   ├── AddToCart.spec.ts
│   ├── WishList.spec.ts
│   └── EndToEndTest.spec.ts
├── utils/                       # Utilities and helpers
│   ├── randomDataGenerator.ts
│   ├── dataProvider.ts
│   └── testHelpers.ts
├── .env.example                 # Environment variable template
├── playwright.config.ts         # Playwright configuration
├── test.config.ts               # Test configuration class
└── package.json                 # Project dependencies and scripts
```

---

## ⚙️ Setup & Installation

### Prerequisites
- **Node.js** >= 18.x
- **npm** >= 9.x

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/Shubham00117/opencart-playwright.git
cd opencart-playwright

# 2. Install dependencies
npm install

# 3. Install Playwright browsers
npx playwright install

# 4. Configure environment variables
cp .env.example .env
# Edit .env with your test credentials
```

---

## 🧪 Running Tests

```bash
# Run all tests
npm test

# Run with browser visible
npm run test:headed

# Run by tag
npm run test:sanity       # @sanity tagged tests
npm run test:regression   # @regression tagged tests
npm run test:e2e          # @e2e tagged tests

# Run specific test files
npm run test:login
npm run test:registration

# Run on specific browser
npm run test:chromium
npm run test:firefox
```

---

## 📊 Reports

```bash
# Open Playwright HTML report
npm run report

# Generate Allure report
npm run allure:generate

# Open Allure report in browser
npm run allure:open

# Serve Allure report (live)
npm run allure:serve
```

---

## 📋 Test Coverage Summary

| Module        | Page Object | Test Spec  | Status     |
|---------------|-------------|------------|------------|
| Registration  | ✅           | ✅          | ✔ Complete |
| Login         | ✅           | ✅          | ✔ Complete |
| Login (DDT)   | ✅           | ✅          | ✔ Complete |
| Logout        | ✅           | ✅          | ✔ Complete |
| Search        | ✅           | ✅          | ✔ Complete |
| Product       | ✅           | ✅          | ✔ Complete |
| Cart          | ✅           | ✅          | ✔ Complete |
| Checkout      | ✅           | ✅          | ✔ Complete |
| Wishlist      | ✅           | ✅          | ✔ Complete |
| End-to-End    | —            | ✅          | ✔ Complete |

---

## 🏷️ Test Tags

| Tag          | Description                              |
|--------------|------------------------------------------|
| `@master`    | Core smoke tests — run on every push     |
| `@sanity`    | Sanity / quick verification tests        |
| `@regression`| Full regression test suite               |
| `@e2e`       | End-to-end user journey tests            |

---

## 🔄 CI/CD

Tests automatically run via **GitHub Actions** on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Nightly schedule (2 AM UTC)
- Manual trigger with custom test tag selection

---

## 👤 Author

**Shubham** — [GitHub](https://github.com/Shubham00117)

---

*Built with ❤️ using Playwright + TypeScript*
