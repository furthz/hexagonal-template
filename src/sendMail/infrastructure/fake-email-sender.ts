import { Level, Logger } from 'nexuxlog';

import { EmailSender } from '@domain/email-sender';

export class FakeEmailSender implements EmailSender {
  public async send(email: string, text: string): Promise<void> {
    Logger.message(Level.debug, { email, text }, '-1', 'simulando email');
  }
}
