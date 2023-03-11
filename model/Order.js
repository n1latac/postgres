const _ = require('lodash');

class Order{
    static _client;

    static async bulkCreate(users, phones){
        // const ordersValueString = users
        //             .map(u => 
        //                 new Array(_.random(1, 3, false))
        //                 .fill(null)
        //                 .map(()=> `(${u.id})`)
        //                 .join(',')
        //             ).join(',');

    // const {rows: orders} = await this._client.query(
    //     `INSERT INTO orders (customer_id) VALUES ${ordersValueString} RETURNING id`
    // );

    const {rows: orders1} = await this._client.query(`SELECT * FROM orders1`);

    const phonesToOrdersValueString = orders1.map(
        o => {
            const arr = new Array(_.random(1, 4, false))
                            .fill(null)
                            .map(() => phones[_.random(1, phones.length - 1)]);
            return [...new Set(arr)]
                    .map(p => `(${o.id}, ${p.id}, ${_.random(1,3,false)})`)
                    .join(',')
        })
        .join(',');


        const res2 = await this._client.query(
            `INSERT INTO orders1_to_products1 (orders1_id, products1_id, quantity) VALUES ${phonesToOrdersValueString};`);
    }
}

module.exports = Order;
/* 
CREATE TABLE orders1(
    id serial PRIMARY KEY,
    created_at timestamp DEFAULT current_timestamp,
    customer_id int REFERENCES users1(id)
)
*/