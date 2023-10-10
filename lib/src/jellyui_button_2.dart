part of '../flutter_jellyui.dart';

class JellyUiButton extends StatefulWidget {

  final Function? onPressed;
  final Widget child;
  final JellyUiAnimationWidgetStyle? style;

  const JellyUiButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  State<JellyUiButton> createState() => _JellyUiButtonState();
}

class _JellyUiButtonState extends State<JellyUiButton> {

  bool _isPressing = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
  }



  void _handleButtonFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
    });
  }



  @override
  Widget build(BuildContext context) {

    final buttonStyle = const ElevatedButton(onPressed: null, child: null).defaultStyleOf(context);
    final foregroundColor = buttonStyle.foregroundColor?.resolve({}) ?? Colors.white;
    final backgroundColor = buttonStyle.backgroundColor?.resolve({}) ?? Colors.grey;
    final backgroundColorPressed = backgroundColor;//.withOpacity(backgroundColor.opacity * 0.1);
    final backgroundColorFocused = backgroundColor;//.withOpacity(backgroundColor.opacity * 0.3);
    final shadowColor = (buttonStyle.shadowColor?.resolve({}) ?? Colors.grey).withOpacity(0.3);

    return JellyUiAnimationWidget(
      isActive: _isPressing,
      child: Stack(
          children: [
            Material(
              color: Colors.transparent,
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      offset: const Offset(0, 0),
                      spreadRadius: 0.0,
                      blurRadius: 4.0,
                    ),
                  ],
                  color: _isPressing
                      ? backgroundColorPressed
                      : (_isFocused
                      ? backgroundColorFocused
                      : backgroundColor),
                ),

                duration: const Duration(milliseconds: 100),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: foregroundColor),
                    child: widget.child,
                  ),
                ),

              ),
            ),


            Positioned.fill(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: _isFocused
                        ? 1.0
                        : 0.0,

                    color: _isPressing
                        ? backgroundColorPressed
                        : (_isFocused
                        ? backgroundColorFocused
                        : backgroundColor),

                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),

                duration: const Duration(milliseconds: 100),
              ),
            ),


            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(

                  onFocusChange: _handleButtonFocusChange,
                  highlightColor: Theme.of(context).colorScheme.error.withOpacity(0.5),
                  splashColor: Theme.of(context).colorScheme.error.withOpacity(1.0),
                  overlayColor: buttonStyle.overlayColor,

                  borderRadius: BorderRadius.circular(4),


                  onTap: () {
                    setState(() {
                      _isPressing = true;

                      SchedulerBinding.instance.addPostFrameCallback((_) {

                        setState(() {
                          if (_isPressing) {
                            _isPressing = false;
                            if (widget.onPressed != null) {
                              widget.onPressed!();
                            }
                          }
                        });

                      });

                    });
                  },

                  onTapDown: (_) {
                    setState(() {
                      _isPressing = true;
                    });
                  },

                  onTapUp: (_) {
                    setState(() {
                      if (_isPressing) {
                        _isPressing = false;
                      }
                    });
                  },

                  onTapCancel: () {
                    setState(() {
                      _isPressing = false;
                    });
                  },
                ),
              ),
            ),

          ]

      ),
    );


  }

}
