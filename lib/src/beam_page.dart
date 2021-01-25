import 'package:flutter/material.dart';

class BeamPage extends Page {
  BeamPage({
    Key key,
    @required this.page,
    this.keepPathParametersOnPop = false,
  }) : super(key: key);

  final Widget page;
  final bool keepPathParametersOnPop;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => page,
    );
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is BeamPage && key == other.key;
  }
}