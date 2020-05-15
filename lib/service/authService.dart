

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  saveData(String name, String address, String phoneNo)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('address', address);
    prefs.setString('phoneNo', phoneNo);
    
  }

  signOut(){
    FirebaseAuth.instance.signOut().whenComplete(() async{
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
    });
  }

  signIn(AuthCredential authCredential){
    FirebaseAuth.instance.signInWithCredential(authCredential).whenComplete(() async{
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      bool auth = prefs.getBool('auth');
      print('aervice' + auth.toString());
    });
  }
}