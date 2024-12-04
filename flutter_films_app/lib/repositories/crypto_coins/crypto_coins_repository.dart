import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {

  final Dio dio;
  CryptoCoinsRepository({
    required this.dio
  });

  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AID,SOL,CAG,DOV&tsyms=USD,EUR');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = e.value['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'] as double;
      final imageURL = usdData['IMAGEURL'] as String;
      
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/$imageURL',
      );
    }).toList();

    return cryptoCoinsList;
  }
}