import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

ToastificationItem? customToast(BuildContext context, String? msg,
    {ToastificationType? type}) {
  return msg == null
      ? null
      : toastification.show(
          context: context,
          type: type ?? ToastificationType.success,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
          title: Text(msg),
          // you can also use RichText widget for title and description parameters
          // description: RichText(text: const TextSpan(text: 'This is a sample toast message. ')),
          alignment: Alignment.topRight,
          direction: TextDirection.ltr,
          animationDuration: const Duration(milliseconds: 300),
          animationBuilder: (context, animation, alignment, child) {
            return FadeTransition(
              opacity: animation,
              child: Align(alignment: alignment, child: child),
            );
          },

          showProgressBar: true,
          closeButtonShowType: CloseButtonShowType.onHover,
          closeOnClick: false,
          pauseOnHover: true,
          dragToClose: true,
          applyBlurEffect: true,
          callbacks: ToastificationCallbacks(
            onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
            onCloseButtonTap: (toastItem) {
              context.canPop() ? context.pop() : null;
            },
            onAutoCompleteCompleted: (toastItem) =>
                print('Toast ${toastItem.id} auto complete completed'),
            onDismissed: (toastItem) =>
                print('Toast ${toastItem.id} dismissed'),
          ),
        );
}
