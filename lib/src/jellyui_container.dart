part of '../flutter_jellyui.dart';

class JellyUiContainer extends StatefulWidget {

  final Widget child;
  final JellyUiAnimationWidgetStyle style;
  final Future<bool> Function()? onWillPop;

  const JellyUiContainer({
    super.key,
    required this.child,
    this.style = defaultStyle,
    this.onWillPop,
  });

  static const defaultStyle = JellyUiAnimationWidgetStyle (
    duration: Duration(milliseconds: 1500),
    reverseDuration: Duration(milliseconds: 150),
    shouldReverseInactive: true,
    shouldReverseActive: false,
    scaleUpX: 1.0,
    scaleUpY: 1.0,
    scaleBaseX: 0.0,
    scaleBaseY: 0.0,
    damping: 18.0,
    stiffness: 1600.0,
    mass: 1.5,
    dampingReverse: 1000.0,
    stiffnessReverse: 2400.0,
    massReverse: 2.0,
    dampingRight: 32.0,
    stiffnessRight: 1300.0,
    massRight: 0.75,
    dampingRightReverse: 1000.0,
    stiffnessRightReverse: 2600.0,
    massRightReverse: 1.0,
  );

  @override
  State<JellyUiContainer> createState() => _JellyUiContainerState();
}

class _JellyUiContainerState extends State<JellyUiContainer> {

  bool _isDisplayed = false;
  late JellyUiAnimationStateController jellyUiAnimationStateController;
  late JellyUiAnimationStateController jellyUiAnimationStateShakeController;

  @override
  void initState() {
    super.initState();
    jellyUiAnimationStateController = JellyUiAnimationStateController(
      onAnimationStatusChange: (AnimationStatus status) {

      }
    );

    jellyUiAnimationStateShakeController = JellyUiAnimationStateController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      show();
    });
  }

  void show() {
    setState(() {
      _isDisplayed = true;
    });
  }

  void hide() {
    setState(() {
      _isDisplayed = false;
    });
  }

  void shake() {
    jellyUiAnimationStateShakeController.animate();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: JellyUiAnimationWidget(
          isActive: _isDisplayed,
          style: widget.style,
          stateController: jellyUiAnimationStateController,
          child: JellyUiAnimationWidget(
            isActive: false,
            style: const JellyUiAnimationWidgetStyle(
              duration: Duration(seconds: 1),
              scaleUpX: 0.05,
              scaleUpY: 0.05,
              scaleBaseX: 1.0,
              scaleBaseY: 1.0,
              damping: 8.0,
              stiffness: 2400.0,
              mass: 4.0,
              dampingRight: 10.0,
              stiffnessRight: 2600.0,
              massRight: 2.0,
            ),
            stateController: jellyUiAnimationStateShakeController,
            child: widget.child,
          ),
        ),
        onWillPop: () {
          return Future(() async {

            bool foo = await widget.onWillPop!() ?? true;

            if (foo) {
              hide();
            } else {
              shake();
            }

            return foo;

          });
        },
    );

  }

}


