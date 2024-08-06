import 'package:coins_list/extensions/exception_extensions.dart';
import 'package:coins_list/features/search_bottom_sheet/bloc/crypto_coins_all_bloc.dart';
import 'package:coins_list/features/crypto_list/widgets/crypto_coin_tile.dart';
import 'package:coins_list/features/search_bottom_sheet/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({
    super.key, 
    required this.hintText
  });

  final String hintText;

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CryptoCoinsAllBloc>(context).add(LoadCryptoCoinsAll());
    super.initState();
  }

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
                    controller: controller,
                    style: const TextStyle(
                      decoration: TextDecoration.none
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: widget.hintText,
                    ),
                  ))
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _searchCoin(),
                  child: Container(
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
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 65),
            child: BlocBuilder<CryptoCoinsAllBloc, CryptoCoinsAllState>(
              builder: _buildCoinsList
            ),
          )
        ),
      ],
    );
  }

  void _searchCoin() {
    final query = controller.text;
    if (query.trim().isNotEmpty) {
      BlocProvider.of<CryptoCoinsAllBloc>(context).add(SearchCryptoCoin(coinName: query));
    }
  }

  Widget _buildCoinsList(context, state) {
    if (state is SearchCryptoCoinLoaded) {
      return ListView.builder(
        itemCount: state.coinsList.length,
        itemBuilder: (context, i) {
          final coin = state.coinsList[i];
          return CryptoCoinTile(
            coin: coin, 
            trailing: const Icon(
              Icons.star_border_rounded,
              size: 35,
            ),
          );
        },
      );
    }
    if (state is SearchCryptoCoinLoading){
      return const Center(child: CircularProgressIndicator());
    }
    if (state is SearchCryptoCoinLoadingFailure){
      if (state.exception is CoinNotFoundException) return const CoinNotFoundScreen();
      return FailureScreen(controller: controller);
    }
    return const InitialSearchScreen();
  }
}