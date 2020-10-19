const express = require('express');
const { getUsers, getUser, updateUser, deleteUser, userById } = require('../controllers/user');
const { requireSignin } = require('../controllers/auth');

const router = express.Router();

// routes
router.get('/users', getUsers);
router.get('/user/:userId', requireSignin, getUser);
router.put('/user/:userId', requireSignin, updateUser);
router.delete('/user/:userId', requireSignin, deleteUser);
// params
router.param('userId', userById);

module.exports = router;