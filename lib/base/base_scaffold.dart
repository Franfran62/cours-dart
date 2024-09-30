import 'package:cours_flutter/base/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Basescaffold extends StatelessWidget {
  final Widget body;
  dynamic _scaffoldKey;

  Basescaffold({
    super.key,
    required this.body
  }) {
     _scaffoldKey = GlobalKey<ScaffoldState>();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        drawer: const Menu(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              }
          ),
        ),
          body: body
      );
  }
}




