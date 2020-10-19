const { check } = require('express-validator');

exports.createPostValidator = [
    check('title').notEmpty().withMessage('عنوان نمی تواند خالی باشد!'),
    check('title').isLength({ min: 4, max: 100 }).withMessage('عنوان باید حداقل ۴ و حداکثر ۱۰۰ کاراکتر باشد!'),
    check('description').notEmpty().withMessage('توضیحات نمی تواند خالی باشد!'),
    check('description').isLength({ min: 4, max: 500 }).withMessage('توضیحات باید حداقل ۴ و حداکثر ۵۰۰ کاراکتر باشد!'),
    check('price').notEmpty().withMessage('قیمت نمی تواند خالی باشد!'),
    check('price').isLength({ min: 3, max: 12 }).withMessage('قیمت باید حداقل هزار و حداکثر صد میلیارد تومان باشد!'),
    check('photos').notEmpty().withMessage('تصویر نمی تواند خالی باشد!'),
]

exports.signupUserValidator = [
    check('username').notEmpty().withMessage('نام کاربری نمی تواند خالی باشد!'),
    check('username').isLength({ max: 30 }).withMessage('نام کاربری باید حداکثر ۳۰ کاراکتر باشد!'),
    check('email').notEmpty().withMessage('ایمیل نمی تواند خالی باشد!'),
    check('email').isLength({ min: 8, max: 100 }).withMessage('ایمیل باید حداقل ۳ و حداکثر ۳۲۰ کاراکتر باشد!'),
    check('email').isEmail().withMessage('ایمیل معتبر نیست!'),
    check('password').notEmpty().withMessage('رمز عبور نمی تواند خالی باشد!'),
    check('password').isLength({ min: 8, max: 100 }).withMessage('رمز عبور باید حداقل ۸ و حداکثر ۱۰۰ کاراکتر باشد!'),
]