const jwt = require("jsonwebtoken");

exports.register = async (req, res) => {
  try {
    const { email } = req.body;

    return res.status(201).json({
      message: "User registered successfully",
      email
    });
  } catch (error) {
    return res.status(500).json({
      error: error.message
    });
  }
};

exports.login = async (req, res) => {
  try {
    const { email } = req.body;

    const token = jwt.sign(
      {
        email
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "1h"
      }
    );

    return res.status(200).json({
      token
    });
  } catch (error) {
    return res.status(500).json({
      error: error.message
    });
  }
};