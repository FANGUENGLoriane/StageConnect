import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierepage/src/features/elaborer_demande/view/Soumission%20IA.dart';
import 'package:premierepage/src/features/elaborer_demande/view/SoumissionBD.dart';
import 'package:premierepage/src/features/elaborer_demande/view/SoumissionCyberSecurite.dart';
import 'package:premierepage/src/features/elaborer_demande/view/SoumissionSR.dart';
import 'package:premierepage/src/features/elaborer_demande/view/SoummissionCommerce.dart';
import 'package:premierepage/src/features/elaborer_demande/view/dossier.dart';
import 'package:premierepage/src/features/elaborer_demande/view/info.dart';
import 'package:premierepage/src/features/elaborer_demande/view/soumission_dossier.dart';
import 'package:premierepage/src/features/home/views/home.dart';

const _mainColor = Colors.deepOrangeAccent;

class specialite extends StatefulWidget {
  const specialite({super.key});

  @override
  State<specialite> createState() => _specialiteState();
}
class _specialiteState extends State<specialite> {
  Widget movies(String name,String image, String movie){
    return Padding(padding: EdgeInsets.all(5.0),

    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        backgroundImage: AssetImage(image),
        radius: 30,
        //récupérons l'image : si on ne met pas d'image(length==0) , la premiere lettre du nom s'affichera dans le cercle)?name[0]
        child:
        Text(image.length==0 ?name[0].toUpperCase():'',
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
        ),
      ),
      title:  Text(name, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
      ),
     subtitle:  Text(movie, style: const TextStyle(color: Colors.deepOrangeAccent ,fontWeight: FontWeight.bold,fontSize: 25),
      ),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: _mainColor,
        title: Text('Choisissez votre spécialité', style: GoogleFonts.roboto(color: Colors.white),),

      ),

body:

     ListView(
        children: <Widget>[
          GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilePickerScreen()));
      },
      child:
          movies('Genie Logiciel', '', 'Software ingennery'),
          ),
           Divider(
            height: 10,
            color: Colors.black,
          ),

         GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoumissionSR()));
            },
            child:
            movies('Réseau et Sécurité', '', 'NetWork Security'),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoumissionCyber()));
            },
            child:
            movies('CyberSécurité', '', 'CyberSecuryty'),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoumissionBD()));
            },
            child:
            movies('Bases de données', '', 'Databases'),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SoumissionIA()));
            },
            child:
            movies('IA ', '', 'ArtificialIntelligence'),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Soumission_Com()));
            },
            child:
            movies('MarketingVente', '', 'Advertising-Sell'),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          )
        ],
      ),

      drawer: Drawer(
    child: ListView(padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.deepOrangeAccent),
          child: Text('Menu',style: TextStyle(fontSize: 25, color: Colors.white),),
        ),
        ListTile(
          leading: const Icon(Icons.document_scanner),
          title: const Text('constitution dossier'),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const dossier()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('info'),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> info()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('quiter'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => specialite()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Deconnexion'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ],
    ),

    ),
    );
  }
}

