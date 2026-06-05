import '../../data/datasource/remote/models/user_dto.dart';

class UserEntity {
  final int id;
  final String email;
  final String password;

  UserEntity({
    this.id = 0,
    required this.email,
    required this.password,
  });

  UserDto toDto(){
    return UserDto(
        id: id,
        email: email,
        password: password
    );
  }
}