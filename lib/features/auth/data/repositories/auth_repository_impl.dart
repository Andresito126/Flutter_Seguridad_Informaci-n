import '../../../../shared/errors/exceptions.dart';
import '../../../../shared/results/results.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/remote/api/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({
    required this.authApi,
  });

  @override
  Future<Result<void>> register(
      String email,
      String password,
      ) async {
    try {
      await authApi.register(email: email, password: password);
      return Success(null);
    } catch (e) {
      return Failure("Registro fallido");
    }
  }

  @override
  Future<Result<TokenEntity>> login(
      String email,
      String password
      ) async {
    authApi.login(email: email, password: password);
    try {
      final token = await authApi.login(email: email, password: password);

      return Success(token.toEntity());
    } on UnauthorizedException catch(e) {
      return Failure(e.message);
    } on ServerException catch(e) {
      return Failure(e.message);
    } catch (_) {
      return Failure("Error inesperado");
    }
  }
}