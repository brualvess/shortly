import { Router } from 'express';
import { createUsers } from './controllers/usersControllers.js';

const router = Router()

// users routes
router.post('/signup', createUsers)


export default router