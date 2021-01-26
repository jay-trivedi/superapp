import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/cards_provider.dart';
import 'package:super_app/widgets/budget_card.dart';
import 'package:super_app/widgets/credit_card.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewCards();
  }
}

class ViewCards extends StatefulWidget {
  @override
  _ViewCardsState createState() => _ViewCardsState();
}

class _ViewCardsState extends State<ViewCards> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    print('Buid Method is called ***********************');
    final cardsProvider = Provider.of<CardsProvider>(context);
    final cards = cardsProvider.cards;

    void selectCard(int index) {
      setState(() {
        indexSelected = index;
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height / 5.2,
      color: Color(0xFF1E2027),
      //color: Colors.white,
      child: ListView.builder(
        itemCount: cards.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            if (indexSelected == 0)
              return Budget(true, selectCard);
            else
              return Budget(false, selectCard);
          } else {
            if (indexSelected == index)
              return CreditCard(
                cardDetails: cards[index - 1],
                cardIndex: index,
                selectCard: selectCard,
                isClicked: true,
              );
            else
              return CreditCard(
                cardDetails: cards[index - 1],
                cardIndex: index,
                selectCard: selectCard,
                isClicked: false,
              );
          }
        },
        scrollDirection: Axis.horizontal,
      ),
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 30.0),
    );
  }
}
