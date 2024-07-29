import 'package:equatable/equatable.dart';

class CryptoCoinsAll extends Equatable{
  const CryptoCoinsAll({
    required this.symbolToName, 
    required this.nameToSymbol
  });

  final Map<String, String> symbolToName;
  //Value is List with 1 element or more
  final Map<String, List<String>> nameToSymbol;
  
  @override
  List<Object?> get props => [symbolToName, nameToSymbol];
}