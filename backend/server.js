const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Simple in-memory user store for demo
const users = [];

// JWT secret key
const JWT_SECRET = 'your_jwt_secret_key';

// Authentication middleware
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (!token) return res.sendStatus(401);

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
}

// Routes

// User registration
app.post('/api/register', (req, res) => {
  const { username, password } = req.body;
  if (users.find(u => u.username === username)) {
    return res.status(400).json({ message: 'User already exists' });
  }
  users.push({ username, password, progress: {} });
  res.status(201).json({ message: 'User registered successfully' });
});

// User login
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  const user = users.find(u => u.username === username && u.password === password);
  if (!user) {
    return res.status(401).json({ message: 'Invalid credentials' });
  }
  const accessToken = jwt.sign({ username: user.username }, JWT_SECRET);
  res.json({ accessToken });
});

// Get personalized learning path
app.get('/api/learning-path', authenticateToken, (req, res) => {
  // For demo, return a static learning path
  const learningPath = [
    { id: 1, title: 'Introduction to AI', completed: false },
    { id: 2, title: 'Machine Learning Basics', completed: false },
    { id: 3, title: 'Deep Learning Fundamentals', completed: false }
  ];
  res.json(learningPath);
});

// Update progress
app.post('/api/progress', authenticateToken, (req, res) => {
  const { moduleId, completed } = req.body;
  const user = users.find(u => u.username === req.user.username);
  if (!user) return res.status(404).json({ message: 'User not found' });
  user.progress[moduleId] = completed;
  res.json({ message: 'Progress updated' });
});

// Get AI recommendations
app.get('/api/recommendations', authenticateToken, (req, res) => {
  // For demo, return static recommendations
  const recommendations = [
    { id: 101, title: 'Advanced AI Techniques' },
    { id: 102, title: 'AI Ethics and Society' }
  ];
  res.json(recommendations);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
