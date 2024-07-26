import 'package:flutter/material.dart';

class SearchBottomSheet extends StatelessWidget {
  const SearchBottomSheet({
    super.key, 
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15).copyWith(top: 35),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextField(
                    style: const TextStyle(
                      decoration: TextDecoration.none
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: hintText,
                    ),
                  ))
                ),
                const SizedBox(width: 8),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.search,
                    color: theme.scaffoldBackgroundColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}