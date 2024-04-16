import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sys_mobile/ui/utils/theme.dart';

Widget TextFieldBox({
  double? height,
  double? width,
  Widget? leadingIcon,
  bool leadingDivider = false,
  TextEditingController? controller,
  TextStyle? textStyle,
  String? hintText,
  TextStyle? hintTextStyle,
  int? maxLength,
  bool obscureText = false,
  void Function(String)? onChanged,
  Widget? trailingIcon,
  void Function()? onTrailingIconTap,
  Color? color,
  Color? borderColor,
  bool hasShadow = false,
  Color? shadowColor,
  EdgeInsets? margin,
  EdgeInsets? padding,
  TextAlign? textAlign,
  bool readOnly = false,
  String? label,
}) {
  return Container(
    margin: margin,
    padding: padding ??
        EdgeInsets.only(
          left: leadingIcon != null ? 5 : 25,
          right: 25,
        ),
    height: height,
    width: width,
    alignment: Alignment.center,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leadingIcon != null)
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: leadingDivider ? 0 : 15,
            ),
            child: leadingIcon,
          ),
        if (leadingIcon != null && leadingDivider)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 24,
            width: 1,
            color: SysAppTheme().borderGrey,
          ),
        Flexible(
          child: TextField(
            controller: controller,
            maxLines: 1,
            readOnly: readOnly,
            maxLength: maxLength ?? 30,
            obscureText: obscureText,
            // expands: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              enabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: hintTextStyle ??
                  SysAppTheme().textStyle(
                    fontSize: SysAppTheme().fontSizeDefaultHeading,
                    fontWeight: SysAppTheme().fontWeightDefaultBody,
                    color: SysAppTheme().textGrey,
                  ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            ),
            style: textStyle ??
                SysAppTheme().textStyle(
                  fontSize: SysAppTheme().fontSizeDefaultHeading,
                  fontWeight: SysAppTheme().fontWeightDefaultHeading,
                  color: SysAppTheme().textColor,
                ),
            textAlign: textAlign ?? TextAlign.left,
            onChanged: onChanged,
          ),
        ),
        if (trailingIcon != null)
          InkWell(
            onTap: onTrailingIconTap ?? () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
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
  Widget?
      replacementWidget, // to be used when content of button is complex and needs to be written locally
  void Function()? onTap,
  Color? color,
  Color? borderColor,
  double minHeight = 60, // set to fit size to content
  EdgeInsets? padding,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding,
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      decoration: BoxDecoration(
        color: color ?? SysAppTheme().buttonColor,
        borderRadius:
            BorderRadius.circular(SysAppTheme().borderRadiusForButton),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: replacementWidget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) icon,
              if (icon != null && text != null)
                const SizedBox(
                  width: 15,
                ),
              if (text != null)
                Text(
                  text,
                  style: GoogleFonts.encodeSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ).copyWith(color: Colors.white),
                ),
            ],
          ),
    ),
  );
}

void showPostStatusCard(
    {required BuildContext context,
    required IconData icon,
    required String body,
    required Color iconColor,
    required String title}) {
  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: GoogleFonts.encodeSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ).copyWith(color: Color(0xff1B2028)),
        ),
        content: Text(
          textAlign: TextAlign.center,
          body,
          style: GoogleFonts.encodeSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ).copyWith(color: Color(0xff1B2028)),
        ),
        icon: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.3),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        // actions: <Widget>[
        //   Center(
        //     child: TextButton(
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //       child: Text('Ok',
        //           style: GoogleFonts.encodeSans(
        //             fontSize: 14,
        //             fontWeight: FontWeight.w500,
        //           )
        //           // .copyWith(
        //           //   color: Color(0xff1B2028),
        //           // ),
        //           ),
        //     ),
        //   ),
        // ],
      );
    },
  );
}
