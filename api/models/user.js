const mongoose = require('mongoose');
const { v4 } = require('uuid');
const crypto = require('crypto');

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: "لطفا نام کاربری را وارد کنید!",
        minlength: 1,
        maxlength: 30,
        trim: true
    },
    email: {
        type: String,
        required: "لطفا ایمیل را وارد کنید!",
        minlength: 3,
        maxlength: 320,
        trim: true
    },
    date: {
        type: Date,
        default: Date.now
    },
    hashed_password: {
        type: String,
        required: true
    },
    salt: String,
});

userSchema.virtual('password').set(function (password) {
    this._password = password;
    this.salt = v4();
    this.hashed_password = this.encryptPassword(password);
}).get(function () {
    return this._password;
});

userSchema.methods = {
    encryptPassword: function (password) {
        if (!password) return '';
        try {
            return crypto.createHmac('sha256', this.salt)
                .update(password)
                .digest('hex');
        } catch (err) {
            return err
        }
    },
    authenticate: function (plainText) {
        // plainText is the password we get
        return this.encryptPassword(plainText) == this.hashed_password;
    }
}

module.exports = mongoose.model('User', userSchema);