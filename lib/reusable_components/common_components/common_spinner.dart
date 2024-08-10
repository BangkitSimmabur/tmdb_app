import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/helpers/constant.dart';


class CommonSpinner extends StatelessWidget {
  final double spinnerSize;
  final Color? spinnerColor;

  const CommonSpinner({super.key, this.spinnerSize = 50, this.spinnerColor});

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      height: spinnerSize,
      width: spinnerSize,
      child:  SpinKitRing(
        color: spinnerColor ?? Constant.colorRed,
      ),
    ),
  );
}
