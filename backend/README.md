# PERSO.AI Backend

This is the backend server for the PERSO.AI personalized AI learning path application.

## Setup and Run

1. Install dependencies:
```
npm install
```

2. Start the server:
```
npm start
```

The server will run on port 3000 by default.

## API Endpoints

- `POST /api/register` - Register a new user. Body: `{ "username": "user", "password": "pass" }`
- `POST /api/login` - Login user. Body: `{ "username": "user", "password": "pass" }`. Returns JWT token.
- `GET /api/learning-path` - Get personalized learning path. Requires Authorization header with Bearer token.
- `POST /api/progress` - Update progress. Body: `{ "moduleId": 1, "completed": true }`. Requires Authorization header.
- `GET /api/recommendations` - Get AI recommendations. Requires Authorization header.

## Notes

- This is a demo backend with in-memory user storage. Data will be lost on server restart.
- JWT secret is hardcoded for demo purposes. Use environment variables for production.
