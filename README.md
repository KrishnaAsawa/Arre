# Arre
Arre Assignment

About the app.js file:
This application uses the Express.js framework to handle routing and the body-parser package to parse the request body. It also uses the axios package to make the API calls.
The first API endpoint /groups/:id/messages is a GET endpoint that loads all the group messages in a paginated manner. This API takes in the group id as a path parameter and page and limit as query parameters and returns the messages for the specified group.
The second API endpoint /groups/:id/messages is a POST endpoint that creates a message in the group. This API takes in the group id as a path parameter and a JSON object in the request body containing the user's phone number and message and returns a success message after inserting a message in the group.

About the schema:

This schema design uses multiple tables: `users`, `groups`, `group_members`, `messages`, `group_message_status`, `individual_message_status`.
- The `users` table stores information about each user, including their unique identifier - phone number, name, profile picture, status, and last seen timestamp.
- The `groups` table stores information about each group, including its unique identifier, name, date it was created, created by user ID, and group picture.
- The `group_members` table is a join table that connects users to groups. It has a composite primary key composed of both the group ID and the user phone number, role of the user in the group (admin or member) and foreign keys that reference the `groups` and `users` tables.
- The `messages` table stores information about each message, including the unique identifier, group it was sent to(NULL for individual chat), sender and receiver phone number, message text, message type, message media, and the date the message was sent.
- The `group_message_status` table stores message status for group messages, including message ID, group ID, user phone number, status, and date the message status was updated. 
- The `individual_message_status` table stores message status for individual messages, including message ID, sender and receiver phone number, status, and date the message status was updated.
