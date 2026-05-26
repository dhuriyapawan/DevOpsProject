
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
    service: "order-service",
    status: "ok"
  });
});

app.get("/api/orders", (req, res) => {
  return res.status(200).json([
    {
      id: 101,
      product: "Laptop",
      amount: 1
    }
  ]);
});

const PORT = process.env.PORT || 3002;

app.listen(PORT, () => {
  console.log(`Order Service running on ${PORT}`);
});