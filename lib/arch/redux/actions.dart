
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskIntern/arch/models/appstate.dart';

ThunkAction<AppState> getInfoAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final bool auth = prefs.getBool('auth');
  final String name = prefs.getString('name');
  final String address = prefs.getString('address');
  final String phoneNo = prefs.getString('phoneNo');
  store.dispatch(GetInfoAction(name, address, phoneNo, auth));
  print("action area $auth");
};

class GetAuthAction{
  

  

  GetAuthAction();
}

class GetInfoAction{
  final bool _auth;
  final String _name;
  final String _address;
  final String _phoneNo;

  bool get auth => this._auth;
  String get name => this._name;
  String get address => this._address;
  String get phoneNo => this._phoneNo;
  
  GetInfoAction(this._name, this._address, this._phoneNo, this._auth);
}