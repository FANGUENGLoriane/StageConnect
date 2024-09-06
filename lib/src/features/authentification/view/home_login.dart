import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierepage/sansCompte.dart';
import 'package:premierepage/src/constant/images.dart';
import 'package:premierepage/src/constant/size.dart';
import 'package:premierepage/src/features/elaborer_demande/view/nav_bar.dart';

Color _mainColor = Colors.deepOrangeAccent;
const _secondColor = Colors.white;

class HomeLoginPage extends StatelessWidget {
  const HomeLoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(pad),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(image: AssetImage(logoIsare)),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius)),
                        padding: const EdgeInsets.symmetric(vertical: padVertical)),
                        child: Text(
                          "CONNEXION",
                          style: GoogleFonts.roboto(fontSize: fzBtn, color: _mainColor, fontWeight: FontWeight.w400),
                        ))),
                SizedBox(height: 19),
                SizedBox(
                    width:double.infinity,
                    child:

                OutlinedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>navBar()));
                },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: padVertical),
                  side: BorderSide(width: 1.5, color: Colors.white)),
                  child: Text("INSCRIPTION",
                  style: GoogleFonts.roboto(fontSize: fzBtn, color: _secondColor, fontWeight: FontWeight.w400),),
        ),),
                SizedBox(height: 19,),
                SizedBox(
                  width: double.infinity,
                child:
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>sansCompte()));
                    },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: padVertical),),
                    child: Text("CONTINUER SANS COMPTE",
                style: GoogleFonts.roboto(fontSize: fzBtn, color: _secondColor, fontWeight: FontWeight.w400),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
