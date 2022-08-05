import { connection } from '../dbStrategy/postgres.js'
import joi from 'joi'
import { nanoid } from 'nanoid'
export async function shortenUrl(req, res){
    const url = req.body
    const { authorization } = req.headers;
    const schemaUrl = joi.object({
        url:joi.string().uri()
    })
    const { error } = schemaUrl.validate(url)
    if (error) {
        res.status(422).send(error)
        return
    }
     const {rows:token} = await connection.query(
        `SELECT * FROM tokens WHERE token = '${authorization.slice(7)}'`
        )
        if(!token[0]){
            res.sendStatus(401)
            return
        }
        try{
            const shortUrl = nanoid(7)
            await connection.query(
                `INSERT INTO "shortUrl" (
                    url, key
                    ) 
                    VALUES(
                    '${url.url}',
                    '${shortUrl}'
                    ) `
            )
            res.status(201).send({
                "shortUrl": shortUrl
            })
        } catch{
            res.sendStatus(500)
        }    
}