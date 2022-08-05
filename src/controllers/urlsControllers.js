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

export async function listUrlId(req, res){
    const id = parseInt(req.params.id)
    
    try{
        const {rows:url} = await connection.query(
            `SELECT * FROM "shortUrl" WHERE id = '${id}'`
            )
            if(url[0]){
                res.status(200).send(
                    {
                        "id": id,
                        "shortUrl": url[0].key,
                        "url": url[0].url
                    }
                )
            }else{
                res.sendStatus(404)
            }
    }catch{
        res.sendStatus(500)
    }
}