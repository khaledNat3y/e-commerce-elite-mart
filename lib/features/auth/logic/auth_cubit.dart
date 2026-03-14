import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/repos/auth_repo.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _authRepo.register(name: name, email: email, password: password);
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthFailure(_parseError(e.toString())));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _authRepo.login(email: email, password: password);
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthFailure(_parseError(e.toString())));
    }
  }

  Future<void> logout() async {
    await _authRepo.logout();
    emit(AuthInitial());
  }

  String _parseError(String error) {
    if (error.contains('user-not-found')) return 'No account found with this email.';
    if (error.contains('wrong-password')) return 'Incorrect password.';
    if (error.contains('email-already-in-use')) return 'This email is already registered.';
    if (error.contains('weak-password')) return 'Password must be at least 6 characters.';
    if (error.contains('invalid-email')) return 'Please enter a valid email.';
    return 'Something went wrong. Please try again.';
  }
}