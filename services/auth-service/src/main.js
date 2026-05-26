
require("dotenv").config();

const express = require("express");
const helmet = require("helmet");
const cors = require("cors");
const morgan = require("morgan");

const authRoutes = require("./routes/authRoutes");

const app = express();

app.use(express.json());
// Configure CORS safely: allow only origins listed in CORS_ORIGINS env (comma-separated)
// Example: CORS_ORIGINS=https://app.example.com,https://admin.example.com
const rawOrigins = process.env.CORS_ORIGINS || '';
const allowedOrigins = rawOrigins.split(',').map(s => s.trim()).filter(Boolean);

const corsOptions = {
  origin: function (origin, callback) {
    // Allow requests with no origin (like mobile apps or curl)
    if (!origin) return callback(null, true);
    if (allowedOrigins.length === 0) {
      // If no origins configured, reject cross-origin requests by default
      return callback(new Error('CORS not configured'), false);
    }
    if (allowedOrigins.includes(origin)) {
      return callback(null, true);
    }
    return callback(new Error('Not allowed by CORS'), false);
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true,
};

app.use(cors(corsOptions));
app.use(helmet());
app.use(morgan("combined"));

app.get("/health", (req, res) => {
  return res.status(200).json({
    status: "ok",
    service: "auth-service"
  });
});

app.use("/api/auth", authRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Auth Service running on port ${PORT}`);
});