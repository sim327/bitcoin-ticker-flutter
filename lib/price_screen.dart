import 'package:bitcoin_ticker/getValueFromAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var currency = 'INR';
  var crypto = 'BTC';
  GetValue obj = GetValue();
  double price;
  double currentPrice = 0.0;
  var coinValue = {};
  var currentPrices = {};
  bool isWaiting = true;
  void result() async {
    for (String i in cryptoList) {
      GetValue obj = GetValue();
      var data = await obj.getExchangerate(currency, i);
      double price = await json.decode(data)['rate'];
      coinValue[i] = price;
      print(coinValue);
    }
    setState(() {
      isWaiting = false;
      currentPrices = coinValue;
    });
  }

  Widget getDropDownMenu() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String i in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      dropdownItems.add(item);
    }

    return DropdownButton(
      items: dropdownItems,
      value: currency,
      onChanged: (value) {
        setState(() {
          currency = value;
          result();
        });
      },
    );
  }

  Widget getpicker() {
    List<Widget> picker = [];
    for (String i in currenciesList) {
      var item = Text(i);
      picker.add(item);
    }

    return CupertinoPicker(
      itemExtent: 42.0,
      onSelectedItemChanged: (value) {
        setState(() {
          currency = currenciesList[value];
        });
      },
      children: picker,
    );
  }

  Widget getcards() {
    List<card> allCards = [];
    for (String i in cryptoList) {
      allCards.add(card(
          currentPrice: isWaiting ? 0 : currentPrices[i],
          currency: currency,
          crypto: i));
    }
    return Column(children: allCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: Text(
          '🤑 Coin Ticker',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getcards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.green[800],
            child: Platform.isIOS ? getpicker() : getDropDownMenu(),
          ),
        ],
      ),
    );
  }
}

class card extends StatelessWidget {
  const card({
    Key key,
    @required this.currentPrice,
    @required this.currency,
    @required this.crypto,
  }) : super(key: key);

  final double currentPrice;
  final String currency;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.green[800],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $currentPrice $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
//for android users...
//  DropdownButton(
//               items: getDropdownItems(),
//               value: SelectedCurrency,
//               onChanged: (value) {
//                 setState(() {
//                   SelectedCurrency = value;
//                 });
//               },
//             ),