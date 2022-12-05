import 'dart:async';

import 'package:arc/arc_subject.dart';
import 'package:flutter/material.dart';

/// {@category Component}
/// stateful 이므로 초기값 설정에 주의할 것.
/// ```dart
/// viewModel.isChecked.ui(
///    builder: (context, autoLogin) => CustomSwitch(
///     value: isChecked.data ?? false,
///     onChanged: (value) {
///       viewModel.onToggleSwitch();
///     })),
/// ```
/// ```dart
/// onToggleSwitch() => isChecked.val = !isChecked.val;
/// ```
class CustomSwitch extends StatefulWidget {
  bool value;
  ValueChanged<bool>? onChanged;
  Color activeColor;
  Color inactiveColor;
  double width;
  double height;
  double padding;

  CustomSwitch({
    Key? key,
    this.value = false,
    this.onChanged,
    this.activeColor = const Color(0xff00dd6d),
    this.inactiveColor = const Color(0xffe9e9ea),
    this.width = 48,
    this.height = 24,
    this.padding = 2,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  final _isSwitchOn = ArcSubject<bool>();

  late StreamSubscription<bool> _onOffListener;

  void valueUpdate(state) {
    _isSwitchOn.val = state as bool;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _circleAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.linear));

    _onOffListener = _isSwitchOn.stream.listen((event) {
      if (event) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isSwitchOn.close();
    _onOffListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    valueUpdate(widget.value);
    return _isSwitchOn.ui(
      builder: (context, snapshot) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.value = !widget.value;
                  if (widget.onChanged != null) {
                    widget.onChanged!(widget.value);
                  }
                });
              },
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.height / 2),
                    color: _circleAnimation.value == Alignment.centerLeft
                        ? widget.inactiveColor
                        : widget.activeColor),
                child: Padding(
                  padding: EdgeInsets.all(widget.padding),
                  child: Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: widget.height - (widget.padding * 2),
                      height: widget.height - (widget.padding * 2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
