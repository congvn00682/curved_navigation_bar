import 'dart:math';
import 'package:curved_navigation_bar/src/nav_custom_clipper.dart';
import 'package:curved_navigation_bar/src/nav_custom_painter_blur.dart';
import 'package:flutter/material.dart';
import 'src/nav_button.dart';
import 'src/nav_custom_painter.dart';

class CurveItem {
  final String? title;
  final String icon;
  final String iconSelected;

  CurveItem({
    this.title,
    required this.icon,
    required this.iconSelected,
  });
}

class CurvedNavigationBar extends StatefulWidget {
  final List<CurveItem> items;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final Color? blur;
  final ValueChanged<int>? onTap;
  final double height;
  final double? maxWidth;
  final String? textCenter;
  final TextStyle? textStyle;

  CurvedNavigationBar({
    Key? key,
    required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.blur,
    this.onTap,
    this.height = 75.0,
    this.maxWidth,
    this.textCenter,
    this.textStyle,
  })  : assert(items.isNotEmpty),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 125.0),
        assert(maxWidth == null || 0 <= maxWidth),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar> with SingleTickerProviderStateMixin {
  late double _pos;
  late String _icon;
  late int _length;
  int _indexSelected = 0;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index].icon;
    _length = widget.items.length;
    _pos = widget.index / _length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = min(constraints.maxWidth, widget.maxWidth ?? constraints.maxWidth);
          return Align(
            alignment: textDirection == TextDirection.ltr ? Alignment.bottomLeft : Alignment.bottomRight,
            child: Container(
              color: widget.backgroundColor,
              width: maxWidth,
              child: ClipRect(
                clipper: NavCustomClipper(
                  deviceHeight: MediaQuery.sizeOf(context).height,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    ///  Background
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,90.0),
                      painter: NavCustomPainterBlur(_pos, _length, widget.blur, textDirection),
                    ),
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,90.0),
                      painter: NavCustomPainter(_pos, _length, widget.color, textDirection),
                    ),

                    /// Icon
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 0 - (130.0 - widget.height),
                      child: SizedBox(
                          height: 90.0,
                          child: Row(
                              children: widget.items.map((item) {
                            return NavButton(
                              onTap: _buttonTap,
                              position: _pos,
                              length: _length,
                              index: widget.items.indexOf(item),
                              textCenter: widget.textCenter,
                              textStyle: widget.textStyle,
                              item: item,
                              isSelected: widget.items.indexOf(item) == _indexSelected,
                            );
                          }).toList())),
                    ),

                    /// Center
                    Positioned(
                      bottom: 56,
                      left: textDirection == TextDirection.rtl ? null : _pos * maxWidth,
                      right: textDirection == TextDirection.rtl ? _pos * maxWidth : null,
                      width: maxWidth / _length,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _buttonTap(2);
                          },
                          child: Image.asset(
                            _icon,
                            width: 68,
                            height: 68,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (widget.onTap != null) {
      widget.onTap!(index);
      setState(() {
        _indexSelected = index;
      });
    }
  }
}
