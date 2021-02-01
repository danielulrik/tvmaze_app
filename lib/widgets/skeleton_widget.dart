import 'package:flutter/material.dart';
import 'package:tvmaze_app/util/colors_util.dart';
class SkeletonWidget extends StatefulWidget {
  // final EdgeInsets margin;
  // final EdgeInsets padding;
  // final double radius;
  // final double width;
  // final double height;

  // SkeletonWidget({
  //   Key key,
  //   this.margin,
  //   this.padding,
  //   this.radius,
  //   this.width,
  //   this.height,
  // }) : super(key: key);

  createState() => SkeletonWidgetState();
}

class SkeletonWidgetState extends State<SkeletonWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    gradientPosition = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: this.widget.margin,
      // padding: this.widget.padding,
      // width: this.widget.width,
      // height: this.widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: Alignment(-1, 0),
          colors: [
            // ColorsStyle.background.withOpacity(0.4),
            // ColorsStyle.background.withOpacity(1.0),
            // ColorsStyle.background.withOpacity(0.4)
            ColorsUtil.background.withOpacity(0.2),
            ColorsUtil.background.withOpacity(0.4),
            ColorsUtil.background.withOpacity(0.2)
          ],
        ),
        // borderRadius: BorderRadius.all(
        //   Radius.circular(this.widget.radius),
        // ),
      ),
    );
  }
}
