const {Client} = require('pg');
const {configs} = require('../configs');
const User = require('./User');
const Phone = require('./Phone');
const Order = require('./Order');

const client = new Client(configs);
User._client = client;
User._tableName = 'users1';


Phone._client = client;
Phone._tableName = 'products1';


Order._client = client;
module.exports={
    client,
    User,
    Phone, 
    Order
}

