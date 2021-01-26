import 'package:flutter/foundation.dart';
import 'package:super_app/models/card_details.dart';
import 'package:super_app/db_models/card_db.dart';
import 'package:super_app/providers/sms_provider.dart';

class CardsProvider extends ChangeNotifier {
  Map<String, CardDetails> _cards = {};
  CARDDB carddb = new CARDDB();

  List<CardDetails> get cards {
    List<CardDetails> cardList = [];
    _cards.forEach((key, value) {
      cardList.add(value);
    });
    return cardList;
  }

  Future<void> fetchCards(SMSProvider provider) async {
    final dbCards = await carddb.getAllCardsDB();
    dbCards.forEach((element) {
      element.amountSpent = provider.getTotal(element.bankName, element.cardNo);
      _cards[element.cardUid] = element;
    });
    notifyListeners();
  }

  Future<CardDetails> addCard(String cardNo, String bankName) async {
    print("Adding new Card");
    CardDetails card = CardDetails(
      cardNo: cardNo,
      cardUid: "${cardNo}_$bankName",
      bankName: bankName,
      amountSpent: 0,
    );
    int id = await carddb.insertCard(card);
    // notifyListeners();
    card.cardSNo = id;
    return card;
  }
}
