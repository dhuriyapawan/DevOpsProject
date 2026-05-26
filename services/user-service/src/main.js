require("dotenv").config();

const express = require("express");
const helmet = require("helmet");
const cors = require("cors");

const app = express();

app.use(express.json());
app.use(cors());
app.use(helmet());

app.get("/health", (req, res) => {
  return res.status(200).json({
    service: "user-service",
    status: "ok"
  });
});

app.get("/api/users", (req, res) => {
  return res.status(200).json([
    {
      id: 1,
      name: "Pawan"
    }
  ]);
});

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`User Service running on ${PORT}`);
});