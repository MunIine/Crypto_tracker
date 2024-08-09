import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:coins_list/features/search_bottom_sheet/bloc/crypto_coins_all_bloc.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:coins_list/features/search_bottom_sheet/view/search_bottom_sheet.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
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

  bool editMode = false;

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
            iconSize: 35,
            onPressed: (){
              setState(() {
                editMode = !editMode;
              });
            }, 
            icon: const Icon(Icons.edit_note)
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
          return CryptoCoinTile(
            key: Key("$i"),
            coin: coin, 
            trailing: _iconOnEditMode(context, state, i, coin),
            onTap: editMode ? 
              (){} : 
              () => AutoRouter.of(context).push(CryptoCoinRoute(coinName: coin.name)),
          );
        },
        proxyDecorator: (child, index, animation) {
              return Material(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 68, 68, 68),
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


  GestureDetector _iconOnEditMode(BuildContext context, CryptoListLoaded state, int i, CryptoCoin coin) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: editMode ? (){
        BlocProvider.of<CryptoCoinsAllBloc>(context).add(AddOrRemoveFavorite(coinName: state.coinsList[i].name));
        setState(() {
          state.coinsList.removeAt(i);
        });
      } : () => AutoRouter.of(context).push(CryptoCoinRoute(coinName: coin.name)),
      child: Icon(
        editMode ? Icons.star_rounded : Icons.arrow_forward,
        color: editMode ? theme.primaryColor : theme.iconTheme.color,
        size: 30,
      ),
    );
  }

  Padding _centerWithAppbar(child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: child
    );
  }
}