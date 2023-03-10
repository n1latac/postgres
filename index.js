const {loadUser} = require('./api');

const {User, client, Phone} = require('./model');
const {generatePhones} = require('./utils');







async function start(){
    await client.connect();
    //const users = await loadUser();
    //const res = await User.bulkCreate(users);
    const res = generatePhones(10);
    console.log(res)
    await Phone.bulkCreate(res);
    await client.end();
}

start();


