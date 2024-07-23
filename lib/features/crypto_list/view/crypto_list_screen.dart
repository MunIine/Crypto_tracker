import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список криптовалют"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(talker: GetIt.I<Talker>())
                )
              );
            },
            icon: const Icon(Icons.document_scanner_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
            BlocBuilder<CryptoListBloc, CryptoListState>(
              bloc: _cryptoListBloc,
              builder: (context, state) {
                if (state is CryptoListLoaded){
                  return ListView.builder(
                    itemCount: state.coinsList.length,
                    itemBuilder: (context, i) {
                      final coin = state.coinsList[i];
                      return CryptoCoinTile(coin: coin);
                    },
                  );
                }
                if (state is CryptoListLoadingFailure){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Something went wrong",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          "Please try later", 
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: (){
                            _cryptoListBloc.add(LoadCryptoList());
                          }, 
                          child: Text(
                            "TRY AGAIN", 
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w500)
                            )
                        )
                      ]
                    )
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          
        ),
      )
    );
  }
}
