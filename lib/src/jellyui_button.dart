part of '../flutter_jellyui.dart';

class JellyUiButton extends StatefulWidget {

  final Function? onPressed;
  final Widget child;

  const JellyUiButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  State<JellyUiButton> createState() => _JellyUiButtonState();
}

class _JellyUiButtonState extends State<JellyUiButton> {

  bool _isPressing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return JellyUiAnimationWidget(
      isActive: _isPressing,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressing = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            if (_isPressing) {
              _isPressing = false;
              if (widget.onPressed != null) {
                widget.onPressed!();
              }
            }
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressing = false;
          });
        },


        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            disabledBackgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white,
            // foregroundColor: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve(
            //     {MaterialState.focused}),
            // disabledForegroundColor: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve(
            //     {MaterialState.focused}),
          ),
          child: widget.child,
        ),

      ),
    );


  }

}
