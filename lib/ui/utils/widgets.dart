import 'package:flutter/material.dart';
import 'package:sys_mobile/ui/utils/theme.dart';

Widget TextFieldBox({
  double? height,
  double? width,
  Widget? leadingIcon,
  TextEditingController? controller,
  TextStyle? textStyle,
  String? hintText,
  TextStyle? hintTextStyle,
  bool obscureText = false,
  void Function(String)? onChanged,
  Widget? trailingIcon,
  void Function()? onTrailingIconTap,
  Color? color,
  Color? borderColor,
  bool hasShadow = false,
  Color? shadowColor,
}){
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: color ?? SysAppTheme().cardColor,
      borderRadius: BorderRadius.circular(SysAppTheme().borderRadiusForButton),
      shape: BoxShape.rectangle,
      border: Border.all(color: borderColor ?? Colors.transparent),
      boxShadow: hasShadow
          ? [
            BoxShadow(
              color: shadowColor ?? SysAppTheme().textGrey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]
          : null,
    ),
    child: Row(
      children: [
        if (leadingIcon != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: leadingIcon,
          ),
        Flexible(
          child: TextField(
            controller: controller,
            maxLines: 1,
            maxLength: 30,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: SysAppTheme().textStyle(
                fontSize: 16,
                color: SysAppTheme().textGrey,
              ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            ),
            style: SysAppTheme().textStyle(
              color: SysAppTheme().textGrey,
            ),
            onChanged: onChanged,
          ),
        ),
        if (trailingIcon != null)
          InkWell(
            onTap: onTrailingIconTap ?? (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,),
              child: trailingIcon,
            ),
          ),
      ],
    ),
  );
}

Widget Button({
  String? text,
  Widget? icon,
  Widget? replacementWidget, // to be used when content of button is complex and needs to be written locally
  void Function()? onTap,
  Color? color,
  Color? borderColor,
  double minHeight = 60, // set to fit size to content
  EdgeInsets? padding,
}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding,
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      decoration: BoxDecoration(
        color: color ?? SysAppTheme().buttonColor,
        borderRadius: BorderRadius.circular(SysAppTheme().borderRadiusForButton),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: replacementWidget ?? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            icon,
          if (icon != null && text != null)
            const SizedBox(width: 15,),
          if (text != null)
            Text(
              text,
              style: SysAppTheme().textStyle(
                color: SysAppTheme().buttonTextColor,
              ),
            ),
        ],
      ),
    ),
  );
}