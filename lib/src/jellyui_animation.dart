part of '../flutter_jellyui.dart';

class JellyUiAnimationWidget extends StatefulWidget {

  final bool isActive;
  final Widget child;

  const JellyUiAnimationWidget({
    super.key,
    required this.isActive,
    required this.child,
  });

  @override
  State<JellyUiAnimationWidget> createState() => _JellyUiAnimationWidgetState();
}

class _JellyUiAnimationWidgetState extends State<JellyUiAnimationWidget> with TickerProviderStateMixin {

  Duration duration = const Duration(seconds: 1);
  late AnimationController _animationControllerScaleX;
  late AnimationController _animationControllerScaleY;
  late Animation<double> _animationScaleX;
  late Animation<double> _animationScaleY;

  @override
  void initState() {
    super.initState();
    _animationControllerScaleX = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1,
      animationBehavior: AnimationBehavior.normal,
    );
    _animationControllerScaleY = AnimationController(
        vsync: this,
        duration: duration,
        lowerBound: 0.0,
        upperBound: 1.0,
      value: 1,
      animationBehavior: AnimationBehavior.normal,
    );
    _animationScaleX = CurvedAnimation(
      parent: _animationControllerScaleX,
      // curve: Curves.linear,
      curve: Sprung.custom(damping: 8, stiffness: 2400, mass: 2.0),
      reverseCurve: Sprung.custom(damping: 8, stiffness: 2400, mass: 2.0),
    );

    _animationScaleY = CurvedAnimation(
      parent: _animationControllerScaleY,
      // curve: Curves.linear,
      curve: Sprung.custom(damping: 10, stiffness: 600, mass: 1.0),
      reverseCurve: Sprung.custom(damping: 10, stiffness: 1000, mass: 1.0),
    );
  }

  @override
  void didUpdateWidget(covariant JellyUiAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _animationControllerScaleX.forward(from: 0.0);
        _animationControllerScaleY.forward(from: 0.0);
      } else {
        _animationControllerScaleX.forward(from: 0.0);
        _animationControllerScaleY.forward(from: 0.0);
      }
    }
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

          const double scaleUpX = 0.5;
          const double scaleUpY = 0.5;

          final Matrix4 transform = Matrix4.identity()
            ..scale(
                widget.isActive ? (1.0 + _animationScaleX.value*scaleUpX) : (1.0 + scaleUpX - _animationScaleX.value*scaleUpX),
                widget.isActive ? (1.0 + _animationScaleY.value*scaleUpY) : (1.0 + scaleUpY - _animationScaleY.value*scaleUpY),
                1.0);

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
