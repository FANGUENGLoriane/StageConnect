import 'package:flutter/material.dart';
import 'package:premierepage/gererComptes.dart';

class AdminConnect extends StatefulWidget {
  const AdminConnect({super.key});

  @override
  State<AdminConnect> createState() => _AdminConnectState();
}

class _AdminConnectState extends State<AdminConnect> {
  final Formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //donnons un nom et mot de passe prédéfini

  final String predefinedName = "ADMIN1-ISARE";
  final String predefinedPassword = "ADMIN1-";
  // la fonction permettant de valider les champs et de naviguer vers la deuxieme page
  void _validateAndNavigate() {
    //gestion de la validation
    if (Formkey.currentState!.validate()) {
      //verifie si les entrées du user correspondent aux donnees prédéfinies
      if (nameController.text == predefinedName &&
          passwordController.text == predefinedPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GererComptes(), // transmission des données
          ),
        );
      } else {
        //la scafffoldmessage.... permet de montrer les messages d'erreur ou de confirmation ou encore d'afficher les messages temporaires
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("nom ou mot de passe incorrect"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(

                child: ListView(
      children: [
        Image.asset('image/main.JPG'),
        const SizedBox(height: 40, width: 5),
        Image.asset('image/1.PNG'),
        Padding(
            padding: const EdgeInsets.symmetric(
                vertical:
                    60), // pour espacer le texte "login" du input verticalement
            child: Form(
                //formulaire  qui commence par le mot clé form , le child s'ajoute lorsqu'on met le padding
                //associe le formulaire a la clé
                key: Formkey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      // creation du input
                      controller: nameController,
                      keyboardType: TextInputType.name, // identifiant
                      decoration: const InputDecoration(
                        // ce que contiendra le input
                        labelText: 'NOM', // label du input
                        hintText: 'entrez votre nom', // un symonyme de placehoder
                        prefixIcon: Icon(Icons.person), // icon du user
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "veuillez entrer votre nom";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      // creation du input
                      controller: passwordController, //recuperation du password
                      keyboardType:
                          TextInputType.visiblePassword, // identifiant
                      decoration: const InputDecoration(
                        // ce que contiendra le input
                        labelText: 'PASSWORD', // label du input
                        hintText: 'Votre mot de passe', // un symonyme de placehoder
                        prefixIcon: Icon(Icons.password), // icon password
                        border: OutlineInputBorder(),
                      ),

                      onChanged: (String value) {}, obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "veuillez entrer votre mot de passe";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ), // taille du bouton
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepOrangeAccent)),
                    onPressed: _validateAndNavigate,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ])))
      ],
    )));
  }
}
