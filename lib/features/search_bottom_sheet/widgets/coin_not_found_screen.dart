import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';

class CoinNotFoundScreen extends StatelessWidget {
  const CoinNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Image.asset(
            "lib/assets/coin_not_found.png",
            scale: 6
          ),
        ),
        Text(
          S.of(context).sadNoResult,
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.primaryColor),
        ),
        Text(
          S.of(context).cannotFindTheCryptoCoin,
          style: theme.textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
        ),
        Text(
          S.of(context).maybeALittleMistake,
          style: theme.textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
        )
      ],
    );
  }
}