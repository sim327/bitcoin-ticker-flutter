import 'package:http/http.dart' as http;

class GetValue {
  String APIkey = 'BB861E63-2A4D-4D09-8BF6-910D6E186915';

  Future<dynamic> getExchangerate(String currency, String crypto) async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$APIkey';
    var data = await http.get(Uri.parse(url));
    // print(data.body);
    return data.body;
  }
}
