import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';
import 'package:sys_mobile/common/loader_control.dart';

import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';
import 'package:sys_mobile/ui/utils/theme.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class ProfileCardModel {
  IconData icon;
  String title;
  bool hasArrow;
  Color iconColor;
  Function() onTap;

  ProfileCardModel(
      this.icon, this.title, this.hasArrow, this.iconColor, this.onTap) {}
}

class ProfileScreen extends StatefulWidget {
  final dynamic arguments;
  const ProfileScreen({super.key, this.arguments});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileCardModel>? profileCardList;
  File? uploadFile;
  Map<String, dynamic>? decodedToken;
  ProfileBloc? _profileBloc;
  @override
  void initState() {
    decodedToken = JwtDecoder.decode(AppStorage().getString(USER_TOKEN));
    _profileBloc = BlocProvider.of(context);
    _profileBloc?.add(GetProfilePictureEvent());
    _profileBloc?.stream.listen(uploadProfilePicListener);
    profileCardList = [
      ProfileCardModel(Icons.shopping_cart_checkout_outlined, "My Postings",
          true, Color(0xff1B2028), () {
        Navigator.pushNamed(context, '/UserproductListing');
      }),
      ProfileCardModel(
          Icons.logout_outlined, "Logout", false, Color(0xff1B2028), () {
        print("abc");
      }),
    ];
    super.initState();
  }

  Future<void> uploadProfilePicListener(state) async {
    if (state is UploadProfilePictureSuccessState) {
      stopLoader(context);
      await Future.delayed(Duration(seconds: 3), () {
        _profileBloc?.add(GetProfilePictureEvent());
      });
    } else if (state is UploadProfilePictureFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is UploadProfilePictureProgressState) {
      startLoader(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SysAppTheme().buttonColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Color(0xff1B2028),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (ProfileState prevState,
                              ProfileState currentState) {
                            return currentState
                                    is GetProfilePictureSuccessState ||
                                currentState is GetProfilePictureFailedState ||
                                currentState is GetProfilePictureProgressState;
                          },
                          builder: (context, state) {
                            if (state is GetProfilePictureSuccessState) {
                              return Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      // radius: 75,
                                      child: (state.fetchProfilePictureModel
                                                      .url !=
                                                  null &&
                                              state.fetchProfilePictureModel
                                                      .url !=
                                                  '')
                                          ? CachedNetworkImage(
                                              imageUrl: state
                                                      .fetchProfilePictureModel
                                                      .url ??
                                                  '',
                                              placeholder: (context, url) =>
                                                  Icon(
                                                      Icons.wallpaper_outlined),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                              fit: BoxFit.cover)
                                          : Image.asset(
                                              'lib/assets/images/model.png',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () async {
                                        _pickImage(ImageSource.gallery);
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.edit,
                                            color: Color(0xff1B2028),
                                          )),
                                    ),
                                  )
                                ],
                              );
                            } else if (state is GetProfilePictureFailedState) {
                              return Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 170,
                                      height: 170,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      // radius: 75,
                                      child: Image.asset(
                                        'lib/assets/images/model.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    right: 5,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.edit,
                                          color: Color(0xff1B2028),
                                        )),
                                  )
                                ],
                              );
                            } else if (state
                                is GetProfilePictureProgressState) {
                              return Container();
                            } else {
                              return Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 170,
                                      height: 170,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      // radius: 75,
                                      child: Image.asset(
                                        'lib/assets/images/model.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    right: 5,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.edit,
                                          color: Color(0xff1B2028),
                                        )),
                                  )
                                ],
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 3),
                          child: Text(
                            decodedToken?['fullname'] ?? 'NA',
                            style: GoogleFonts.encodeSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ).copyWith(color: Colors.white),
                          ),
                        ),
                        Text(
                          decodedToken?['mobileNumber'] ?? 'NA',
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  width: double.infinity,
                  height: 450,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container();
                        // Divider(
                        //   endIndent: 20,
                        //   indent: 20,
                        // );
                      },
                      itemCount: profileCardList!.length,
                      itemBuilder: ((context, index) {
                        return profileCard(
                            icon: profileCardList![index].icon,
                            title: profileCardList![index].title,
                            hasArrow: profileCardList![index].hasArrow,
                            iconColor: profileCardList![index].iconColor,
                            onTap: profileCardList![index].onTap);
                      })),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
      );

      if (croppedFile != null) {
        setState(() {
          uploadFile = File(croppedFile.path!);
        });
        _profileBloc?.add(UploadProfilePictureEvent(uploadFile));
      }
    }
  }

  Widget profileCard(
      {required IconData icon,
      required String title,
      required bool hasArrow,
      required Color iconColor,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.encodeSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ).copyWith(color: Color(0xff1B2028)),
              ),
            ),
            hasArrow
                ? const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
