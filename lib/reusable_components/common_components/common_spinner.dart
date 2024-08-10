import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/helpers/constant.dart';

/// A custom reusable spinner to display loading
class CommonSpinner extends StatelessWidget {
  /// Spinner size default to 50px
  final double spinnerSize;

  /// Spinner color default to dark red
  final Color? spinnerColor;

  const CommonSpinner({
    super.key,
    this.spinnerSize = 50,
    this.spinnerColor = Constant.colorRed,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          height: spinnerSize,
          width: spinnerSize,
          child: const SpinKitRing(
            color: Constant.colorRed,
          ),
        ),
      );
}
