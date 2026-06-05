import '../../../../shared/results/results.dart';
import '../entities/token_entity.dart';

abstract class AuthRepository {
  Future<Result<void>> register(String email, String password);
  Future<Result<TokenEntity>> login(String email, String password);
}