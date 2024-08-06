import 'package:coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({
    super.key,
    required this.coinName,
  });

  final String coinName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).somethingWentWrong,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            S.of(context).pleaseTryLater,
            style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CryptoCoinBloc>(context).add(LoadCryptoCoin(coinName: coinName));
            },
            child: Text(
              S.of(context).tryAgainButton,
              style: theme.textTheme.labelSmall?.copyWith(color: Colors.amberAccent, fontWeight: FontWeight.w500)
            )
          )
        ]
      )
    );
  }
}