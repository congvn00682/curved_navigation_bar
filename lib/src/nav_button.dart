import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final String? textCenter;
  final TextStyle? textStyle;
  final CurveItem item;
  final bool? isSelected;
  final Color? active;
  final Color? inActive;

  NavButton({
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    this.textCenter,
    this.textStyle,
    required this.item,
    this.isSelected = false,
    this.active = const Color(0xff3D6AFF),
    this.inActive = const Color(0xffB8BABF),
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          difference < 1.0 / length ? null : onTap(index);
        },
        child: Container(
          height: 90,
          padding: EdgeInsets.only(top: 10),
          child: Transform.translate(
            offset: Offset(0, difference < 1.0 / length ? verticalAlignment * -8 : 0),
            child: Opacity(
              opacity: 1,
              child: difference < 1.0 / length * 0.99
                  ? Center(
                      child: Text(
                        textCenter ?? '',
                        style:
                            textStyle ?? TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xffB8BABF)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  : Column(
                      children: [
                        Image.asset(
                          isSelected! ? item.iconSelected : item.icon,
                          width: 24,
                          height: 24,
                        ),
                        Text(
                          item.title ?? '',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: isSelected! ? active : inActive),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
