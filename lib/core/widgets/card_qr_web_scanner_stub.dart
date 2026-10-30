import 'package:flutter/widgets.dart';

class CardQrWebScanner extends StatelessWidget {
  final ValueChanged<String> onDetected;
  final ValueChanged<String> onError;

  const CardQrWebScanner({
    super.key,
    required this.onDetected,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
