import 'package:flutter/material.dart';

import 'local_size_builder.dart';

enum Layout {
  mobile,
  tablet
}

extension SizeUtils on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  Layout get layout {
    final w = MediaQuery.of(this).size.width;
    if (w < 1000) {
      return Layout.mobile;
    } else {
      return Layout.tablet;
    }
  }
  bool get tablet => layout == Layout.tablet;

  getWPercent(int percent) => width * (percent/100);
  getHPercent(int percent) => height * (percent/100);
}
extension PaddingUtils on BuildContext {
  EdgeInsets get padding {
    final w = MediaQuery.of(this).size.width;
    return EdgeInsets.symmetric(horizontal: w > maxWidth ? paddingHorizontal : 24, vertical: 8);
  }

  bool get isSubRouter => false;

  EdgeInsets paddingSymmetric({double horizontal = 24, double vertical = 8, double? max}) {
    final localSize = findAncestorWidgetOfExactType<LocalSizeBuilder>();
    double w = 0;
    if(localSize != null){
      w = localSize.size.width;
    } else {
      w = MediaQuery.of(this).size.width - (isSubRouter ? kSubRouterSize : 0);
    }
    return EdgeInsets.symmetric(horizontal: w > maxWidth ? (( paddingHorizontalWithMax(max)) + horizontal) : horizontal , vertical: vertical );
  }

  double get paddingHorizontal {
    final localSize = findAncestorWidgetOfExactType<LocalSizeBuilder>();
    double w = 0;
    if(localSize != null){
      w = localSize.size.width;
    } else {
      w = MediaQuery.of(this).size.width - (isSubRouter ? kSubRouterSize : 0);
    }
    return w > maxWidth ? ((w - maxWidth - 16) * 0.5) + 16 : 16;
  }
  double get paddingHorizontalNone {
    final localSize = findAncestorWidgetOfExactType<LocalSizeBuilder>();
    double w = 0;
    if(localSize != null){
      w = localSize.size.width;
      print('LocalSize: ${localSize.size.width}');
    } else {
      w = MediaQuery.of(this).size.width - (isSubRouter ? kSubRouterSize : 0);
    }
    return w > maxWidth ? ((w - maxWidth - 16) * 0.5) + 16 : 0;
  }
  double paddingHorizontalWithMax([double? max]){
    final localSize = findAncestorWidgetOfExactType<LocalSizeBuilder>();
    double w = 0;
    if(localSize != null){
      w = localSize.size.width;
      print('LocalSize: ${localSize.size.width}');
    } else {
      w = MediaQuery.of(this).size.width - (isSubRouter ? kSubRouterSize : 0);
    }
    return w > (max ?? maxWidth) ? ((w - (max ?? maxWidth) - 16) * 0.5) + 16 : 16;
  }

  double get maxWidth => kMaxWidth;
}

const double kMaxWidth = 480;
const double kSubRouterSize = 480;