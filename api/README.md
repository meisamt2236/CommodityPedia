# API
## Installations
In this project we used **Node.js v12.18.3** and **MongoDB v4.4**
- Web framework for running node.js app => **express@4.17.1**
- Simple monitor script for use during development of a node.js app => **nodemon@2.0.4**
- HTTP request logger middleware for node.js => **morgan@1.10.0**
- Loads environment variables from .env file => **dotenv@8.2.0**
- MongoDB object modeling tool to work in an asynchronous environment => **mongoose@5.10.1**
- Node.js body parsing middleware => **body-parser@1.19.0**
- Express middleware for the validator module => **express-validator@6.6.1**
- RFC4122 (v1, v4, and v5) UUIDs => **uuid@8.3.0**
- JSON Web Token implementation => **jsonwebtoken@8.5.1**
- Parse HTTP request cookies => **cookie-parser@1.4.5**
- JWT authentication middleware => **express-jwt@6.0.0**
- Modular utilities for extending(updating) objects => **lodash@4.17.20**
- A node.js module for parsing form data, especially file uploads => **formidable@1.2.2**
- Node.js CORS middleware => **cors@2.8.5**
### Fixed Mode
To run the project download [docker](https://docs.docker.com/engine/install/) and change the mongoose parameters in the app.js file to:
```javascript
mongoose.connect(process.env.MONGO_URI, {useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => console.log('DB connected!'));
```
Now run these commands:
```bash
# running docker-compose
docker-compose up
# stopping docker-compose
docker-compose down
```
Now visit http://localhost for your api. 
### Interactive Mode
To edit and run the project download [docker](https://docs.docker.com/engine/install/) and change the mongoose parameters in the app.js to:
```javascript
mongoose.connect(process.env.MONGO_URI_LOCAL, {useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => console.log('DB connected!'));
```
Now run these commands:
```bash
# download mongo db
docker pull mongo:4.4
# create a docker docker for mongo db
docker run -d -p 27017:27017 mongo
# run the project
npm run dev
```
Now visit http://localhost:8080 for your api.
## API routes
|      route      | action |      response     |
|:---------------:|:------:|:-----------------:|
|        /        |   GET  |      api docs     |
|     /posts      |   GET  |   get all posts   |
|  /post/:postId  |   GET  |     get a post    |
|  /post/:postId  |  POST  |    send a post    |
|  /post/:postId  | DELETE |   delete a post   |
|  /post/:userId  |   PUT  |   update a user   |
|     /signup     |  POST  |      sign up      |
|     /signin     |  POST  |      sign in      |
|    /signout     |   GET  |      sign out     |
|      /users     |   GET  |   get all users   |
|  /user/:userId  |   GET  |     get a user    |
|  /user/:userId  |   PUT  |   update a user   |
|  /user/:userId  | DELETE |   delete a user   |
|/posts/by/:userId|   GET  | get posts of user |