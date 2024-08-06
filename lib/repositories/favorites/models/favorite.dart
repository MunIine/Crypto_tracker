import 'package:coins_list/config/hive_consts.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favorite.g.dart';

@HiveType(typeId: FAVORITES_ID)
class Favorite extends Equatable{
  const Favorite({required this.coinNames});

  @HiveField(0)
  final List<String> coinNames;

  @override
  List<Object?> get props => [coinNames];
}