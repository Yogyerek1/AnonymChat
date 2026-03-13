import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Chat } from './entities/chat.entity';
import { Message } from './entities/message.entity';
import { ChatModule } from './chat/chat.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'postgres',
      password: 'jelszo123',
      database: 'anonymchat',
      entities: [Chat, Message],
      synchronize: true, // in production mode FALSE
    }),
    ChatModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
