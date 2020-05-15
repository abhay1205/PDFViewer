import 'package:meta/meta.dart';

@immutable

class AppState{

  final bool auth;
  final String name;
  final String address;
  final String phoneNo;
  AppState({
    @required this.auth,
    @required this.name,
    this.address,
    @required this.phoneNo
  });

  factory AppState.initial(){
    return AppState(
      auth: false,
      name: "test",
      address: 'test bed',
      phoneNo: '1234567890'
    );
  }
}