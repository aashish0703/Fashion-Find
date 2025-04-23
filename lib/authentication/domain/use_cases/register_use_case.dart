import 'package:fashion_find/authentication/domain/entities/register_entity.dart';
import 'package:fashion_find/authentication/domain/repositories/authentication_repository.dart';

class RegisterUseCase {

  final AuthenticationRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call(RegisterEntity registerEntity) async {
    return await repository.register(registerEntity);
  }
}