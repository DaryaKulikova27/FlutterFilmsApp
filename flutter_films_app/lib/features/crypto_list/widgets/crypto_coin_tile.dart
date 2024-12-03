import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    Key? key,
    required this.coin
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(coin.imageUrl),
      title: Text(
        coin.name, 
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${coin.priceInUSD}\$', 
        style: theme.textTheme.labelSmall
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => {
        context.go('/coins', extra: coin.name)
      }
    );
  }
}