import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  
  final _formInscriptionKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});


    @override
    Widget build(BuildContext context, WidgetRef ref) {

 
      submitForm() async {
        if (_formInscriptionKey.currentState != null &&
            _formInscriptionKey.currentState!.validate()) {

          bool registering = await ref.read(userProvider.notifier).login(
            email: _emailController.text, 
            password: _passwordController.text
            );

          if (registering) {
            _formInscriptionKey.currentState!.reset();
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Connexion réussie !"))
            );
            Navigator.of(context).pushReplacementNamed('/');
          }
        }
      }

      return Basescaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                    "Connexion",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                  )
                    ,
                ),
              ),
              Form(
                key: _formInscriptionKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 100, left: 100),
                  child:
                    Column(
                      children: [ 
                    TextFormField(
                              controller: _emailController,
                          //    decoration: setInputDecoration(const Icon(Icons.email), "Email"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez saisir votre email";
                                }
                                if (!value.contains('@')) {
                                  return "Veuillez saisir un email valide";
                                }
                                return null;
                              },
                            ),
                    TextFormField(
                            controller: _passwordController,
                          //  decoration: setInputDecoration(const Icon(Icons.password), "Mot de passe"),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir un mot de passe";
                              }
                              if (value.length < 6 || value.isNotEmpty && value.toLowerCase() == value) {
                                return "Votre mot de passe est incorrect";
                              }
                              return null;
                            },
                          ),
                    Padding(
                              padding: const EdgeInsets.only(top:25.0),
                              child: ElevatedButton(
                                  onPressed: submitForm,
                                  style:
                                  const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.orangeAccent)
                                  ),
                                  child: const Text(
                                    "S'inscrire",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18
                                    ),
                                  )
                                )
                              )
                      ],
                  )
                )
              )
            ]
          ),
        )
      );
    }
}