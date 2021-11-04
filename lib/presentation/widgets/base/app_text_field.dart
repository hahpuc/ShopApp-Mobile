import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shop/values/colors.dart';

class AppTextField extends StatefulWidget {
  final String? value;
  final Color? backgroundColor;
  final bool obscureText;
  final bool togglePassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool readOnly;
  final Widget? imageLeft;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enableBorder;
  final EdgeInsetsGeometry? contentPadding;

  ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  VoidCallback? onEditingComplete;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  bool expands;
  TextAlignVertical? textAlignVertical;

  AppTextField({
    Key? key,
    this.backgroundColor,
    this.value,
    this.obscureText = false,
    this.togglePassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.textAlign = TextAlign.start,
    this.controller,
    this.maxLines = 1,
    this.minLines = -1,
    this.inputFormatters,
    this.focusNode,
    this.readOnly = false,
    this.enable = true,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.expands = false,
    this.textAlignVertical,
    this.imageLeft,
    this.border,
    this.focusedBorder,
    this.enableBorder,
    this.contentPadding,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => new _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscure = false;
  Widget? hasImage;
  var _fieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    this.isObscure = widget.obscureText;
    this.hasImage = widget.imageLeft;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      key: _fieldKey,
      expands: widget.expands,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      minLines: widget.minLines != -1 ? widget.minLines : null,
      maxLines: widget.maxLines != -1 ? widget.maxLines : null,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      obscureText: this.isObscure,
      style: widget.style ?? TextStyle(fontSize: 15.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.transparent,
        suffixIcon: _buildSuffixIcon(),
        prefixIcon: _buildPrefixIcon(),
        // border: OutlineInputBorder(
        //     borderSide: BorderSide.none,
        //     borderRadius: BorderRadius.circular(16.0)),
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
            fontSize: 15.0,
            color: AppColor.colorPrimary,
            fontWeight: FontWeight.w400),
        hintStyle: widget.hintStyle ??
            TextStyle(
                fontSize: 16.0,
                color: AppColor.colorTextLight,
                fontWeight: FontWeight.w400),
        enabledBorder: widget.border ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF020306), width: 0.5),
            ),
        focusedBorder: widget.border ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF020306), width: 0.5),
            ),
        border: widget.border ??
            UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF020306), width: 0.5)),
      ),
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.togglePassword && widget.obscureText) {
      return IconButton(
        splashRadius: 20.0,
        icon: Icon(
          (this.isObscure) ? Icons.visibility : Icons.visibility_off,
          size: 16.0,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            this.isObscure = !this.isObscure;
          });
        },
      );
    }
    return widget.suffixIcon ?? null;
  }

  Widget? _buildPrefixIcon() {
    if (hasImage != null) {
      return SizedBox(height: 16.0, child: hasImage);
    }
    return (widget.prefixIcon ?? null);
  }
}
