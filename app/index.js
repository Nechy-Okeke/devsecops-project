const handler = async (event) => {
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
};

module.exports = { handler };
