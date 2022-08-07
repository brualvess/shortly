import { connection } from '../dbStrategy/postgres.js'
import joi from 'joi'
import { nanoid } from 'nanoid'
import dayjs from 'dayjs'
export async function shortenUrl(req, res) {
    const url = req.body
    const { authorization } = req.headers;
    const createdAt = dayjs().format('DD/MM/YYYY')
    const schemaUrl = joi.object({
        url: joi.string().uri()
    })
    const { error } = schemaUrl.validate(url)
    if (error) {
        res.status(422).send(error)
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
        const shortUrl = nanoid(7)
        await connection.query(
            `INSERT INTO "shortUrl" (
                    url, key, "userId"
                    ) 
                    VALUES(
                    '${url.url}',
                    '${shortUrl}',
                    '${token[0].userId}',
                    '${createdAt}'
                    ) `
        )
        res.status(201).send({
            "shortUrl": shortUrl
        })
    } catch {
        res.sendStatus(500)
    }
}

export async function listUrlId(req, res) {
    const id = parseInt(req.params.id)

    try {
        const { rows: url } = await connection.query(
            `SELECT * FROM "shortUrl" WHERE id = '${id}'`
        )
        if (url[0]) {
            res.status(200).send(
                {
                    "id": id,
                    "shortUrl": url[0].key,
                    "url": url[0].url
                }
            )
        } else {
            res.sendStatus(404)
        }
    } catch {
        res.sendStatus(500)
    }
}
export async function redirectUrl(req, res) {
    const key = req.params.shortUrl
    const visitDate = dayjs().format('DD/MM/YYYY')
    const { rows: url } = await connection.query(
        `SELECT * FROM "shortUrl" WHERE key = '${key}'`
    )
    try {
        if (url[0]) {
            await connection.query(
                `INSERT INTO visits (
                            "urlId", "visitDate"
                            ) 
                            VALUES(
                            '${url[0].id}',
                            '${visitDate}'
                            ) `
            )
            res.redirect(url[0].url)
        } else {
            res.sendStatus(404)
        }

    } catch {
        res.sendStatus(500)
    }
}

export async function deleteUrl(req, res) {
    const { authorization } = req.headers;
    const id = parseInt(req.params.id)
    const { rows: token } = await connection.query(
        `SELECT * FROM tokens WHERE token = '${authorization.slice(7)}'`
    )
    if (!token[0]) {
        res.sendStatus(401)
        return
    }
    try {
        const { rows: idUser } = await connection.query(
            `SELECT * FROM "shortUrl" WHERE id = ${id}`
        )
        if (!idUser[0]) {
            res.sendStatus(404)
        } else if (token[0].userId == idUser[0].userId) {
            await connection.query(
                `DELETE FROM visits WHERE "urlId" = ${id}`
            )
            await connection.query(
                `DELETE FROM "shortUrl" WHERE id = ${id}`
            )
            res.sendStatus(204)
        } else {
            res.sendStatus(401)
        }
    } catch {
        res.sendStatus(500)
    }

}