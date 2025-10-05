// Lambda handler for DevSecOps API
const handler = async (event) => {
    try {
        console.log('Event received:', JSON.stringify(event, null, 2));

        // Get 'name' from query string, if provided
        const name = event.queryStringParameters?.name || null;
        const message = name 
            ? `Hello, ${name}! Welcome to the DevSecOps API.` 
            : 'Hello from DevSecOps API!';

        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*', // Enable CORS
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

// Export the handler
module.exports = { handler };
