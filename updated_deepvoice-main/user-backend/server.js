const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');

const app = express();

// Middleware
app.use(cors({
    origin: '*', // Flutter app origin (replace with correct address)
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type'],
})); // Allow requests from Flutter frontend
app.use(express.json()); // Parse JSON request bodies

// MongoDB connection string
const dbURI = 'mongodb+srv://fathimamina:yayoyi11@cluster1.ghymsqq.mongodb.net/user?retryWrites=true&w=majority&appName=Cluster1';

// Connect to MongoDB and start server
mongoose.connect(dbURI)
  .then(() => {
    console.log('Connected to MongoDB');
    app.listen(3001, '0.0.0.0', () => {
      console.log('User backend running on port 3001');
    });
  })
  .catch((err) => {
    console.error('MongoDB connection error:', err);
  });

// Routes
app.use('/api', authRoutes);

