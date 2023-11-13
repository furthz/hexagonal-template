import { WelcomeEmailSender } from '@application/welcome-email-sender';

import { FakeEmailSender } from './fake-email-sender';
import { InMemoryUserRepository } from './in-memory-user-repository';
import { UserController } from './user-controller';

const inMemoryUserRepository = new InMemoryUserRepository();
const fakeEmailSender = new FakeEmailSender();

const welcomeEmailSender = new WelcomeEmailSender(inMemoryUserRepository, fakeEmailSender);
const userController = new UserController(welcomeEmailSender);

export { userController, welcomeEmailSender };
