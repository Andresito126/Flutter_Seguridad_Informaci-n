import '../../../../domain/entities/user_entity.dart';

class UserDto {
  final int id;
  final String email;
  final String password;

  UserDto({
    required this.id,
    required this.email,
    required this.password,
  });

  UserDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  UserEntity toEntity(){
    return UserEntity(
      id: id,
      email: email,
      password: password
    );
  }
}