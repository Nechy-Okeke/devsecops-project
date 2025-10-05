const handler = async (event) => {
    try {
        console.log('Event received:', JSON.stringify(event, null, 2));
        const { name } = event.queryStringParameters || {};
        const message = name ? `Hello, ${name}! Welcome to the DevSecOps API.` : 'Hello from DevSecOps API!';

        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*', // For CORS if needed
            },
            body: JSON.stringify({ message }),
        };
    } catch (error) {
        console.error('Error in handler:', error);
        return {
            statusCode: 500,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
            },
            body: JSON.stringify({ error: 'Internal Server Error' }),
        };
    }
};

module.exports = { handler };
