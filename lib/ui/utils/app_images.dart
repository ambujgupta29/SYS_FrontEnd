import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  static AssetImage indianFlagCircular() {
    return const AssetImage('lib/assets/images/indian_flag_circular.png');
  }

  static AssetImage waveLoaderDarkMode() {
    return const AssetImage('lib/assets/images/waveLoaderDarkMode.gif');
  }

  static AssetImage waveLoaderLightMode() {
    return const AssetImage('lib/assets/images/waveLoaderLightMode.gif');
  }

  static AssetImage modelImage() {
    return const AssetImage('lib/assets/images/model.png');
  }

  static SvgPicture homeSelected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/home_selected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture homeUnselected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/home_unselected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture addSelected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/navbar_add_selected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture addUnselected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/navbar_add_unselected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture likesUnselected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/likes_unselected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture cartUnselected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/cart_unselected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture profileUnselected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/profile_unselected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture likesSelected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/likes_selected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture cartSelected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/cart_selected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture profileSelected(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/profile_selected.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture profileSelectedBlack(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/profile_selected_black.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture search(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/search.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture filter(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/filter.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture rating(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/rating.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture isFavourite(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/isfavourite.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture isNotFavourite(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/isnotfavourite.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture add(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/add.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture minus(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/minus.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture isFavouriteBlack(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/isfavouriteblack.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture isNotFavouriteBlack(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/isnotfavouriteblack.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture back(BuildContext context,
      {Color? color, double? width, double? height, bool? isColor}) {
    return getSVGImage(
      'lib/assets/images/back.svg',
      context,
      width: width,
      height: height,
    );
  }

  static SvgPicture getSVGImage(
    String? url,
    BuildContext context, {
    dynamic width,
    dynamic height,
    String? iconName,
  }) {
    return SvgPicture.asset(
      //"https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80",
      url!,
      width: width,
      height: height,
      key: Key(iconName.toString()),
    );
  }
}
