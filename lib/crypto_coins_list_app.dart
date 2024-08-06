import 'package:coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:coins_list/features/search_bottom_sheet/bloc/crypto_coins_all_bloc.dart';
import 'package:coins_list/generated/l10n.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:coins_list/router/router.dart';
import 'package:coins_list/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key, 
    required this.cryptoCoinsRepository, 
    required this.favoritesRepository
  });

  final AbstractCoinsRepository cryptoCoinsRepository;
  final AbstractFavoritesRepository favoritesRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
        return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CryptoListBloc(widget.cryptoCoinsRepository, widget.favoritesRepository),
          ),
          BlocProvider(
            create: (context) => CryptoCoinBloc(widget.cryptoCoinsRepository),
          ),
          BlocProvider(
            create: (context) => CryptoCoinsAllBloc(widget.cryptoCoinsRepository, widget.favoritesRepository),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,

          title: 'Crypto coins list',
          theme: darkTheme,
          routerConfig: _appRouter.config(
            navigatorObservers: () => [
              TalkerRouteObserver(GetIt.I<Talker>())
            ],
          ),
        )
    );
  }
}