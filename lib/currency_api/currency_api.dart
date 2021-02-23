import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> globalCurrencies = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoCurrencies = [
  'BTC',
  'ETH',
  'LTC',
  'ADA',
  'XRP',
  'DOT',
  'BNB',
];

const currencyAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '1965088A-90D2-49BB-B92C-4BCD5BD75D31';

class CryptoCurrencyData {
  Future getCryptoCurrencyData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoCurrencies) {
      String requestURL =
          '$currencyAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        throw 'Status Error: Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}