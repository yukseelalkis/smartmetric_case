import 'package:smartmetric_case/product/utility/constant/enums/status_filter.dart';

extension StatusFilterX on StatusFilter {
  String get label {
    switch (this) {
      case StatusFilter.general:
        return 'general';
      case StatusFilter.active:
        return 'active';
      case StatusFilter.passive:
        return 'passive';
    }
  }
}
