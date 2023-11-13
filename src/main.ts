import './load-env-vars';

import express from 'express';
import { Level, Logger } from 'nexuxlog';

import { userRouter } from '@infrastructure/user-router';

import { config } from './config';

function boostrap(): void {
  const app = express();

  app.use(express.json());

  app.use('/users', userRouter);

  const { port } = config.server;

  app.listen(port, () => {
    Logger.message(Level.info, {}, '-1', 'Server Inicializado');
  });
}

boostrap();
