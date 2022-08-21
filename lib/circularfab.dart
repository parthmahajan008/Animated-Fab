import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui';

const buttonsize = 80;

class CircularFab extends StatefulWidget {
  const CircularFab({Key? key}) : super(key: key);
  @override
  State<CircularFab> createState() => _CircularFabState();
}

class _CircularFabState extends State<CircularFab>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Flow(
        delegate: FlowMenuDelegate(controller: controller),
        children: [
          Icons.mail,
          Icons.call,
          Icons.notifications,
          Icons.sms,
          Icons.menu,
        ].map(buildfab).toList(),
      );

  Widget buildfab(IconData icon) => SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          elevation: 0,
          splashColor: Colors.black,
          child: Icon(
            icon,
            color: Colors.white,
            size: 45,
          ),
          onPressed: () {
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
        ),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;
  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xstart = size.width - buttonsize;
    final ystart = size.height - buttonsize;
    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final islastitem = i == context.childCount - 1;
      final setvalue = (value) => islastitem ? 0.0 : value;
      final radius = 180 * controller.value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xstart - setvalue(radius * cos(theta));
      final y = ystart - setvalue(radius * sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(buttonsize / 2, buttonsize / 2)
          ..rotateZ(islastitem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
          ..scale(islastitem ? 1.0 : max(controller.value, 0.5))
          ..translate(-buttonsize / 2, -buttonsize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
