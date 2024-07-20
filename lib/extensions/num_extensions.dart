import 'dart:math';

extension TruncateDoubles on num {
  num cutNumber(int fractionalDigits) => (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}