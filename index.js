const {Client} = require('pg');
const {mapUsers} = require('./utils');
const {configs} = require('./configs');
const {loadUser} = require('./api');






const client = new Client(configs);

async function start(){
    await client.connect();
    const data = await loadUser();

    const res = await client.query(`INSERT INTO users1
    (first_name, last_name, email, gender, is_subscribed)
    VALUES ${mapUsers(data)}`);
    await client.end();
}

start();


