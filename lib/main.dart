import 'package:demoblocapp/bloc/login/bloc.dart';
import 'package:demoblocapp/bloc/login/event.dart';
import 'package:demoblocapp/bloc/login/state.dart';
import 'package:demoblocapp/model/login_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_)=>LoginBloc(),
      child: MaterialApp(
        title: 'Bloc Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:MyLogin(),
      ),
    );
  }
}



class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var usernameController=TextEditingController();

  var passwordController=TextEditingController();
  final GlobalKey<FormState> _key=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc,LoginState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context,LoginState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                validator: (s)=>s.isEmpty?"Please supply valid value":null,
                decoration: InputDecoration(
                  hintText: "Username"
                ),
              ),
              SizedBox(height: 12,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (s)=>s.isEmpty?"Please supply valid value":null,
                decoration: InputDecoration(
                    hintText: "Password"
                ),
              ),
              SizedBox(height: 12,),
              RaisedButton(
                onPressed: (){
                  if(_key.currentState.validate())
                  context.bloc<LoginBloc>().add(SubmitLogin(
                    LoginRequest(
                      username: usernameController.text,
                      password: passwordController.text
                    )
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, LoginState state) {
    if(state is LoginInProgress)
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new WillPopScope(
                onWillPop: () async => false,
                child: SimpleDialog(
                   // key: key,
                    backgroundColor: Colors.black54,
                    children: <Widget>[
                      Center(
                        child: Column(children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10,),
                          Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                        ]),
                      )
                    ]));
          });
    if(state is LoginFailure)
      {
        Navigator.of(context).pop();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("A network Error"),));
      }
    if(state is LoginSuccess)
      {
        Navigator.of(context).pop();
       Scaffold.of(context).showSnackBar(SnackBar(content: Text("Hurray!!"),));
      }
  }
}

