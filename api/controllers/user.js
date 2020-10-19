const _ = require('lodash');
const User = require('../models/user');

exports.userById = (req, res, next, id) => {
    User.findById(id).exec((err, user) => {
        if (err || !user) {
            return res.status(400).json({
                error: 'کاربر یافت نشد!'
            });
        }
        // Now add user info to request
        req.profile = user;
        next();
    });
};

exports.hasAuthorization = (req, res, next) => {
    const authorized = req.profile && req.auth && req.profile._id === req.auth._id;
    if (!authorized) {
        return res.status(403).json({
            error: 'اطلاعات کاربری اشتباه است!'
        });
    }
};

exports.getUsers = (req, res) => {
    const users = User.find().sort({ 'date': -1 }).select("_id username email date")
        .then((users) => {
            res.json({ users })
        }).catch(err => console.log(err));
};

exports.getUser = (req, res) => {
    req.profile.hashed_password = undefined;
    req.profile.salt = undefined;
    req.profile.__v = undefined;
    return res.json(req.profile);
};

exports.updateUser = (req, res, next) => {
    let user = req.profile;
    user = _.extend(user, req.body);
    user.save((err) => {
        if (err) {
            return res.status(403).json({
                error: 'اطلاعات کاربری اشتباه است!'
            });
        }
        user.hashed_password = undefined;
        user.salt = undefined;
        res.json({ message: 'اطلاعات کاربر با موفقیت اصلاح شد!' });
    });
};

exports.deleteUser = (req, res, next) => {
    let user = req.profile;
    user.remove((err, user) => {
        if (err) {
            return res.status(400).json({
                error: err
            });
        }
        res.json({ message: 'کاربر با موفقیت حذف شد!' });
    });
}