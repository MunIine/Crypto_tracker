import 'package:coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin, 
    this.trailing, 
    this.onTap,
  });

  final CryptoCoin coin;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      child: ListTile(
        leading: Image.network(
          coin.details.fullImageURL,
          width: 50,
          height: 50,
          errorBuilder: (context, e, st) => Image.asset("lib/assets/default_coin.png"),
        ),
        title: Text(
          coin.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          "${coin.details.priceInUSD}\$",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}