export interface EmailSender {
  send(email: string, text: string): Promise<void>;
}
