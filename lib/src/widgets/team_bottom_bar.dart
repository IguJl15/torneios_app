import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoInput extends StatefulWidget {
  final TextEditingController controller;

  final VoidCallback addItemButtonPressed;

  final FocusNode focusNode;

  final bool enabled;

  const InfoInput({
    super.key,
    required this.controller,
    required this.addItemButtonPressed,
    required this.focusNode,
    this.enabled = true,
  });

  @override
  State<InfoInput> createState() => _InfoInputState();
}

class _InfoInputState extends State<InfoInput> {
  final _formKey = GlobalKey<FormState>();

  bool get isPlatformDesktop =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.fuchsia;

  void submit(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      final onPress = widget.addItemButtonPressed;

      onPress();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isPlatformDesktop) FocusScope.of(context).requestFocus(widget.focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              enabled: widget.enabled,
              textAlign: TextAlign.center,
              controller: widget.controller,
              cursorColor: theme.colorScheme.primaryContainer,
              style: TextStyle(
                color: theme.colorScheme.primaryContainer,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: "Nome da nova equipe",
                filled: true,
                fillColor: theme.colorScheme.onPrimaryContainer,
                errorStyle: TextStyle(color: theme.colorScheme.errorContainer),
                // border: OutlineInputBorder(),
              ),
              focusNode: widget.focusNode,
              onFieldSubmitted: (_) => submit(context),
              onEditingComplete: () {},
              validator: (value) {
                if (value == null) return null;

                if (value.isNotEmpty && value.length < 4) {
                  return "Nome muito curto";
                }

                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            height: 48,
            width: 48,
            child: IconButton.filled(
              onPressed: widget.enabled ? () => submit(context) : null,
              icon: const Icon(Icons.add_task),
              tooltip: "Criar",
              style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            ),
          )
        ],
      ),
    );
  }
}
