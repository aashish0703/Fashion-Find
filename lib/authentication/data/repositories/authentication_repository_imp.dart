import 'package:fashion_find/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:fashion_find/authentication/data/model/login_model.dart';
import 'package:fashion_find/authentication/data/model/register_model.dart';
import 'package:fashion_find/authentication/domain/entities/login_entity.dart';
import 'package:fashion_find/authentication/domain/entities/register_entity.dart';
import 'package:fashion_find/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {

  final AuthRemoteDataSource authRemoteDataSource;

  AuthenticationRepositoryImp({required this.authRemoteDataSource});

  @override
  Future<UserCredential?> login(LoginEntity loginEntity) async {
    // TODO: implement login
    final loginModel = LoginModel(email: loginEntity.email, password: loginEntity.password);
    final userCredential = await authRemoteDataSource.login(loginModel);

    return userCredential;
  }

  @override
  Future<UserCredential?> register(RegisterEntity registerEntity) async {
    // TODO: implement register
    final registerModel = RegisterModel(name: registerEntity.name, email: registerEntity.email, password: registerEntity.password, contact: registerEntity.contact);
    final userCredentials = await authRemoteDataSource.register(registerModel);

    return userCredentials;
  }

  @override
  Future<void> saveDataToFireStore(User user) async {
    // TODO: implement saveDataToFireStore
    await authRemoteDataSource.saveDataToFireStore(user);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    final userCredentials = await authRemoteDataSource.signInWithGoogle();
    await authRemoteDataSource.saveDataToFireStore(userCredentials.user!);

    return userCredentials;
  }
  
}