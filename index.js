const {loadUser} = require('./api');

const {User, client} = require('./model');







async function start(){
    await client.connect();
    const users = await loadUser();
    const res = await User.bulkCreate(users);
    await client.end();
}

start();


