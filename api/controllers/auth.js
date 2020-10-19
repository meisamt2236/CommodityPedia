const { validationResult } = require('express-validator');
const jwt = require('jsonwebtoken');
const expressJwt = require('express-jwt');
const User = require('../models/user');
require('dotenv').config();

exports.signup = async (req, res) => {
    const userExists = await User.findOne({ email: req.body.email });
    if (userExists) return res.status(401).json({
        error: "کاربری با این ایمیل وجود دارد!"
    });
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        res.status(400).json({
            errors
        })
    } else {
        const user = await new User(req.body);
        await user.save();
        res.json({
            message: "کاربر جدید با اطلاعات داده شده ساخته شد!"
        });
    }
};

exports.signin = (req, res) => {
    const { email, password } = req.body;
    User.findOne({ email }, (err, user) => {
        if (err || !user) {
            return res.status(401).json({
                error: 'کاربری با این ایمیل وجود ندارد!'
            });
        }
        if (!user.authenticate(password)) {
            return res.status(401).json({
                error: 'رمز عبور اشتباه است!'
            });
        }
        const token = jwt.sign({ _id: user._id }, process.env.JWT_SECRET);
        // 86400 is equal to a day
        res.cookie('token', token, { expire: new Date() + 86400 });

        const { _id, name, email } = user;
        return res.json({ token, user: { _id, email, name } });
    });
};

exports.signout = (req, res) => {
    res.clearCookie('token');
    return res.json({
        message: 'با موفقیت از حساب کاربری خارج شدید!'
    });
};

exports.requireSignin = expressJwt({
    secret: process.env.JWT_SECRET,
    algorithms: ['HS256'],
    // append verified user id in auth key to request obj
    userProperty: 'auth'
});