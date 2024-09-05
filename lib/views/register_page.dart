import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/models/promo.dart';
import 'package:cours_flutter/models/user.dart';
import 'package:flutter/material.dart';

class MyInscriptionPage extends StatefulWidget {
  const MyInscriptionPage({super.key});

  @override
  State<MyInscriptionPage> createState() => _MyInscriptionPageState();
}

class _MyInscriptionPageState extends State<MyInscriptionPage> {

  final _formInscriptionKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Promo? promotion;

  InputDecoration setInputDecoration(Icon icon, String labelText) {
    return InputDecoration(
      labelText: labelText,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      ),
      border: const UnderlineInputBorder(),
      iconColor: Theme.of(context).primaryColor,
      icon: icon,
      errorStyle: TextStyle(color: Colors.red),
    );
  }

  void submitForm() {
    if (_formInscriptionKey.currentState != null &&
        _formInscriptionKey.currentState!.validate()) {

      User newUser = User(
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          promo: promotion!
      );

      _formInscriptionKey.currentState!.reset();

      ScaffoldMessenger.of(context)
          .showSnackBar(
          const SnackBar(content: Text("Formulaire Soumis !"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Basescaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: Column (
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: const Text(
                    "Créer un compte",
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
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: setInputDecoration(const Icon(Icons.email), "Email"),
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
                            controller: _usernameController,
                            decoration: setInputDecoration(const Icon(Icons.account_circle_rounded), "Nom d'\'utilisateur"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir un nom d\'utilisateur";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: setInputDecoration(const Icon(Icons.password), "Mot de passe"),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir un mot de passe";
                              }
                              if (value.length < 6) {
                                return "Votre mot de passe doit comporter au moins 6 caractères";
                              }
                              if (value.isNotEmpty && value.toLowerCase() == value) {
                                return "Votre mot de passe doit comporter au moins 1 majuscule";
                              }
                            },
                          ),
                          DropdownButtonFormField(
                            decoration: setInputDecoration(const Icon(Icons.grade), "Promotion"),
                            value: promotion,
                            items: Promo.values.map((promo) {
                              return DropdownMenuItem<Promo>(
                                value: promo,
                                child: Text(promo.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                promotion = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Veuillez sélectionner une promo';
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
                                    "S\'inscrire",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18
                                    ),
                                  )))
                        ],
                      ))),
            ],
          ),
        )
    );


  }

}
