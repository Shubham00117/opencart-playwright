import { faker } from '@faker-js/faker';

/**
 * RandomDataUtil - Utility class for generating random test data.
 * Uses @faker-js/faker to produce realistic fake data for test automation.
 */
export class RandomDataUtil {

    /**
     * Returns a random first name
     */
    static getFirstName(): string {
        return faker.person.firstName();
    }

    /**
     * Returns a random last name
     */
    static getLastName(): string {
        return faker.person.lastName();
    }

    /**
     * Returns a random full name
     */
    static getFullName(): string {
        return faker.person.fullName();
    }

    /**
     * Returns a random email address
     */
    static getEmail(): string {
        return faker.internet.email();
    }

    /**
     * Returns a random phone number
     */
    static getPhoneNumber(): string {
        return faker.phone.number();
    }

    /**
     * Returns a random username
     */
    static getUsername(): string {
        return faker.internet.username();
    }

    /**
     * Returns a random password
     */
    static getPassword(): string {
        return faker.internet.password();
    }

    /**
     * Returns a random country name
     */
    static getRandomCountry(): string {
        return faker.location.country();
    }

    /**
     * Returns a random state/province
     */
    static getRandomState(): string {
        return faker.location.state();
    }

    /**
     * Returns a random city name
     */
    static getRandomCity(): string {
        return faker.location.city();
    }

    /**
     * Returns a random postal/zip code
     */
    static getRandomPin(): string {
        return faker.location.zipCode();
    }

    /**
     * Returns a random street address
     */
    static getRandomAddress(): string {
        return faker.location.streetAddress();
    }

    /**
     * Returns a random password of specified length
     * @param length - Length of the password (default: 10)
     */
    static getRandomPassword(length: number = 10): string {
        return faker.internet.password({ length });
    }

    /**
     * Returns a random alphanumeric string of specified length
     * @param length - Length of the string
     */
    static getRandomAlphanumeric(length: number): string {
        return faker.string.alphanumeric(length);
    }

    /**
     * Returns a random numeric string of specified length
     * @param length - Length of the string
     */
    static getRandomNumeric(length: number): string {
        return faker.string.numeric(length);
    }

    /**
     * Returns a random UUID
     */
    static getRandomUUID(): string {
        return faker.string.uuid();
    }

    /**
     * Returns a random product name
     */
    static getRandomProductName(): string {
        return faker.commerce.productName();
    }

    /**
     * Returns a random price as string
     */
    static getRandomPrice(): string {
        return faker.commerce.price();
    }

    /**
     * Returns a complete random user data object for registration
     */
    static getRandomUserData(): {
        firstName: string;
        lastName: string;
        email: string;
        telephone: string;
        password: string;
    } {
        const password = this.getRandomPassword(12);
        return {
            firstName: this.getFirstName(),
            lastName: this.getLastName(),
            email: this.getEmail(),
            telephone: this.getPhoneNumber(),
            password,
        };
    }
}
