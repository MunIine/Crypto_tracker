import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

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
                  onPressed: () {
                    // _cryptoListBloc.add(LoadCryptoList());
                  },
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
}