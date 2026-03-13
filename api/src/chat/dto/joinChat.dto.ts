import { IsString, IsUUID, MinLength } from 'class-validator';

export class JoinChatDto {
  @IsUUID()
  code: string;

  @IsString()
  @MinLength(6)
  password: string;
}
