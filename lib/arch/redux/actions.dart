
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskIntern/arch/models/appstate.dart';

ThunkAction<AppState> getInfoAction(){
  return (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  
  final String name = prefs.getString('name');
  final String address = prefs.getString('address');
  final String phoneNo = prefs.getString('phoneNo');
  store.dispatch(GetInfoAction(name, address, phoneNo));
  
};
} 

ThunkAction<AppState> getAuthAction(BuildContext context){
  return (Store<AppState> store) async{
    final prefs = await SharedPreferences.getInstance();
    final bool auth = prefs.getBool('auth');
    if(auth == false){
    Navigator.of(context).pushReplacementNamed('/login');
  }
  };
}

class GetAuthAction{
  final bool _auth;
  bool get auth => this._auth;
  GetAuthAction(this._auth);
}


class GetInfoAction{
  final String _name;
  final String _address;
  final String _phoneNo;

  String get name => this._name;
  String get address => this._address;
  String get phoneNo => this._phoneNo;
  
  GetInfoAction(this._name, this._address, this._phoneNo,);
}