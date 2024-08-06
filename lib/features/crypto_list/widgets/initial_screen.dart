import 'package:coins_list/features/search_bottom_sheet/view/search_bottom_sheet.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "lib/assets/empty_box.png",
          scale: 6
        ),
        const SizedBox(height: 10),
        Text(
          "В вашем списке криптовалют",
          style: theme.textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.9))),
        Text(
          "пока ничего нет",
          style: theme.textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.9))),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            shape: BoxShape.circle
          ),
          child: IconButton(
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, 
                backgroundColor: theme.scaffoldBackgroundColor,
                builder: (context) => SearchBottomSheet(hintText: S.of(context).searchBottomSheetText)
              );
            }, 
            iconSize: 40,
            icon: Icon(Icons.add_sharp, color: theme.primaryColor)
          ),
        )
      ],
    );
  }
}