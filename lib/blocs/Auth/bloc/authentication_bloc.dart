import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ave_memoria/blocs/Auth/models/authentication_model.dart';
import 'package:ave_memoria/utils/servies/auth_service.dart';

part 'authentication_event.dart';
part 'Authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authservice = AuthService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<EmailSignInAuthEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authservice.signInWithEmail(
            email: event.email, password: event.password);
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<EmailSignUpAuthEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authservice.signUpWithEmail(
            email: event.email, password: event.password);
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<GoogleAuthEvent>((event, emit) async {
      emit(GoogleAuthLoadingState());
      try {
        await _authservice.signInWithGoogle();
        // emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      try {
        await _authservice.signOut();

        emit(UnAuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<ChangePasswordVisibilityEvent>((event, emit) {
      final currentState = state;
      emit(currentState.copyWith(isShowPassword: event.value));
    });

    on<ChangePassword1VisibilityEvent>((event, emit) {
      final currentState = state;
      emit(currentState.copyWith(isShowPassword1: event.value));
    });

    on<ChangeCheckBoxEvent>((event, emit){
      emit(state.copyWith(wantNewsInfo: event.value));
    });

    on<ChangeSwitchEvent>((event, emit){
      emit(state.copyWith(isSelectedSwitch: event.value));
    }
    );
    }
}
