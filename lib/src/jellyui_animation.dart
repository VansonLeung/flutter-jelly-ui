part of '../flutter_jellyui.dart';

class JellyUiAnimationWidgetStyle {

  final Duration duration;
  final Duration reverseDuration;

  final bool shouldReverseInactive;
  final bool shouldReverseActive;

  final double scaleUpX;
  final double scaleUpY;

  final double scaleBaseX;
  final double scaleBaseY;

  final double damping;
  final double stiffness;
  final double mass;

  final double dampingReverse;
  final double stiffnessReverse;
  final double massReverse;

  final double dampingRight;
  final double stiffnessRight;
  final double massRight;

  final double dampingRightReverse;
  final double stiffnessRightReverse;
  final double massRightReverse;

  const JellyUiAnimationWidgetStyle({
    this.duration = const Duration(seconds: 1),
    this.reverseDuration = const Duration(seconds: 1),
    this.shouldReverseInactive = false,
    this.shouldReverseActive = false,
    this.scaleUpX = 0.15,
    this.scaleUpY = 0.15,
    this.scaleBaseX = 1.0,
    this.scaleBaseY = 1.0,
    this.damping = 8.0,
    this.stiffness = 2400.0,
    this.mass = 2.0,
    this.dampingReverse = 8.0,
    this.stiffnessReverse = 2400.0,
    this.massReverse = 2.0,
    this.dampingRight = 10.0,
    this.stiffnessRight = 2600.0,
    this.massRight = 1.0,
    this.dampingRightReverse = 10.0,
    this.stiffnessRightReverse = 2600.0,
    this.massRightReverse = 1.0,
  });

  static const JellyUiAnimationWidgetStyle defaultStyle = JellyUiAnimationWidgetStyle();
}

class JellyUiAnimationStateController {
  final Function(AnimationStatus)? onAnimationStatusChange;

  bool isBusy = false;

  late Function animate;

  JellyUiAnimationStateController({
    this.onAnimationStatusChange,
  });

  void didAnimationStatusChange(AnimationStatus status) {

    if (status == AnimationStatus.dismissed
    || status == AnimationStatus.completed) {
      isBusy = false;
    } else {
      isBusy = true;
    }

    if (onAnimationStatusChange != null) {
      onAnimationStatusChange!(status);
    }
  }

}

class JellyUiAnimationWidget extends StatefulWidget {

  final bool isActive;
  final Widget child;
  final JellyUiAnimationWidgetStyle style;
  final JellyUiAnimationStateController? stateController;

  const JellyUiAnimationWidget({
    super.key,
    required this.isActive,
    required this.child,
    this.style = JellyUiAnimationWidgetStyle.defaultStyle,
    this.stateController,
  });

  @override
  State<JellyUiAnimationWidget> createState() => _JellyUiAnimationWidgetState();
}

class _JellyUiAnimationWidgetState extends State<JellyUiAnimationWidget> with TickerProviderStateMixin {

  late AnimationController _animationControllerScaleX;
  late AnimationController _animationControllerScaleY;
  late Animation<double> _animationScaleX;
  late Animation<double> _animationScaleY;

  @override
  void initState() {
    super.initState();

    widget.stateController?.animate = () {
      animate(widget.isActive);
    };

    _animationControllerScaleX = AnimationController(
      vsync: this,
      duration: widget.style.duration,
      reverseDuration: widget.style.reverseDuration,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1,
      animationBehavior: AnimationBehavior.normal,
    );
    _animationControllerScaleY = AnimationController(
        vsync: this,
        duration: widget.style.duration,
        reverseDuration: widget.style.reverseDuration,
        lowerBound: 0.0,
        upperBound: 1.0,
      value: 1,
      animationBehavior: AnimationBehavior.normal,
    );
    _animationScaleX = CurvedAnimation(
      parent: _animationControllerScaleX,
      // curve: Curves.linear,
      curve: Sprung.custom(
          damping: widget.style.damping,
          stiffness: widget.style.stiffness,
          mass: widget.style.mass),
      reverseCurve: Sprung.custom(
          damping: widget.style.dampingReverse,
          stiffness: widget.style.stiffnessReverse,
          mass: widget.style.massReverse),
    )..addStatusListener(onRecvAnimationStatus);

    _animationScaleY = CurvedAnimation(
      parent: _animationControllerScaleY,
      // curve: Curves.linear,
      curve: Sprung.custom(
          damping: widget.style.dampingRight,
          stiffness: widget.style.stiffnessRight,
          mass: widget.style.massRight),
      reverseCurve: Sprung.custom(
          damping: widget.style.dampingRightReverse,
          stiffness: widget.style.stiffnessRightReverse,
          mass: widget.style.massRightReverse),
    );
  }


  void onRecvAnimationStatus(AnimationStatus status) {
    if (widget.stateController != null) {
      widget.stateController!.didAnimationStatusChange(status);
    }
  }


  void animate(bool isActive) {
    if (isActive) {
      if (widget.style.shouldReverseActive == true) {
        _animationControllerScaleX.reverse(from: 1.0);
        _animationControllerScaleY.reverse(from: 1.0);
      } else {
        _animationControllerScaleX.forward(from: 0.0);
        _animationControllerScaleY.forward(from: 0.0);
      }
    } else {
      if (widget.style.shouldReverseInactive == true) {
        _animationControllerScaleX.reverse(from: 1.0);
        _animationControllerScaleY.reverse(from: 1.0);
      } else {
        _animationControllerScaleX.forward(from: 0.0);
        _animationControllerScaleY.forward(from: 0.0);
      }
    }
  }

  @override
  void didUpdateWidget(covariant JellyUiAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      animate(widget.isActive);
    }
  }

  @override
  void dispose() {
    _animationControllerScaleX.dispose();
    _animationControllerScaleY.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints)
    // {
    //   double width = constraints.maxWidth;
    //   double height = constraints.maxHeight;
    //   return AnimatedContainer(
    //     curve: Sprung.underDamped,
    //     duration: duration,
    //     transform: Matrix4.diagonal3Values(widget.isActive ? 1.5 : 1.0, 1.0, 1.0),
    //     child: AnimatedContainer(
    //       curve: Sprung.underDamped,
    //       duration: duration,
    //       transform: Matrix4.diagonal3Values(1.0, widget.isActive ? 1.5 : 1.0, 1.0),
    //       child: Positioned(
    //         child: widget.child,
    //       ),
    //     ),
    //   );
    // });

    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _animationScaleX,
          _animationScaleY,
        ]),
        child: widget.child,
        builder: (BuildContext context, Widget? child) {

          final scaleBaseX = widget.style.scaleBaseX ?? 1.0;
          final scaleBaseY = widget.style.scaleBaseY ?? 1.0;
          final scaleUpX = widget.style.scaleUpX ?? 0.0;
          final scaleUpY = widget.style.scaleUpY ?? 0.0;

          Matrix4 transform = Matrix4.identity();
          if (widget.isActive) {
            if (widget.style.shouldReverseActive == true) {
              transform = transform..scale(
                  (scaleBaseX + scaleUpX - _animationScaleX.value * scaleUpX),
                  (scaleBaseY + scaleUpY - _animationScaleY.value * scaleUpY),
                  1.0);
            } else {
              transform = transform..scale(
                  (scaleBaseX + _animationScaleX.value * scaleUpX),
                  (scaleBaseY + _animationScaleY.value * scaleUpY),
                  1.0);
            }
          } else {

            if (widget.style.shouldReverseInactive == true) {
              transform = transform..scale(
                  (scaleBaseX + _animationScaleX.value * scaleUpX),
                  (scaleBaseY + _animationScaleY.value * scaleUpY),
                  1.0);
            } else {
              transform = transform..scale(
                  (scaleBaseX + scaleUpX - _animationScaleX.value * scaleUpX),
                  (scaleBaseY + scaleUpY - _animationScaleY.value * scaleUpY),
                  1.0);
            }
          }


          return Transform(
            transform: transform,
            alignment: FractionalOffset.center,
            child: child,
          )
              .debug(child: Text("${_animationScaleX.value.toStringAsFixed(2)} ${_animationScaleY.value.toStringAsFixed(2)}"));
        },
      )
    );
  }

}
