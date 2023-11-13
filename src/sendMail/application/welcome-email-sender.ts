import { EmailSender } from '@domain/email-sender';
import { UserRepository } from '@domain/user-repository';

export class WelcomeEmailSender {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly emailSender: EmailSender
  ) {}

  public async run(userId: string): Promise<void> {
    const user = await this.userRepository.getById(userId);

    if (!user) {
      throw new Error(`User id not found ${userId}`);
    }
    await this.emailSender.send(user.email, 'Bienvenidos a la aplicación');
  }
}
