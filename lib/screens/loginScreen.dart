import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskIntern/service/authService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  
  String _name, _address, _phoneNo, _verificationID;
  bool _numVerified = false;
  double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey =GlobalKey<ScaffoldState>();

    Future<void> _verifyPhone(phoneNo) async {
    try {
      final PhoneVerificationCompleted verified = (AuthCredential authResult) {
        AuthService().signIn(authResult);
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
        Text('${authException.message}');
      };
      final PhoneCodeSent smsSent = (String verId, [int forceSend]) {
        _verificationID = verId;
      };
      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        this._verificationID = verId;
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: verificationFailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);
      
  

      print(_phoneNo);
    } catch (e) {
      Future.delayed(Duration(seconds: 2), () {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("error"), duration: Duration(seconds: 2),));
        print('Mobile Auth Error');
      });
      
      
    }
  }

  
  
  

  Widget appBar() {
    return Container(
      alignment: Alignment.center,
      height: screenHeight*0.1,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF022c43),
        borderRadius: BorderRadius.circular(30),
        // boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
      ),
      child: Text("Login", style: TextStyle(color: Color(0xFFFFD700), fontSize: 30),),
    );
  }

  Widget loginSheet() {
    return Container(
      height: screenHeight *0.53,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xFF022c43),
        borderRadius: BorderRadius.circular(30),
        // boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.05,),
            _nameInput(),
            SizedBox(height: screenHeight * 0.05,),
            _addressInput(),
            SizedBox(height: screenHeight * 0.05,),
            _phoneInput()
            
          ],
        ),
      ),
    );
  }

  Widget _nameInput() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF115173), width: 2),
                borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF115173), width: 2),
                borderRadius: BorderRadius.circular(30)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            hintText: 'Name',
            suffixIcon: Icon(
              Icons.account_circle,
              color: Color(0xFFffd700),
            ),
            hintStyle: TextStyle(
                color: Color(0xFFffd700), fontWeight: FontWeight.bold, fontSize: 18),
            contentPadding: EdgeInsets.all(15),
            focusColor: Color(0xFF115173),
            hoverColor: Color(0xFF115173),
            filled: true,
            fillColor: Color(0xFF115173),
        ),
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        cursorColor: Colors.white,
        style: TextStyle(color: Color(0xFFffd700)),
        validator: (input) {return input.length <=2? 'Enter a valid name' : null;},
        onChanged: (value) {
          setState(() {
            this._name = value;
          });
        },
        onSaved: (input) => _name = input,
      ),
    );
  }
  Widget _addressInput() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          counterStyle: TextStyle(color: Color(0xFFffd700)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF115173), width: 2),
                borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF115173), width: 2),
                borderRadius: BorderRadius.circular(30)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            hintText: 'Address',
            suffixIcon: Icon(
              Icons.short_text,
              color: Color(0xFFffd700),
            ),
            hintStyle: TextStyle(
                color: Color(0xFFffd700), fontWeight: FontWeight.bold, fontSize: 18),
            contentPadding: EdgeInsets.all(15),
            focusColor: Color(0xFF115173),
            hoverColor: Color(0xFF115173),
            filled: true,
            fillColor: Color(0xFF115173),
        ),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        style: TextStyle(color: Color(0xFFffd700)),
        maxLength: 50,
        keyboardAppearance: Brightness.dark,
        validator: (input) {
          return input.length <= 10 ? 'Enter a valid address' : null;
        },
        onChanged: (value) {
          setState(() {
            this._address = value;
          });
        },
        onSaved: (input) => _address = input,
      ),
    );
  }
  
  Widget _phoneInput() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF115173), width: 2),
                borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF115173), width: 2),
                borderRadius: BorderRadius.circular(30)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            hintText: 'Mobile Number',
            suffixIcon: Icon(
              Icons.phone_android,
              color: Color(0xFFffd700),
            ),
            hintStyle: TextStyle(
                color: Color(0xFFffd700), fontWeight: FontWeight.bold, fontSize: 18),
            contentPadding: EdgeInsets.all(15),
            focusColor: Color(0xFF115173),
            hoverColor: Color(0xFF115173),
            filled: true,
            fillColor: Color(0xFF115173),
        ),
        keyboardType: TextInputType.phone,
        keyboardAppearance: Brightness.dark,
        cursorColor: Colors.white,
        style: TextStyle(color: Color(0xFFffd700)),
        validator: (input) {
          return input.length != 10 ? 'Enter a valid number' : null;
        },
        onChanged: (value) {
          setState(() {
            this._phoneNo = '+91' + value;
          });
        },
        onSaved: (input) => _phoneNo = '+91' + input,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
        body: Container(
          color: Color(0xFF053F5E),
          child: ListView(
            children: <Widget>[
              appBar(),
              SizedBox(height: screenHeight*0.1,),
              loginSheet()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFF022C43),
          label: Text('SignUp', style: TextStyle(color: Color(0xFFFFD700)),),
          icon: Icon(Icons.arrow_forward_ios, color: Color(0xFFFFD700),),
          onPressed: (){
            if(_formKey.currentState.validate()){
              
              _formKey.currentState.save();
              AuthService().saveData(_name, _address, _phoneNo);
              // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Singining In"), duration: Duration(seconds: 5),));
              _verifyPhone(_phoneNo).whenComplete(() {
                
                Navigator.of(context).pushReplacementNamed('/home');
              });
            }
          },
        ),
    );
  }
}
