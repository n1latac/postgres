const _ = require('lodash');

module.exports.mapUsers = (results) => {
    const res = results.map(({gender, name:{first,last}, email, dob:{date}}) => 
    `('${first}', '${last}', '${email}', '${gender}', '${date}', ${Boolean(Math.random() > 0.5)})`);
    return res
}
/*
'${first_name}', '${last_name}', '${email}', '${gender}', ${is_subscribed})` */

const PHONES_BRANDS = [
    'Samsung',
    'iPhone',
    'Siemens',
    'Nokia',
    'Xiaomi',
    'Huawei',
    'Sony',
    'Motorolla',
    'Alcatel'
];

const generateOnePhone = key => ({
    brand:  PHONES_BRANDS[_.random(0, PHONES_BRANDS.length-1, false)],
    model: `model ${key}`,
    quantity: _.random(10, 1500, false),
    price: _.random(100, 15000, false),
    category: 'phones'
});

module.exports.generatePhones = (length=50) => new Array(length).fill(null).map((el,i)=>generateOnePhone(i));