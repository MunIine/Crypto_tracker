import 'package:coins_list/features/search_bottom_sheet/bloc/crypto_coins_all_bloc.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureScreen extends StatefulWidget {
  const FailureScreen({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<FailureScreen> createState() => _FailureScreenState();
}

class _FailureScreenState extends State<FailureScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).somethingWentWrong,
                  style: textTheme.headlineMedium,
                ),
                Text(
                  S.of(context).pleaseTryLater,
                  style: textTheme.labelSmall?.copyWith(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => _searchCoin(),
                  child: Text(
                    S.of(context).tryAgainButton,
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.w500
                    )
                  )  
                )
              ]
          ),
    );
  }

  void _searchCoin() {
    final query = widget.controller.text;
    if (query.trim().isNotEmpty) {
      BlocProvider.of<CryptoCoinsAllBloc>(context).add(SearchCryptoCoin(coinName: query));
    }
  }
}