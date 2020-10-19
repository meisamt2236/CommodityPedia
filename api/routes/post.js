const express = require('express');
const { getPosts, getPost, createPost, postByUser, deletePost, requireCreator, postById, updatePost, postPhoto } = require('../controllers/post');
const { requireSignin } = require('../controllers/auth');
const { userById } = require('../controllers/user');
const { createPostValidator } = require('../validators');

const router = express.Router();

// routes
router.get('/posts', requireSignin, getPosts);
router.get('/post/:postId', getPost);
router.post('/post/:userId', requireSignin, createPost, createPostValidator);
router.get('/posts/by/:userId', requireSignin, postByUser);
router.delete('/post/:postId', requireSignin, requireCreator, deletePost);
router.put('/post/:postId', requireSignin, requireCreator, updatePost);
router.get('/post/photo/:postId', postPhoto);
// params
router.param('userId', userById);
router.param('postId', postById);

module.exports = router;