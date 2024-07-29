import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins_list/router/router.dart';
import 'package:flutter/material.dart';
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

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
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
                _cryptoListBloc.add(LoadCryptoList(completer: completer));
                return completer.future;
              },
              backgroundColor: theme.scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                  BlocBuilder<CryptoListBloc, CryptoListState>(
                    bloc: _cryptoListBloc,
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
      return ListView.builder(
        itemCount: state.coinsList.length,
        itemBuilder: (context, i) {
          final coin = state.coinsList[i];
          return CryptoCoinTile(
            coin: coin, 
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => AutoRouter.of(context).push(CryptoCoinRoute(coinName: coin.name)),
          );
        },
      );
    }
    if (state is CryptoListLoadingFailure) {
      return FailureScreen(cryptoListBloc: _cryptoListBloc);
    }
    return const Center(child: CircularProgressIndicator());
  }
}