import 'package:coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:coins_list/features/crypto_coin/widgets/widgets.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  
  final _cryptoCoinBloc = CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>());
  late String coinName;

  @override
  void didChangeDependencies() {
    coinName = ModalRoute.of(context)!.settings.arguments as String;
    _cryptoCoinBloc.add(LoadCryptoCoin(coinName: coinName));
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: _cryptoCoinBloc,
        builder: (context, state) {
          if (state is CryptoCoinLoaded){
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
                    coinName,
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
                          CryptoDataRow(title: "Hight 24 hours", value: "${coinDetails.high24Hours.toString()}\$"),
                          CryptoDataRow(title: "Low 24 hours", value: "${coinDetails.low24Hours.toString()}\$")
                        ],
                      )
                    )
                  )
                ],
              ),
            );
          }
          if (state is CryptoCoinLoadingFailure){
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
                        _cryptoCoinBloc.add(LoadCryptoCoin(coinName: coinName));
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
      )
    );
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