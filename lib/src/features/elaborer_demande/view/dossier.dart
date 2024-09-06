import 'package:flutter/material.dart';
import 'package:premierepage/main.dart';
import 'package:premierepage/src/constant/images.dart';
import 'package:premierepage/src/features/elaborer_demande/view/elementdossier.dart';


class dossier extends StatefulWidget {
  const dossier({super.key});

  @override
  State<dossier> createState() => _dossierState();
}

class _dossierState extends State<dossier> {
  late Color myColor;
  late Size mediaSize;
  @override
  Widget build(BuildContext context) {
    myColor = Theme
        .of(context)
        .primaryColor;
    mediaSize = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: const AssetImage(ordi3),
                //COULEUR au dessus de l'image
                colorFilter: ColorFilter.mode(
                    myColor.withOpacity(0.4), BlendMode.dstATop))),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body:

            Stack(
              //  Image.asset('image/noir3.JPG'),
                children: [
                //  Image.asset('image/noir3.JPG'),
                  Positioned(top: 70, child: _buildTop()),
                  Positioned(bottom: 0, child: _buildBottom()),
                ]
            )
        )
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      
        width: mediaSize.width,
        child: const Card(
          color: Colors.black45,
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 34,
              ),
              Text(
                'Demande de stage',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
              Text(
                'Demande de stage',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70),
              ),
              Divider(height: 17),
              SizedBox(
                height: 22,
              ),
              Text(
                'Photocopie du certificat de scolarité',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),

              Text(
                'Photocopie du certificat de scolarité',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70),
              ),
              Divider(height: 17),
              SizedBox(
                height: 22,
              ),

              Text(
                'Photocopie de la CNI',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),

              Text(
                'Photocopie de la CNI',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70),
              ),
              Divider(height: 17),

              SizedBox(
                height: 22,
              ),


              Text(
                'Curiculum vitae',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),

              Text(
                'Curiculum vitae',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70),
              ),
              Divider(height: 17),

              SizedBox(
                height: 22,
              ),

              Text(
                'Quatre (4) Cartes photos',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),

              Text(
                'Quatre (4) Cartes photos',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70),
              ),
              Divider(height: 17),

              SizedBox(
                height: 22,
              ),

              Text(
                'Frais de stage : 25.000 FCFA',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),

              Text(
                'Frais de stage : 25.000 FCFA',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70),
              ),Divider(height: 17),
                      ])
                  ));

  }


Widget _buildTop() {
  return  SizedBox(
    width: mediaSize.width,

    child: const Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(
        Icons.info,
        color: Colors.white,
        size: 70,

      ),
      Text(
        'Contenu du dossier',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.white70),
      )
    ]),
  );
}
}

List <element> Element=[
  element('Demande de stage'),
  element('Photocopie du certificat de scolarité'),
  element('Photocopie de la CNI'),
  element('CUriculum vitae(CV)'),
  element('4 Cartes photos'),
  element('Frais de stage: 25000 FCFA'),
];
