import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin/currency_api/currency_api.dart';

class CryptoCurrenciesScreen extends StatefulWidget {
  @override
  _CryptoCurrenciesScreenState createState() => _CryptoCurrenciesScreenState();
}

class _CryptoCurrenciesScreenState extends State<CryptoCurrenciesScreen> {
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};
  bool isWaiting = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
     var data =
         await CryptoCurrencyData().getCryptoCurrencyData(selectedCurrency);
      setState(() {
        isWaiting = false;
       coinValues = data;
      });
    } catch (e) {
      throw ('Status Error: Crypto data waiting');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('🤑 Crypto Currencies'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoCurrencyCards(),
          ),
          Container(
            color: Colors.blueGrey,
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'CURRENCY:',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 150,
                  width: 60,
                  child: currencyPicker(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<CryptoCard> cryptoCurrencyCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoCurrencies) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: '$crypto',
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto],
        ),
      );
    }
    return cryptoCards;
  }

  CupertinoPicker currencyPicker() {
    List<Text> pickerItems = [];
    for (String currency in globalCurrencies) {
      pickerItems.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.blueGrey,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = globalCurrencies[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({this.value, this.selectedCurrency, this.cryptoCurrency});

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.blueGrey,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
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