// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/providers/theme_notifier.dart';

class ThemeModeChanger extends StatefulWidget {
  @override
  _ThemeModeChangerState createState() => _ThemeModeChangerState();
}

class _ThemeModeChangerState extends State<ThemeModeChanger> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: IconButton(
          onPressed: () {
            _controller.forward().whenComplete(() {
              Provider.of<ThemeNotifier>(context, listen: false).flipMode();
              _controller.reset();
            });
          },
          iconSize: AppSizes.icon24,
          icon: Icon(
            Provider.of<ThemeNotifier>(context).isLightMode ? Icons.wb_sunny : Icons.nights_stay,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
