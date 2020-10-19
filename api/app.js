const express = require('express');
const morgan = require('morgan');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const fs = require('fs');
const postRoutes = require('./routes/post');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
require('dotenv').config();

mongoose.connect(process.env.MONGO_URI_LOCAL, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('DB connected!'));
mongoose.connection.on('error', (err) => console.log(`DB connection error: ${err.message}`));

const app = express();

// middlewares
app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(cookieParser());
app.use(cors());
app.use('/', postRoutes);
app.use('/', authRoutes);
app.use('/', userRoutes);
// documentation
app.get('/', (req, res) => {
    fs.readFile('docs/apiDocs.json', (err, data) => {
        if (err) {
            res.status(400).json({
                error: err 
            });
        }
        const docs = JSON.parse(data);
        res.json(docs);
    });
});
// authorization handling
app.use(function (err, req, res, next) {
    if (err.name === 'UnauthorizedError') {
        res.status(401).json({
            error: 'برای دسترسی به این صفحه وارد شوید!'
        });
    }
});

const port = process.env.PORT || 8080;
app.listen(port, () => { console.log(`A Node js API is listening on port: ${port}`) });
