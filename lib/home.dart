import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierepage/src/constant/images.dart';
import 'package:premierepage/src/constant/size.dart';
import 'package:premierepage/src/constant/variables.dart';
import 'package:premierepage/src/constant/variables.dart';
import 'package:premierepage/src/constant/variables.dart';
import 'package:premierepage/src/features/authentification/view/connexion.dart';
import 'package:premierepage/src/features/authentification/view/home_login.dart';
import 'package:premierepage/src/features/signup/views/suivant.dart';
import 'package:url_launcher/url_launcher.dart';
import'package:font_awesome_flutter/font_awesome_flutter.dart';

Color _mainColor = Colors.deepOrangeAccent;
Color _blackColor = Colors.black;
Color _whiteColor = Colors.white;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
    // initialiser l'animation du controller avec une durée de trois s
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    //cfeons une animation
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.bounceInOut);
    //démarrer l'animation
    _controller?.forward();
    //naviguer vers la page suivante apres la fin de l'animation
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage1()));
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
            opacity: _animation!,
            child: Column(
              children: [
                Text(
                  'StageConnect',
                  style: GoogleFonts.protestGuerrilla(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                )
              ],
            ))
      ],
    )));
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  String searchQuery = '';
  static const _fwb = FontWeight.w400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.deepOrangeAccent.withOpacity(0.6),
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Text(
                  'StageConnect',
                  style: GoogleFonts.protestGuerrilla(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 73),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => connect()));
                      },
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Column(children: [
                            Icon(
                              Icons.person,
                              size: 25,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text(
                              'Connexion',
                              style: GoogleFonts.roboto(
                                  fontSize: 6, color: _mainColor),
                            ),
                          ]))),
                ),
              ]),
            )),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: const InputDecoration(
                hintText: 'rechercher',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.black12
                // enabledBorder: OutlineInputBorder(borderSide: BorderSide.none)
                ),
          ),
        ),
        /* Expanded(child: Column(
                  children:
                    _getSearchResults(searchQuery),
                )),*/
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ISARE',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: fzBtn,
                  color: _mainColor),
            ),
          ),
        ),
        // const SizedBox(height:),
        Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Un centre de formation ayant pour mission d\'aider ses étudiants à acquérir des compétences IT re-\ncherchées et reconnues sur le plan international afin de décrocher un bon emploi qui leur mérite.',
                style: GoogleFonts.roboto(color: _blackColor, fontSize: fzE),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: [
              Center(
                  child: Text(
                'Nos certifications',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  height: 268,
                  width: 250,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Image.asset(cisco),
                            SizedBox(height: 9,),
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(children: [
                                  Text(' Les programmes de certification'),
                                  Text(' le standard de validation des..'),
                                  TextButton(
                                      onPressed: _launchURL,
                                      child: Text('visiter le site'))
                                  //Text(' tences reseaux dans tous les pays...')
                                ]))
                          ],
                        )),
                  ),
                ),
                SizedBox(
                    width: 250,
                    height: 268,
                    child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            children: [
                              Image.asset(
                                eccouncil,
                                width: 250,
                                height: 150,
                              ),
                               SizedBox(height: 8),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('C\'est le plus grand organisme de'),
                                    Text('certification technique de cyber..'),
                                 //   Text('securite du monde Ses titres.......'),
                                    TextButton(
                                        onPressed: _launchURL,
                                        child: Text('visiter le site'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))),
                SizedBox(
                    width: 250,
                    height: 268,
                    child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            children: [
                              Image.asset(comptia),
                              SizedBox(height: 10,),
                              Text('Vous etes professionnel de l\'infor-'),
                              Text('matique et souhaitez progresser'),
                             // Text(' dans votre carriere,appprenez...')
                              TextButton(
                                  onPressed: _launchURL,
                                  child: Text('visiter le site'))
                            ],
                          ),
                        ))),
                SizedBox(
                    width: 250,
                    height: 268,
                    child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            children: [
                              Image.asset(
                                microsoft,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(' Elles sont reputees car elles'),
                              Text('demontrent  votre expertise dans le'),
                              //Text('domaine informatique....'),
                              TextButton(
                                  onPressed: _launchURL,
                                  child: Text('visiter le site'))
                            ],
                          ),
                        ))),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: [
              Center(
                  child: Text(
                'Nos Formations',
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                    height: 268,
                    width: 250,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Image.asset(person),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(
                                    ' EN GOUVERNANCE IT ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Des organisations internationales '),
                                  Text('proposent des méthodes qui ..'),
                                  TextButton(
                                      onPressed: _launchURL,
                                      child: Text('visiter le site'))
                                  //  Text(' ditent les compétences..')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                    height: 268,
                    width: 250,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Image.asset(cisco1),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                children: [
                                  Text(
                                    ' CISCO',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(' En tant que partenaire agrée  '),
                                  Text(' Cisco Learning Solutions, ISARE..'),
                                  TextButton(
                                      onPressed: _launchURL,
                                      child: Text('visiter le site'))
                                ],
                              ),
                            ),
                            // Text('vous aider a developper vos compét')
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                    height: 268,
                    width: 250,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Image.asset(formation),
                            SizedBox(
                              height: 2
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                ' EN GESTION DE PROJET ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('ISARE accompagne les directions  '),
                            Text(' informatiques de toutes les entre..'),
                            TextButton(
                                onPressed: _launchURL,
                                child: Text('visiter le site'))
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                    height: 268,
                    width: 250,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Image.asset(microsoft1),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'MICROSOFT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' Qu\'il s\'agisse d\'Azure, MS365 ',
                              style: TextStyle(),
                            ),
                            Text('et Teams, Windows Server, etc...'),
                            TextButton(
                                onPressed: _launchURL,
                                child: Text('visiter le site'))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),


        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          'Effectuez un choix:',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                  width: 180,
                  height: 120,
                  child: Card(
                    color: _blackColor,
                      child: Center(
                          child: Column(children: [
                            SizedBox(height: 4,),
                            Icon(FontAwesomeIcons.graduationCap,
                              size: 33,
                              color: Colors.deepOrangeAccent,),
                    SizedBox(height: 6),
                    Text('Stage ', style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold,color: _whiteColor),),
                    Text('Académique',style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold, color: _whiteColor),)
                  ])))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Suivant()));
                    },
                    style:OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)
                        ),
                       // padding: const EdgeInsets.symmetric(vertical: padVertical),
                        side: BorderSide(width: 1.5, color: Colors.deepOrangeAccent)),
                    child: Text(
                      'Postuler',
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: _mainColor),
                    )),
              )
            ],
          ),
        ),
SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                  width: 180,
                  height: 120,
                  child: Card(
                      color: _blackColor,
                      child: Center(
                          child: Column(children: [
                            SizedBox(height: 4,),
                            Icon(FontAwesomeIcons.graduationCap,
                              size: 33,
                              color: Colors.deepOrangeAccent,),
                            SizedBox(height: 6),
                            Text('Stage ', style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold,color: _whiteColor),),
                            Text('Professionel',style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold, color: _whiteColor),)
                          ])))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Suivant()));
                    },
                    style:OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)
                        ),
                        // padding: const EdgeInsets.symmetric(vertical: padVertical),
                        side: BorderSide(width: 1.5, color: Colors.deepOrangeAccent)),
                    child: Text(
                      'Postuler',
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: _mainColor),
                    )),
              )
            ],
          ),
        ),
      ]),
    ));
  }

  void _launchURL() async {
    const url = 'chrome-native://newtab/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir l\'URL $url';
    }
  }

//la fonction getsearchresult permet de filtrer les elements de la liste en fonction de la recherche
/*List<Widget>
_getSearchResults(String query){
  final List<String> items = [];
  final List<String>
  filteredItems = items.where((item){
    return
        item.toLowerCase().contains(query.toLowerCase());
  }).toList();
  return
      filteredItems.map((item)=>
      ListTile(title: Text(item))).toList();
}*/
// et les affiches sous forme de liste dans un listview
}
