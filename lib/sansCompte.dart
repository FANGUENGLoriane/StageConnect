import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierepage/filepage.dart';
import 'package:premierepage/src/constant/images.dart';

class sansCompte extends StatefulWidget {
  const sansCompte({super.key});

  @override
  State<sansCompte> createState() => _sansCompteState();
}

class _sansCompteState extends State<sansCompte> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  // créons les onglets
                  //fonction
                  bottom: TabBar(tabs: <Widget>[
                    Tab(
                      child: Text('ISARE',style: TextStyle(color: Colors.white,fontSize: 17),
                    ),),
                    Tab(
                      child: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                    ),
                    Tab(
                      child: Icon(Icons.account_balance, color: Colors.white),
                    ),
                  ]),
                  centerTitle: true,
                  backgroundColor: Colors.deepOrangeAccent,
                  title: Text(
                    'ISARE',
                    style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),
                  ),
                ),
                body: TabBarView(children: [
                  Card(
                      child:
                  const Image(image: AssetImage(logoIsare)),),
                      Card(
                        child: Image.asset('image/affiche.JPG', width: 50),
                      ),
                      Card(
                        child: Image.asset('image/ordi3.JPG',height: 30,),
                      )
                    ],
                  ))
                ));
  }
}
