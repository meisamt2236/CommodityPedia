const { validationResult } = require('express-validator');
const formidable = require('formidable');
const _ = require('lodash');
const Post = require('../models/post');
const fs = require('fs');
require('dotenv').config();

exports.postById = (req, res, next, id) => {
    Post.findById(id).populate('creator', '_id username email')
        .exec((err, post) => {
            if (err || !post) {
                return res.status(400).json({
                    error: 'محصول یافت نشد!'
                });
            }
            // Now add user info to request
            req.post = post;
            next();
        });
};

exports.getPosts = (req, res) => {
    const posts = Post.find().sort({ 'date': -1 }).populate('creator', '_id username email').select("_id title description date price photo_address")
        .then((posts) => {
            res.json({ posts })
        }).catch(err => console.log(err));
}

exports.postPhoto = (req, res, next) => {
    if (req.post.photo) {
        res.set('Content-Type', req.post.photo.contentType)
        return res.send(req.post.photo.data);
    }
    next();
};

exports.createPost = (req, res, next) => {
    const errors = validationResult(req);
    console.log(errors);
    if (!errors.isEmpty()) {
        res.status(400).json({
            errors
        })
    } else {
        const base64string = req.body.photos;
        const bufferImage = Buffer.from(base64string, 'base64');
        data = {
            "title": req.body.title,
            "description": req.body.description,
            "price": req.body.price,
            "photo": {
                "contentType": "image/jpg",
                "data": bufferImage
            },
            "creator": req.profile
        }
        const post = new Post(data);
        post.photo_address = process.env.ADDRESS + ':' + process.env.PORT + '/post/photo/' + post._id;

        post.save((err, result) => {
            if (err) {
                return res.status(400).json({
                    error: err
                });
            }
            res.json({ message: 'با موفقیت ارسال شد!' });
        });
    }
};

exports.postByUser = (req, res) => {
    Post.find({ creator: req.profile._id }).sort({ 'date': -1 }).populate('creator', '_id username email').select("_id title description date price photo")
        .exec((err, posts) => {
            if (err) {
                return res.status(400).json({
                    error: err
                });
            }
            res.json(posts);
        });
};

exports.deletePost = (req, res) => {
    let post = req.post;
    post.remove((err, post) => {
        if (err) {
            return res.status(400).json({
                error: err
            });
        }
        res.json({ message: 'محصول با موفقیت حذف شد!' });
    });
};

exports.updatePost = (req, res, next) => {
    let post = req.post;
    post = _.extend(post, req.body);
    post.date = Date.now();
    post.save((err) => {
        if (err) {
            return res.status(403).json({
                error: 'اطلاعات محصول اشتباه است!'
            });
        }
        res.json({ message: 'اطلاعات محصول با موفقیت اصلاح شد!' });
    });
};

exports.getPost = (req, res) => {
    req.post.__v = undefined;
    return res.json(req.post);
};

exports.requireCreator = (req, res, next) => {
    let requireCreator = req.post && req.auth && req.post.creator._id == req.auth._id;
    if (!requireCreator) {
        return res.status(403).json({
            error: 'شما دسترسی لازم برای این کار را ندارید!'
        });
    }
    next();
};