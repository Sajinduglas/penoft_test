import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/decoration.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class InputForm extends StatefulWidget {
  final String? initialValue;
  final String? label;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final int? maxlines;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final bool isPasswordField;
  final bool enabled;

  const InputForm({
    super.key,
    this.initialValue,
    this.label,
    this.hintText,
    this.keyboardType,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.maxlines,
    this.isPasswordField = false,
    this.enabled = true,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  late TextEditingController _controller;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _obscureText = widget.isPasswordField;
  }

  @override
  void didUpdateWidget(covariant InputForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: AppTypography.style14W500.copyWith(
              color: AppColors.neutral900,
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _controller,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxlines ?? 1,
          enabled: widget.enabled,
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          cursorColor: Color(0xFF0F172A),
          obscureText: widget.isPasswordField ? _obscureText : false,
          validator: widget.validator,
          decoration: AppDecoration.fieldDecoration(context).copyWith(
            hintText: widget.hintText,
            hintStyle: AppTypography.style14W400.copyWith(
              color: AppColors.neutral500,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: widget.prefixIcon,
                  )
                : null,
            suffixIcon: widget.isPasswordField
                ? Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Text('data')),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
