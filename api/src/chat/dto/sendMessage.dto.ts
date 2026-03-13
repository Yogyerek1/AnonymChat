import { IsNotEmpty, IsString, IsUUID } from 'class-validator';

export class SendMessageDto {
  @IsUUID()
  code: string;

  @IsString()
  @IsNotEmpty()
  senderName: string;

  @IsString()
  @IsNotEmpty()
  content: string;
}
