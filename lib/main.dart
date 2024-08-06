import 'dart:async';

import 'package:coins_list/crypto_coins_list_app.dart';
import 'package:coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:coins_list/repositories/favorites/favorites.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';


void main() async{
  final dio = Dio();
  final talker = TalkerFlutter.init();

  GetIt.I.registerSingleton(talker);

  talker.info("Start talker...");

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false
      )
    )
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false
    )
  );

  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
    () async{
      // Вынужденный перенос инициализации из-за zone mismatch exception
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp, 
        DeviceOrientation.portraitDown
      ]);
      
      await Hive.initFlutter(); 
      Hive.registerAdapter(CryptoCoinAdapter());
      Hive.registerAdapter(CryptoCoinDetailsAdapter());
      Hive.registerAdapter(CryptoCoinsAllAdapter());
      Hive.registerAdapter(FavoriteAdapter());
      final cryptoCoinsBox = await Hive.openBox<CryptoCoin>("crypto_coin_box");
      final cryptoCoinsAllBox = await Hive.openBox<CryptoCoinsAll>("crypto_coins_all_box");
      final favoritesBox = await Hive.openBox<Favorite>("favorites_box");
      final cryptoCoinsRepository = CryptoCoinsRepository(
        dio: dio, 
        cryptoCoinsBox: cryptoCoinsBox,
        cryptoCoinsAllBox: cryptoCoinsAllBox
      );
      // GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => cryptoCoinsRepository);
      
      runApp(MyApp(
        cryptoCoinsRepository: cryptoCoinsRepository, 
        favoritesRepository: FavoritesRepository(favoritesBox: favoritesBox)
      ));
    },
    (e, st) => GetIt.I<Talker>().handle(e, st)
  );
}