const express = require("express");
const axios = require("axios");
const bodyParser = require("body-parser");
const app = express();

app.use(bodyParser.json());

const port = 3000;

// Connect to your database here

app.get("/groups/:id/messages", async (req, res) => {
  const groupId = req.params.id;
  const page = req.query.page || 1;
  const limit = req.query.limit || 10;

  // Perform paginated query to retrieve messages for the specified group
  const messages = await axios.get(
    `/api/v1/groups/${groupId}/messages?page=${page}&limit=${limit}`
  );
  res.json(messages);
});

app.post("/groups/:id/messages", async (req, res) => {
  const groupId = req.params.id;
  const { user_phone_number, message } = req.body;

  // Perform query to insert the new message into the group
  await axios.post(`/api/v1/groups/${groupId}/messages`, {
    user_phone_number,
    message,
  });
  res.json({ message: "message created successfully" });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
