import '../../../../domain/entities/token_entity.dart';

class TokenDto {
  final String token;

  TokenDto({
    required this.token
  });

  TokenDto.fromJson(Map<String, dynamic> json)
    :
      token = json['token'];

  TokenEntity toEntity(){
    return TokenEntity(token: token);
  }
}