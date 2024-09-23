// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Crypto tracker`
  String get homeScreenTitle {
    return Intl.message(
      'Crypto tracker',
      name: 'homeScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hight 24 hours`
  String get hight24Hours {
    return Intl.message(
      'Hight 24 hours',
      name: 'hight24Hours',
      desc: '',
      args: [],
    );
  }

  /// `Low 24 hours`
  String get low24Hours {
    return Intl.message(
      'Low 24 hours',
      name: 'low24Hours',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please try later`
  String get pleaseTryLater {
    return Intl.message(
      'Please try later',
      name: 'pleaseTryLater',
      desc: '',
      args: [],
    );
  }

  /// `TRY AGAIN`
  String get tryAgainButton {
    return Intl.message(
      'TRY AGAIN',
      name: 'tryAgainButton',
      desc: '',
      args: [],
    );
  }

  /// `Search coins...`
  String get cryptoCoinsSearchBar {
    return Intl.message(
      'Search coins...',
      name: 'cryptoCoinsSearchBar',
      desc: '',
      args: [],
    );
  }

  /// `Search coins...`
  String get searchBottomSheetText {
    return Intl.message(
      'Search coins...',
      name: 'searchBottomSheetText',
      desc: '',
      args: [],
    );
  }

  /// `Search crypto coins`
  String get searchBottomSheetInitialText {
    return Intl.message(
      'Search crypto coins',
      name: 'searchBottomSheetInitialText',
      desc: '',
      args: [],
    );
  }

  /// `Sad no result!`
  String get sadNoResult {
    return Intl.message(
      'Sad no result!',
      name: 'sadNoResult',
      desc: '',
      args: [],
    );
  }

  /// `We cannot find the crypto coin`
  String get cannotFindTheCryptoCoin {
    return Intl.message(
      'We cannot find the crypto coin',
      name: 'cannotFindTheCryptoCoin',
      desc: '',
      args: [],
    );
  }

  /// `maybe a little mistake?`
  String get maybeALittleMistake {
    return Intl.message(
      'maybe a little mistake?',
      name: 'maybeALittleMistake',
      desc: '',
      args: [],
    );
  }

  /// `Enter name or symbol`
  String get enterNameOrSymbol {
    return Intl.message(
      'Enter name or symbol',
      name: 'enterNameOrSymbol',
      desc: '',
      args: [],
    );
  }

  /// `in search line`
  String get inSearchLine {
    return Intl.message(
      'in search line',
      name: 'inSearchLine',
      desc: '',
      args: [],
    );
  }

  /// `On your list of cryptocurrencies`
  String get onYourListOfCryptocurrencies {
    return Intl.message(
      'On your list of cryptocurrencies',
      name: 'onYourListOfCryptocurrencies',
      desc: '',
      args: [],
    );
  }

  /// `nothing yet`
  String get nothingYet {
    return Intl.message(
      'nothing yet',
      name: 'nothingYet',
      desc: '',
      args: [],
    );
  }

  /// `undo`
  String get undo {
    return Intl.message(
      'undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
