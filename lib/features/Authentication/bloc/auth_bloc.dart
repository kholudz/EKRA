import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekra/features/personalization/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserModel? user;
  AuthBloc() : super(AuthInitial()) {
    FirebaseAuth auth = FirebaseAuth.instance;
    on<LoginEvent>((event, emit) async {
      emit(LoginInProgress());
      try {
        await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (!auth.currentUser!.emailVerified) {
          await auth.currentUser!.sendEmailVerification();
          emit(VerifyEmail());
        } else {
          emit(const LoginSuccess());
        }
      } on FirebaseException catch (e) {
        emit(LoginFailure(errorMessage: e.message ?? 'An error occurred'));
      } catch (e) {
        emit(LoginFailure(errorMessage: e.toString()));
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(SignUpInProgress());
      try {
        await auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await auth.currentUser!.sendEmailVerification();
        await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
          'fullName': event.fullName,
          'email': event.email,
          'phone': event.phoneNumber,
          'profilePicture': '',
          'bio': '',
        });
        emit(VerifyEmail());
      } on FirebaseException catch (e) {
        emit(SignUpFailure(errorMessage: e.message ?? 'An error occurred'));
      } catch (e) {
        emit(SignUpFailure(errorMessage: e.toString()));
      }
    });
    on<GetCurrentUserEvent>((event, emit) async {
      try {
        final result = await FirebaseFirestore.instance
            .collection('users')
            .doc(
              auth.currentUser!.uid,
            )
            .get();
        user = UserModel.fromSnapshot(result);
      } on FirebaseException catch (e) {
        emit(SignUpFailure(errorMessage: e.code));
      } catch (e) {
        throw Exception(e);
      }
    });
    on<ResendVerificationEmailEvent>((event, emit) async {
      emit(ResendVerificationEmailInProgress());
      try {
        await auth.currentUser!.sendEmailVerification();
        emit(const ResendVerificationEmailSuccess());
      } on FirebaseException catch (e) {
        emit(ResendVerificationEmailFailure(errorMessage: e.code));
      } catch (e) {
        emit(ResendVerificationEmailFailure(errorMessage: e.toString()));
      }
    });
  }
}
