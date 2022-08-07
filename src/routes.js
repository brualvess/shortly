import { Router } from 'express';
import { createUsers,
         loginUsers,
         listUsers
} from './controllers/usersControllers.js';
import { shortenUrl,
         listUrlId,
         redirectUrl,
         deleteUrl
 } from './controllers/urlsControllers.js';
 import { ranking } from './controllers/rankingControllers.js';

const router = Router()

// users routes
router.post('/signup', createUsers)
router.post('/signin',loginUsers )
router.get('/users/me',listUsers )
// url routes
router.post('/urls/shorten', shortenUrl)
router.get('/urls/:id', listUrlId)
router.get('/urls/open/:shortUrl', redirectUrl)
router.delete('/urls/:id', deleteUrl)
// rankikng routes
router.get('/ranking', ranking)


export default router