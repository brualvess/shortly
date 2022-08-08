import { connection } from '../dbStrategy/postgres.js'
import joi from 'joi'
import dayjs from 'dayjs'
import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';
export async function createUsers(req, res) {
    const datas = req.body
    const createdAt = dayjs().format('DD/MM/YYYY')
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
            password,
            "createdAt") 
         VALUES (
            $1,$2,$3,$4
             )`,
            [datas.name,
            datas.email,
            passwordCrip,
            createdAt]
        )
        res.sendStatus(201)
    } catch (error) {
        if (error.message.includes("users_email_key")) {
            res.sendStatus(409)
            return
        } else {
            res.sendStatus(500)
        }
    }

}
export async function loginUsers(req, res) {
    const datas = req.body
    const token = uuid();
    const expireToken = dayjs().add(30, 'day')
    const createdAt = dayjs().format('DD/MM/YYYY')
    const schemaUser = joi.object({
        email: joi.string().email().required(),
        password: joi.string().required(),
    })
    const { error } = schemaUser.validate(datas)
    if (error) {
        res.sendStatus(422)
        return
    }
    const { rows: user } = await connection.query(
        `SELECT * FROM users WHERE email = $1`, [datas.email]
    )
    if (!user[0]) {
        res.sendStatus(401)
        return
    }
    const verificarSenha = bcrypt.compareSync(
        datas.password, user[0].password)

    if (!verificarSenha) {
        res.sendStatus(401)
        return
    }
    await connection.query(
        `INSERT INTO tokens (
                token, "userId", "expireAt", "createdAt" 
                ) 
                VALUES(
                $1, $2, $3, $4
                )`,
        [token,
        user[0].id,
        expireToken,
        createdAt]
    )
    res.status(200).send(token)
}
export async function listUsers(req, res) {
    const { authorization } = req.headers;

    if(!authorization){
        res.sendStatus(401)
        return
    }
    const { rows: token } = await connection.query(
        `SELECT * FROM tokens WHERE token = '${authorization.slice(7)}'`
    )
    if (!token[0]) {
        res.sendStatus(401)
        return
    }
    try {
        const { rows: object } = await connection.query(
            `
            SELECT users.id, users.name, COUNT(v.*) AS "visitCount", 
            "shortUrl".id AS i, "shortUrl".url, "shortUrl".key,
            SUM(COUNT (v.*)) OVER() AS sum
            FROM users
            JOIN "shortUrl"
            ON users.id = "shortUrl"."userId"
            LEFT JOIN visits v
            ON "shortUrl".id = v."urlId"
            WHERE users.id = $1
            GROUP BY users.id, "shortUrl".id
            `,
            [token[0].userId]
        )
        const newArray = []
        for (let i = 0; i < object.length; i++) {
            const obj = object[i]
            newArray.push({
                "id": obj.i,
                "shortUrl": obj.key,
                "url": obj.url,
                "visitCount": obj.visitCount
            })
        }
        const newObject = {
            "id": object[0].id,
            "name": object[0].name,
            "visitCount": object[0].sum,
            "shortenedUrls": newArray
        }

        res.status(200).send(newObject)

    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

