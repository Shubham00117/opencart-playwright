/**
 * DataProvider - Provides structured test data for data-driven tests.
 * Contains predefined test data sets for various test scenarios.
 */

export interface LoginCredential {
    email: string;
    password: string;
    expectedResult: 'success' | 'failure';
    description: string;
}

export interface RegistrationData {
    firstName: string;
    lastName: string;
    email: string;
    telephone: string;
    password: string;
}

/**
 * Provides login test data for data-driven login tests
 * @returns Array of LoginCredential objects
 */
export function getLoginTestData(): LoginCredential[] {
    return [
        {
            email: 'shubham23@yopmail.com',
            password: 'Test@1234',
            expectedResult: 'success',
            description: 'Valid credentials - should login successfully',
        },
        {
            email: 'invalid@example.com',
            password: 'wrongpassword',
            expectedResult: 'failure',
            description: 'Invalid credentials - should show error message',
        },
        {
            email: '',
            password: '',
            expectedResult: 'failure',
            description: 'Empty credentials - should show validation error',
        },
        {
            email: 'shubham23@yopmail.com',
            password: 'wrongpassword',
            expectedResult: 'failure',
            description: 'Valid email, wrong password - should show error',
        },
    ];
}
