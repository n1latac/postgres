

module.exports.mapUsers = (results) => {
    const res = results.map(({gender, name:{first,last}, email, dob:{date}}) => 
    `('${first}', '${last}', '${email}', '${gender}', '${date}', ${Boolean(Math.random() > 0.5)})`);
    return res
}
/*
'${first_name}', '${last_name}', '${email}', '${gender}', ${is_subscribed})` */