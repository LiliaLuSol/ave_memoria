// part of 'authentication_bloc.dart';
//
// @immutable
// abstract class AuthenticationEvent extends Equatable {
//   const AuthenticationEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class EmailSignInAuthEvent extends AuthenticationEvent {
//   final String email, password;
//
//   const EmailSignInAuthEvent(this.email, this.password);
//
//   @override
//   List<Object> get props => [email, password];
// }
//
// class EmailSignUpAuthEvent extends AuthenticationEvent {
//   final String email, password;
//
//   const EmailSignUpAuthEvent(this.email, this.password);
//
//   @override
//   List<Object> get props => [email, password];
// }
//
// class GoogleAuthEvent extends AuthenticationEvent {
//   const GoogleAuthEvent();
// }
//
// class SignOutEvent extends AuthenticationEvent {
//   const SignOutEvent();
// }
//
// class ChangePasswordVisibilityEvent extends AuthenticationEvent {
//   final bool value;
//
//   ChangePasswordVisibilityEvent({
//     required this.value,
//   });
// }
//
// class ChangePassword1VisibilityEvent extends AuthenticationEvent {
//   final bool value;
//
//   ChangePassword1VisibilityEvent({
//     required this.value,
//   });
// }
//
// class ChangeCheckBoxEvent extends AuthenticationEvent {
//   ChangeCheckBoxEvent({required this.value});
//   bool value;
//
//   @override
//   List<Object> get props => [value];
// }
//
// class ChangeSwitchEvent extends AuthenticationEvent {
//   ChangeSwitchEvent({required this.value});
//   bool value;
//
//   @override
//   List<Object> get props => [value,];
// }