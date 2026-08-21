/**
 * Faux Node.js microservice used as an SCA / shift-left scanning target.
 * Not intended for production use.
 */
const express = require("express");
const app = express();
app.use(express.json());

app.get("/health", (req, res) => {
  res.json({ status: "ok", service: "node-service" });
});

app.post("/echo", (req, res) => {
  res.json({ received: req.body || {} });
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`node-service listening on ${port}`);
});
