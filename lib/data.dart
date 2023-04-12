import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currencies = [
  'AED',
  'AUD',
  'ARS',
  'BRL',
  'CAD',
  'COP',
  'CNY',
  'CZK',
  'DKK',
  'EUR',
  'GBP',
  'HKD',
  'HUF',
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
  'THB',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'LTC', 'ETH'];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '4B8B2ECF-EDF2-4AA7-A07E-38D4ACED57AE';

class CoinData {
  Future getCoinData(String currCurrency) async {
    Map<String, String> cryptoPrices = <String, String>{};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$currCurrency?apikey=$apiKey';
      //final Uri url = Uri.parse(requestURL);
      //final responses = await http.post(url);

      //http.Response response = await http.get(url);
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(5);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
