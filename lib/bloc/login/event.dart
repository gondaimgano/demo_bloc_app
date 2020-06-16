import 'package:demoblocapp/model/login_request.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
 final LoginRequest loginRequest;
 LoginEvent([this.loginRequest]);
  @override
  List<Object> get props => [loginRequest];
}

class SubmitLogin extends LoginEvent{
  SubmitLogin([LoginRequest request]):super(request);
}