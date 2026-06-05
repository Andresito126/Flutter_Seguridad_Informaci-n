
import '../../../../../../shared/models/dtos/message_dto.dart';
import '../../../../../../shared/network/api_client.dart';
import '../models/token_dto.dart';
import '../models/user_dto.dart';

class AuthApi {
  final ApiClient apiClient;

  AuthApi({
    required this.apiClient,
  });

  Future<MessageDto> register({
    required String email,
    required String password,
  }) async {
    final newUser = UserDto(id: 0, email: email, password: password);
    final response = await apiClient.post(
      '/auth/register',
      body: newUser.toJson(),
    );

    return MessageDto.fromJson(response);
  }

  Future<TokenDto> login({
    required String email,
    required String password,
  }) async {
    final user = UserDto(id: 0, email: email, password: password);
    final response = await apiClient.post(
      '/auth/login',
      body: user.toJson(),
    );

    return TokenDto.fromJson(response);
  }
}