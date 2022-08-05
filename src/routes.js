import { Router } from 'express';
import { createUsers,
         loginUsers
} from './controllers/usersControllers.js';
import { shortenUrl } from './controllers/urlsControllers.js';

const router = Router()

// users routes
router.post('/signup', createUsers)
router.post('/signin',loginUsers )
// url routes
router.post('/urls/shorten', shortenUrl)


export default router