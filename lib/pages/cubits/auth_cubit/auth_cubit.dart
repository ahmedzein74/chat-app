import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'user not found '));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'Wrong passwod'));
      } else {
        emit(LoginFailure(errMessage: 'there was an error'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'some thing want wrong'));
    }
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(Registersuccess());
    } on FirebaseAuthException catch (ex) {
      // Handle specific Firebase authentication errors
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: 'Email already exists'));
      }
    } catch (ex) {
      // Handle general errors
      emit(RegisterFailure(errMessage: "There was an error"));
    }
  }
}
