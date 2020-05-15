import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:taskIntern/arch/models/appstate.dart';
import 'package:taskIntern/arch/redux/actions.dart';
import 'package:taskIntern/arch/redux/reducer.dart';
import 'package:taskIntern/screens/homescreen.dart';
import 'package:taskIntern/screens/loginScreen.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);

  runApp(MyApp(store: store));
}


class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        routes: {
          '/home': (BuildContext context) => HomeScreen(
            onInit: (){
              StoreProvider.of<AppState>(context).dispatch(getInfoAction);
            }
          ),
          '/login': (BuildContext context) => LoginScreen(),
        },
        home: LoginScreen(),
      ),
    );
  }
}