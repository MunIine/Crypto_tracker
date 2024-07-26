import 'package:auto_route/auto_route.dart';
import 'package:coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:coins_list/features/crypto_coin/widgets/widgets.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key, 
    required this.coinName
  });

  final String coinName;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  
  final _cryptoCoinBloc = CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>());
  @override
  void initState() {
    _cryptoCoinBloc.add(LoadCryptoCoin(coinName: widget.coinName));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: _cryptoCoinBloc,
        builder: _buildCoinScreen,
      )
    );
  }

  Widget _buildCoinScreen(context, state) {
    if (state is CryptoCoinLoaded) {
      final coin = state.coinDetails;
      final coinDetails = coin.details;
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              width: 160,
              child: Image.network(
                coinDetails.fullImageURL,
                errorBuilder: (context, e, st) => Image.asset("lib/assets/default_coin.png"),
              )
            ),
            Text(
              widget.coinName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            _CardData(
              child: Center(
                heightFactor: 1.6,
                child: Text(
                  "${coinDetails.priceInUSD.toString()}\$",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ),
            ),
            _CardData(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CryptoDataRow(
                      title: S.of(context).hight24Hours,
                      value: "${coinDetails.high24Hours.toString()}\$"
                    ),
                    CryptoDataRow(
                      title: S.of(context).low24Hours,
                      value: "${coinDetails.low24Hours.toString()}\$"
                    )
                  ],
                )
              )
            )
          ],
        ),
      );
    }
    if (state is CryptoCoinLoadingFailure) {
      return FailureScreen(cryptoCoinBloc: _cryptoCoinBloc, coinName: widget.coinName);
    }
    return const Center(child: CircularProgressIndicator());
  }
}

class _CardData extends StatelessWidget{
  const _CardData({
    required this.child
  });

  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(80, 20, 20, 20),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: child
    );
  }
}