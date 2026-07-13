part of 'sighn_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpSuccess extends SignUpState {}
final class SignUpFail extends SignUpState {}
final class SignUpError extends SignUpState {}
final class SignUpSaveLevelSuccess extends SignUpState {}
final class SignUpChangePasswordVisibility extends SignUpState {}
