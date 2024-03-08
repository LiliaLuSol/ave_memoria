part of 'authentication_bloc.dart';

@immutable
class AuthenticationState extends Equatable {
  final bool isShowPassword;
  final bool isShowPassword1;
  bool wantNewsInfo;
  bool isSelectedSwitch;
  final TextEditingController? emailController;
  final TextEditingController? inputfieldoneController;
  final AuthenticationModel? authenticationModelObj;
  final bool isEmailVerified;

  AuthenticationState({
    this.isShowPassword = true,
    this.isShowPassword1 = true,
    this.emailController,
    this.inputfieldoneController,
    this.authenticationModelObj,
    this.wantNewsInfo = false,
    this.isSelectedSwitch = false,
    this.isEmailVerified = false
  });

  AuthenticationState copyWith({
    bool? isShowPassword,
    bool? isShowPassword1,
    TextEditingController? emailController,
    TextEditingController? inputfieldoneController,
    AuthenticationModel? authorizationModelObj,
    bool? wantNewsInfo,
    bool? isSelectedSwitch,
    bool? isEmailVerified
  }) {

    return AuthenticationState(
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isShowPassword1: isShowPassword1 ?? this.isShowPassword1,
      emailController: emailController ?? this.emailController,
      wantNewsInfo: wantNewsInfo ?? this.wantNewsInfo,
      inputfieldoneController: inputfieldoneController ?? this.inputfieldoneController,
      authenticationModelObj: authorizationModelObj ?? this.authenticationModelObj,
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [
    isShowPassword,
    isShowPassword1,
    emailController,
    inputfieldoneController,
    authenticationModelObj,
    wantNewsInfo,
    isSelectedSwitch,
    isEmailVerified
  ];
}
class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class GoogleAuthLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthenticationState {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class UnAuthenticatedState extends AuthenticationState {
  UnAuthenticatedState();
  @override
  List<Object?> get props => [];
}