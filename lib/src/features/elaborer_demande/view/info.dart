import 'package:flutter/material.dart';
import 'package:premierepage/src/features/elaborer_demande/view/elementdossier.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Center(
          child:  Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: Info.length,
                    itemBuilder: (context, text) {
                      return Card(
                          //   child: Text('673-92-05-70 / 659-26-77-78'),
                        color: Colors.white60,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 8),
                          child: Column(children: [

                          Text(
                          Info[text].icon.toString(),),

                            Text(
                              Info[text].infos.toString(),
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  ),
                            ),


                          ]));
                    }))
          ],
        )));
  }
}

List<INFO> Info = [
  INFO('ISARE','Page Facebook'),
  INFO('Contact@isare.us','Adresse mail'),
  INFO('Site internet','www.isare.us'),
  INFO('Francais  ,  Anglais','Langues'),
  INFO('673-92-05-70 / 659-26-77-78','Contact'),
  INFO('Awae escalier face Nikel-Oil','Localisation'),
];
