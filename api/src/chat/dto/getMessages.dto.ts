import { IsNotEmpty, IsString, IsUUID, MinLength } from 'class-validator';

export class GetMessagesDto {
  @IsUUID()
  code: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  password: string;
}
