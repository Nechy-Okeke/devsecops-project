const { handler } = require('./index');

describe('API Handler', () => {
    test('returns default message', async () => {
        const event = {};
        const result = await handler(event);
        expect(result.statusCode).toBe(200);
        const body = JSON.parse(result.body);
        expect(body.message).toBe('Hello from DevSecOps API!');
    });

    test('returns personalized message', async () => {
        const event = {
            queryStringParameters: { name: 'World' }
        };
        const result = await handler(event);
        expect(result.statusCode).toBe(200);
        const body = JSON.parse(result.body);
        expect(body.message).toBe('Hello, World! Welcome to the DevSecOps API.');
    });
});
