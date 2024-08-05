import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';

class InitialSearchScreen extends StatelessWidget {
  const InitialSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).searchBottomSheetInitialText,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.primaryColor),
          ),
          Text(
            S.of(context).enterNameOrSymbol,
            style: theme.textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
          ),
          Text(
            S.of(context).inSearchLine,
            style: theme.textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
          )
        ],
      )
    );
  }
}