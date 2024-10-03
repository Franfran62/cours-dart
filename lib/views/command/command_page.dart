import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/providers/command_provider.dart';
import 'package:cours_flutter/views/command/widgets/command_user_card.dart';
import 'package:cours_flutter/views/home/widgets/cart_button.dart';
import 'package:cours_flutter/views/home/widgets/dropdown_size_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommandPage extends ConsumerWidget {

  const CommandPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final command = ref.watch(commandStreamProvider);

    return Basescaffold(
        body: Center(
          child: command.when(
                    data: (data) { 
                      return data.isNotEmpty 
                      ? Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 40, bottom: 20),
                              child: Text("La commande du jour",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListView(
                              shrinkWrap: true,
                              children: data.map((commandUser) => CommandUserCard(commandUser: commandUser)).toList(),
                              ),
                            ],
                      )
                      : const Text("Aucune commande n'a été passée ce jour ...");
                    },
                    error: ( error, stack) { return Text(error.toString()); 
                    }, 
                    loading: () { return const CircularProgressIndicator(); 
                    },
                )
        )
    );
  }
}
             
        
    
 


