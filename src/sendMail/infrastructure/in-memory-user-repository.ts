import { User } from '@domain/user';
import { UserRepository } from '@domain/user-repository';

const users: User[] = [
  {
    id: '1',
    email: 'raul.talledo@gmail.com'
  },
  {
    id: '2',
    email: 'otrocorreo@gmail.com'
  }
];

export class InMemoryUserRepository implements UserRepository {
  public async getById(userId: string): Promise<User | null> {
    const userFound = users.find(user => user.id === userId);

    if (!userFound) {
      return null;
    }
    return userFound;
  }
}
