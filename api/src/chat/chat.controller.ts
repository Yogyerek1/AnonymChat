import { Body, Controller, Inject, Post } from '@nestjs/common';
import { CreateChatDto } from './dto/createChat.dto';
import { ChatService } from './chat.service';
import { JoinChatDto } from './dto/joinChat.dto';

@Controller('chats')
export class ChatController {
  constructor(private chatService: ChatService) {}

  @Post()
  createChat(@Body() body: CreateChatDto) {
    return this.chatService.createChat(body);
  }

  @Post('join')
  joinChat(@Body() body: JoinChatDto) {
    return this.chatService.joinChat(body);
  }
}
