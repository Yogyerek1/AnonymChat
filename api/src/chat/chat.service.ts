import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Chat } from '../entities/chat.entity';
import { Message } from '../entities/message.entity';
import { Repository } from 'typeorm';
import { CreateChatDto } from './dto/createChat.dto';
import * as bcrypt from 'bcrypt';
import { JoinChatDto } from './dto/joinChat.dto';
import { SendMessageDto } from './dto/sendMessage.dto';
import { GetMessagesDto } from './dto/getMessages.dto';

@Injectable()
export class ChatService {
  constructor(
    @InjectRepository(Chat) private chatRepository: Repository<Chat>,
    @InjectRepository(Message) private messageRepository: Repository<Message>,
  ) {}

  async createChat(dto: CreateChatDto) {
    const chat = this.chatRepository.create({
      name: dto.name,
      password: await bcrypt.hash(dto.password, 10),
      ownerName: dto.ownerName,
    });

    const saved = await this.chatRepository.save(chat);

    return {
      id: saved.id,
      name: saved.name,
      ownerName: saved.ownerName,
    };
  }

  async joinChat(dto: JoinChatDto) {
    const chat = await this.chatRepository.findOne({ where: { id: dto.code } });

    if (!chat) {
      return { approved: false };
    }

    const isMatch = await bcrypt.compare(dto.password, chat.password);

    return { approved: isMatch };
  }

  async sendMessage(dto: SendMessageDto) {
    const chat = await this.chatRepository.findOne({ where: { id: dto.code } });

    if (!chat) {
      throw new NotFoundException('Chat not found');
    }

    const message = this.messageRepository.create({
      content: dto.content,
      senderName: dto.senderName,
      chat: chat,
    });

    await this.messageRepository.save(message);

    return { content: dto.content, senderName: dto.senderName };
  }

  async getMessages(dto: GetMessagesDto) {
    const chat = await this.chatRepository.findOne({ where: { id: dto.code } });

    if (!chat) {
      throw new NotFoundException('Chat not found');
    }

    const isMatch = await bcrypt.compare(dto.password, chat.password);
    if (!isMatch) {
      throw new UnauthorizedException('Wrong password');
    }

    return await this.messageRepository.find({
      where: { chat: { id: dto.code } },
      order: { createdAt: 'ASC' },
    });
  }
}
