import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  final String message;
  LoginState([this.message]);
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState{}

class LoginInProgress extends LoginState{}

class LoginSuccess extends LoginState{}

class LoginFailure extends LoginState{}



