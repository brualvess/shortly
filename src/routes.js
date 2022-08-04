import { Router } from 'express';
import { createUsers,
         loginUsers
} from './controllers/usersControllers.js';

const router = Router()

// users routes
router.post('/signup', createUsers)
router.post('/signin',loginUsers )


export default router