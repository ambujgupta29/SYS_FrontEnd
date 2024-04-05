import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sys_mobile/ui/utils/theme.dart';

class ProfileCardModel {
  IconData icon;
  String title;
  bool hasArrow;
  Color iconColor;

  ProfileCardModel(this.icon, this.title, this.hasArrow, this.iconColor) {}
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileCardModel> profileCardList = [
    ProfileCardModel(
        Icons.shopping_cart_checkout_outlined, "My Orders", true, Colors.blue),
    ProfileCardModel(Icons.logout_outlined, "Logout", false, Colors.green),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SysAppTheme().buttonColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Colors.deepPurpleAccent,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: 30.0, horizontal: 15),
                //   child: Text(
                //     'Profile',
                //     style: SysAppTheme().textStyle(
                //       fontSize: SysAppTheme().fontSizeDefaultHeading,
                //       fontWeight: SysAppTheme().fontWeightDefaultHeading,
                //       color: SysAppTheme().white,
                //     ),
                //   ),
                // ),
                Flexible(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 3),
                          child: Text(
                            'Ambuj Gupta',
                            style: SysAppTheme().textStyle(
                              fontSize: SysAppTheme().fontSizeDefaultHeading,
                              fontWeight:
                                  SysAppTheme().fontWeightDefaultHeading,
                              color: SysAppTheme().white,
                            ),
                          ),
                        ),
                        Text(
                          '987654321',
                          style: SysAppTheme().textStyle(
                            fontSize: SysAppTheme().fontSizeDefaultHeading,
                            fontWeight: SysAppTheme().fontWeightDefaultHeading,
                            color: SysAppTheme().white,
                          ),
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
                  height: 500,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container();
                        // Divider(
                        //   endIndent: 20,
                        //   indent: 20,
                        // );
                      },
                      itemCount: profileCardList.length,
                      itemBuilder: ((context, index) {
                        return profileCard(
                            icon: profileCardList[index].icon,
                            title: profileCardList[index].title,
                            hasArrow: profileCardList[index].hasArrow,
                            iconColor: profileCardList[index].iconColor);
                      })),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileCard(
      {required IconData icon,
      required String title,
      required bool hasArrow,
      required Color iconColor}) {
    return Padding(
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
            child: Text(title),
          ),
          hasArrow
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              : Container()
        ],
      ),
    );
  }
}
