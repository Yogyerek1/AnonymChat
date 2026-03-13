import { IsNotEmpty, IsString, MinLength } from 'class-validator';

export class CreateChatDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  password: string;

  @IsString()
  @IsNotEmpty()
  ownerName: string;
}
