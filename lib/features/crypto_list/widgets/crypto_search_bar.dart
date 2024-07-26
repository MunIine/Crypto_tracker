import 'package:flutter/material.dart';

class CryptoSearchBar extends StatelessWidget {
  const CryptoSearchBar({
    super.key, 
    required this.text, 
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child:
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)
                )
              ],
            ),
          ),
      ),
    );
  }
}