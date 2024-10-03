import 'package:cours_flutter/models/command_user.dart';
import 'package:flutter/material.dart';

class CommandUserCard extends StatelessWidget {

  final CommandUser commandUser;

  const CommandUserCard({required this.commandUser});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(commandUser.userLinked.username),
          Text(commandUser.total.toString()),
          Text(commandUser.paiementType.name ?? ""),
        ],
      ),
    );
  }
}