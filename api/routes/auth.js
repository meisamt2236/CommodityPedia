const express = require('express');
const { signup, signin, signout } = require('../controllers/auth');
const { userById } = require('../controllers/user');
const { signupUserValidator } = require('../validators');

const router = express.Router();

// routes
router.post('/signup', signupUserValidator, signup);
router.post('/signin', signin);
router.get('/signout', signout);
// params
router.param('userId', userById);

module.exports = router;