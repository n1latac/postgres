const {loadUser} = require('./api');

const {User, client, Phone, Order} = require('./model');
const {generatePhones} = require('./utils');







async function start(){
    await client.connect();
    //const users = await loadUser();
    //const res = await User.bulkCreate(users);
    //const res = generatePhones(30);
    //await Phone.bulkCreate(res);
    const {rows: users} = await User.findAll();
    const {rows: phones} = await Phone.findAll();
    await Order.bulkCreate(users,phones)
    await client.end();
}

start();


