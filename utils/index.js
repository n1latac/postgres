module.exports.mapUsers = (results) => {
    console.log(results);
    const res = results.map(({gender, name:{first,last}, email}) => `('${first}', '${last}', '${email}', '${gender}', true)`)
    return res
}
/*
'${first_name}', '${last_name}', '${email}', '${gender}', ${is_subscribed})` */