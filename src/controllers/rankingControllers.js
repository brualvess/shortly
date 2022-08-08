import { connection } from '../dbStrategy/postgres.js'
export async function ranking(req, res){
 const {rows:rank}  = await connection.query(
    `SELECT users.id, users.name, COUNT(DISTINCT "shortUrl".*) AS "linksCount",
    COUNT(visits.*) AS "visitCount"
    FROM users
    LEFT JOIN "shortUrl"
    ON users.id = "shortUrl"."userId"
    LEFT JOIN visits
    ON visits."urlId" = "shortUrl".id
    GROUP BY users.id
    ORDER BY "visitCount" DESC
    limit 10`
    )
res.status(200).send(rank)
}