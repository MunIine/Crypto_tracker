import 'package:coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key,});

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CryptoListBloc>(context).add(LoadCryptoList());
            },
            child: Text(
              S.of(context).tryAgainButton,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.w500
              )
            )  
          )
        ]
      )
    );
  }
}