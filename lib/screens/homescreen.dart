import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:taskIntern/arch/models/appstate.dart';
import 'package:taskIntern/service/authService.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;
  HomeScreen({this.onInit});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    widget.onInit();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double screenHeight;
  String _path, _fileName;
  Map<String, String> _paths;
  bool auth, _loadingPath = false;
  File file;
  PDFDocument doc;

  checkAuth(bool auth) {
    if (auth == false) {
      print("check " + auth.toString());
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _paths = null;

      _path = await FilePicker.getFilePath(
          type: FileType.custom, allowedExtensions: ['pdf']);
      // print("Path " + _path);

      await FilePicker.getFile(
          type: FileType.custom, allowedExtensions: ['pdf']).then((value) {
        file = value;
      });
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    var pdf = await PDFDocument.fromFile(file);
    setState(() {
      doc = pdf;
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, AppState>(
      converter: (store) =>store.state,
      builder: (context, state) {
        auth = state.auth;
        print(" 3 home auth " + auth.toString());
        // checkAuth(auth);
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xff022c43),
            title: Text('Add pdf'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () {
                  AuthService().signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
          body: Container(
            child: Center(
                child: Container(
              height: screenHeight * 0.7,
              child: doc != null
                  ? PDFViewer(document: doc)
                  : Text("PDF will be displayed here"),
            )),
          ),
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Color(0xff022c43),
              label: Text("Add PDF"),
              icon: Icon(Icons.add),
              onPressed: _openFileExplorer),
        );
      },
    );
  }
}
