// [TransparentScreen] is a [StatelessWidget] that shows a transparent screen
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class TransparentScreen<VM extends BlocBase<S>, S>
    extends StatelessWidget {
  const TransparentScreen({
    super.key,
    required this.child,
    required this.selector,
  });

  final Widget? child;
  final bool Function(S state) selector;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VM, S, bool>(
      selector: (state) => selector(state),
      builder: (context, state) {
        return state
            ? SizedBox(
                height: context.deviceHeight,
                width: context.deviceWidth,
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.5),
                  child: child ?? const SizedBox.shrink(),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
