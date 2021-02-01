import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SkeletonListWidget extends StatelessWidget {
  final int qtd;
  final double radius;
  final double height;
  final EdgeInsets margin;

  const SkeletonListWidget({
    @required this.qtd,
    @required this.radius,
    @required this.height,
    @required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        this.qtd,
        (index) {
          return ContainerPlus(
            margin: EdgeInsets.only(top: 12),
            width: double.maxFinite,
            height: height,
            radius: RadiusPlus.all(8),
            skeleton: SkeletonPlus.automatic(enabled: true),
          );
        },
      ).toList(),
    );
  }
}
