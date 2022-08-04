import { connection } from '../dbStrategy/postgres.js'
import joi from 'joi'
import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';
export async function createUsers(req, res) {
    const datas = req.body
    const schemaUser = joi.object({
        name: joi.string().required(),
        email: joi.string().email().required(),
        password: joi.string().required(),
        confirmPassword: joi.ref('password')
    })
    const { error } = schemaUser.validate(datas)
    if (error) {
        res.sendStatus(422)
        return
    }
    try {
        const passwordCrip = bcrypt.hashSync(datas.password, 10)
        await connection.query(
            `INSERT INTO users (
            name,
            email, 
            password) 
         VALUES (
            '${datas.name}',
            '${datas.email}',
            '${passwordCrip}'
             )`
        )
        res.sendStatus(201)
    } catch (error) {
    if(error.message.includes("users_email_key")){
        res.sendStatus(409)
        return
    }else{
        res.sendStatus(500)
    }
    }

}
export async function loginUsers(req, res){
    const datas = req.body
    const token = uuid();
    const schemaUser = joi.object({
        email: joi.string().email().required(),
        password: joi.string().required(),
    })
    const { error } = schemaUser.validate(datas)
    if (error) {
        res.sendStatus(422)
        return
    }
    const {rows:user} = await connection.query(
        `SELECT * FROM users WHERE email = '${datas.email}'`
        )
        if(!user[0]){
            res.sendStatus(401)
            return
        }
    const verificarSenha = bcrypt.compareSync(
        datas.password, user[0].password)

        if( !verificarSenha){
            res.sendStatus(401)
            return
        } 
      res.status(200).send(token) 
}