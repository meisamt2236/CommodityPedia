const mongoose = require('mongoose');
const { ObjectId } = mongoose.Schema;

const postSchema = new mongoose.Schema({
    title: {
        type: String,
        required: "لطفا عنوان را وارد کنید!",
        minlength: 4,
        maxlength: 100
    },
    description: {
        type: String,
        required: "لطفا توضیحات را وارد کنید!",
        minlength: 4,
        maxlength: 500
    },
    date: {
        type: Date,
        default: Date.now
    },
    price: {
        type: Number,
        default: 0
    },
    photo: {
        data: Buffer,
        contentType: String
    },
    photo_address: {
        type: String
    },
    creator: {
        type: ObjectId,
        ref: "User"
    }
});

module.exports = mongoose.model('Post', postSchema);