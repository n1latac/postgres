const axios = require('axios');

const http = axios.create({
    baseURL: 'https://randomuser.me/api/'
  });

module.exports.loadUser = async () => {
    const {data:{results}} = await http.get('?results=600');
    return results
}
