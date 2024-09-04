import 'package:cours_flutter/base/base_scaffold.dart';
import 'package:cours_flutter/models/promo.dart';
import 'package:cours_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInscriptionPage extends StatefulWidget {
  const MyInscriptionPage({super.key});

  @override
  State<MyInscriptionPage> createState() => _MyInscriptionPageState();
}

class _MyInscriptionPageState extends State<MyInscriptionPage> {

  @override
  Widget build(BuildContext context) {

    final _formInscriptionKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    Promo? promotion;

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

    return Basescaffold(
        title: "Inscription",
        body: Form(
          key: _formInscriptionKey,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration( labelText: "Email"),
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
                      decoration: InputDecoration(labelText: "Nom d\'utilisateur"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez saisir un nom d\'utilisateur";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Mot de passe"),
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
                        decoration: const InputDecoration(labelText: "Promotion"),
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
                    ElevatedButton(
                        onPressed: submitForm,
                        child: const Text("S\'inscrire"))
                  ],
                )))
    );


  }

}
