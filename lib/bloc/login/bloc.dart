import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:demoblocapp/bloc/login/event.dart';
import 'package:demoblocapp/bloc/login/state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is SubmitLogin)
      yield* _mapSubmitToState(event);
  }

  Stream<LoginState> _mapSubmitToState(SubmitLogin event) async*{
    final pp=Random();
    try{
      yield LoginInProgress();
      var p=await Future.delayed(Duration(seconds: 3),(){

        if(pp.nextBool()==true) throw Exception("Hello!!!");

          return true;
      });
      //if(p) throw Exception("Failed");
      yield LoginSuccess();
    }catch(ex){
      yield LoginFailure();
    }
  }

}