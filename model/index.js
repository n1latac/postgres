const {Client} = require('pg');
const {configs} = require('../configs');
const User = require('./User');
const Phone = require('./Phone');

const client = new Client(configs);
User._client = client;
User._tableName = 'users1';


Phone._client = client;
Phone._tableName = 'products1';
module.exports={
    client,
    User,
    Phone
}

