part of '../flutter_jellyui.dart';

extension JellyUiExtensionWidget on Widget {
  Widget debug({
    required Widget child,
  }) {
    return this;
    // return Stack(
    //   children: [
    //     this,
    //     child,
    //   ],
    // );
  }

  Widget jellyUiAnimation({
    required ValueListenable<bool> isActive,
  }) {
    return ValueListenableBuilder(valueListenable: isActive, builder: (context, bool isActive, child) {
      return JellyUiAnimationWidget(
        isActive: isActive,
        child: this,
      );
    });
  }
}
