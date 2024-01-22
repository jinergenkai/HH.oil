import 'package:flutter/material.dart';
import '../app.dart';

class BlurBorderContainer extends StatelessWidget {
  const BlurBorderContainer({
    super.key,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.child
  });

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimens.d100.responsive(),
      // width: Dimens.d150.responsive(),
      decoration: BoxDecoration(
        color: AppColors.current.secondaryColor,
        borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
        boxShadow: [
          BoxShadow(
            color: AppColors.current.primaryColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            // offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: padding,
      margin: margin,
      height: height,
      width: width,

      child: child,
    );
  }
}
