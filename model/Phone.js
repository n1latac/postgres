
class Phone{
    static _client;
    static _tableName;


    static async findAll(){
        return await this._client.query(`SELECT * FROM ${this._tableName}`);
    }

    static async bulkCreate(phonesArray){
        const valueString = phonesArray.map(phone => `('${phone.brand}', '${phone.model}', '${phone.quantity}', ${phone.price}, '${phone.category}')`).join(',');
        return await this._client.query(`INSERT INTO ${this._tableName} 
        (brand, model, quantity, price, category)
        VALUES ${valueString}`);
    }
}
module.exports = Phone;