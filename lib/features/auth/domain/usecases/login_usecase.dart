import '../../../../shared/results/results.dart';
import '../entities/token_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({
    required this.repository
  });

  Future<Result<TokenEntity>> call(String email, String password){
    return repository.login(email, password);
  }
}