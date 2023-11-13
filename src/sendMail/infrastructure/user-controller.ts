import { Request, Response } from 'express';

import { WelcomeEmailSender } from '@application/welcome-email-sender';

export class UserController {
  constructor(private readonly welcomeEmailSender: WelcomeEmailSender) {}

  public async run(request: Request, res: Response): Promise<void> {
    const userId = request.params.id;
    await this.welcomeEmailSender.run(userId);
    res.status(200).send();
  }
}
