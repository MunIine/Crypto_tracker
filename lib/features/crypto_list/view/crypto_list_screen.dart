import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:coins_list/features/search_bottom_sheet/view/search_bottom_sheet.dart';
import 'package:coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  void initState() {
    BlocProvider.of<CryptoListBloc>(context).add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).homeScreenTitle),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TalkerScreen(talker: GetIt.I<Talker>())
              )
            );
          },
          icon: const Icon(Icons.document_scanner_outlined)
        ),
        actions: [
          IconButton(
            iconSize: 26,
            onPressed: (){},
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Column(
        children: [
          CryptoSearchBar(
            text: S.of(context).cryptoCoinsSearchBar,
            onTap: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, 
                backgroundColor: theme.scaffoldBackgroundColor,
                builder: (context) => SearchBottomSheet(hintText: S.of(context).searchBottomSheetText)
              );
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final completer = Completer();
                BlocProvider.of<CryptoListBloc>(context).add(LoadCryptoList(completer: completer));
                return completer.future;
              },
              backgroundColor: theme.scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                  BlocBuilder<CryptoListBloc, CryptoListState>(
                    builder: _buildCoinsList,
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCoinsList(context, state) {
    if (state is CryptoListLoaded) {
      return ReorderableListView.builder(
        itemCount: state.coinsList.length,
        itemBuilder: (context, i) {
          final coin = state.coinsList[i];
          return Dismissible(
            key: Key(coin.name),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12)
              ),
              child: const Icon(Icons.cancel_outlined),
            ),
            onDismissed: (direction) {
              BlocProvider.of<CryptoListBloc>(context).add(AddOrRemoveCoinFromList(coin: state.coinsList[i]));
              setState(() {
                state.coinsList.removeAt(i);
              });
              if (state.coinsList.isEmpty) BlocProvider.of<CryptoListBloc>(context).add(LoadCryptoList());
            },
            direction: DismissDirection.endToStart,
            child: CryptoCoinTile(
              key: Key("$i"),
              coin: coin, 
              trailing: GestureDetector(
                onTap: () => AutoRouter.of(context).push(CryptoCoinRoute(coinName: coin.name)),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
              ),
              onTap: () => AutoRouter.of(context).push(CryptoCoinRoute(coinName: coin.name)),
            ),
          );
        },
        proxyDecorator: (child, index, animation) {
          return Opacity(
            opacity: 0.75,
            child: child,
          );
        },
        onReorderStart: (index) => HapticFeedback.mediumImpact(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex){
              newIndex -= 1;
            }
            final item = state.coinsList.removeAt(oldIndex);
            state.coinsList.insert(newIndex, item);
          });
          BlocProvider.of<CryptoListBloc>(context).add(ReorderFavorites(oldIndex: oldIndex, newIndex: newIndex));
        },
      );
    }

    if (state is CryptoListLoadingFailure) return _centerWithAppbar(const FailureScreen());
    if (state is CryptoListInitial) return _centerWithAppbar(const InitialScreen());

    return _centerWithAppbar(const Center(child: CircularProgressIndicator()));
  }

  Padding _centerWithAppbar(child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: child
    );
  }
}