import 'package:premierepage/src/constant/images.dart';
import 'package:premierepage/src/constant/string.dart';
import 'package:premierepage/src/features/home/model/CardModel.dart';

class CardController{

  final List<CardModel> card = [
      const CardModel(image: cisco, description:ciscoDesc, url: url),
    const CardModel(image: microsoft, description:microsoftDesc, url: url),
    const CardModel(image: eccouncil, description:EcCouncilDecs, url: url),
    const CardModel(image: comptia, description:ComptiaDesc, url: url),
  ];

  final List<CardModel> card1 = [
    const CardModel(image: cisco1, description:CiscoDescF, url: url),
    const CardModel(image: microsoft1, description:microsoftDescF, url: url),
    const CardModel(image: formation, description: ProjetDescF, url: url),
    const CardModel(image: person, description:IT_gouvernanceDescF, url: url),

  ];
}
