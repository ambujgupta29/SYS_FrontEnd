import 'package:flutter/material.dart';
import 'package:sys_mobile/common/loader.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';

bool _loaderStared = false;
void stopLoader(BuildContext? context) {
  if (_loaderStared && context != null) {
    Loader.hide();
    _loaderStared = false;
  }
}

void startLoader(BuildContext? context) {
  if (context!.mounted) {
    if (_loaderStared) return;

    _loaderStared = true;
    Loader.show(context,
        progressIndicator: Container(
          alignment: Alignment.center,
          width: 400,
          height: 300,
          child: Image(image: AppImages.waveLoaderLightMode()),
        ),
        themeData: Theme.of(context),
        overlayColor: Colors.black12);
  }
}
