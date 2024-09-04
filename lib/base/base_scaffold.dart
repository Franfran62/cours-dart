import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Basescaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const Basescaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          title: Row(
            children: [
              const Image(image: AssetImage("assets/logo-foreach.png")),
              Text(title),
              IconButton(onPressed: () => {
                Navigator.of(context).pushNamed("/inscription")
              }, icon: const Icon((Icons.app_registration)))
            ],
          )
      ),
        body: body
    );
  }
}




