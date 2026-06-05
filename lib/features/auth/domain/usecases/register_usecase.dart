import '../../../../shared/results/results.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({
    required this.repository,
  });

  Future<Result<void>> call(String email, String password) {
    return repository.register(email, password);
  }
}