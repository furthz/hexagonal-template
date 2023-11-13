import { WelcomeEmailSender } from '@application/welcome-email-sender';
import { FakeEmailSender } from '@infrastructure/fake-email-sender';
import { InMemoryUserRepository } from '@infrastructure/in-memory-user-repository';

describe('WelcomeEmailSender', () => {
  let welcomeEmailSender: WelcomeEmailSender;
  let repository: InMemoryUserRepository;
  let emailSender: FakeEmailSender;

  beforeEach(() => {
    repository = new InMemoryUserRepository();
    emailSender = new FakeEmailSender();
    welcomeEmailSender = new WelcomeEmailSender(repository, emailSender);
  });

  describe('Enviar', () => {
    it('deberia ejecutar el envio sin error', async () => {
      await expect(welcomeEmailSender.run('1')).resolves.not.toThrow();
    });
  });
});
