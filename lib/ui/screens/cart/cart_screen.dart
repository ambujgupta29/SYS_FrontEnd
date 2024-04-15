import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';
import 'package:sys_mobile/bloc/login/product/product_state.dart';
import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/models/products/fetch_product_id_model.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  ProductsBloc? _productsBloc;
  ProfileBloc? _profileBloc;
  StreamSubscription<ProfileState>? _subscription;
  List<String>? cartlist;
  @override
  void dispose() {
    // TODO: implement dispose
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _productsBloc = BlocProvider.of(context);
    _profileBloc = BlocProvider.of(context);
    _profileBloc?.add(GetUserInfoEvent());
    _profileBloc?.add(GetFavListEvent());
    _subscription = _profileBloc?.stream.listen(userInfoListener);
    super.initState();
  }

  Future<void> userInfoListener(state) async {
    if (state is GetUserInfoSuccessState) {
      stopLoader(context);
      _productsBloc?.add(FetchProductByIDEvent(
          productIdList: state.fetchUserInfoModel.cart ?? []));
    } else if (state is GetUserInfoFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is GetUserInfoProgressState) {
      startLoader(context);
    }
    if (state is AddItemToFavSuccessState) {
      stopLoader(context);
      _profileBloc?.add(GetFavListEvent());
      print(state.fetchUserInfoModel);
    } else if (state is AddItemToFavFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is AddItemToFavProgressState) {
      startLoader(context);
    } else if (state is RemoveItemFromFavSuccessState) {
      stopLoader(context);
      _profileBloc?.add(GetFavListEvent());
    } else if (state is RemoveItemFromFavFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is RemoveItemFromFavProgressState) {
      startLoader(context);
    } else if (state is GetFavListSuccessState) {
      stopLoader(context);
      if (mounted) {
        setState(() {
          cartlist = state.fetchFavListModel.cart;
          print('zzzzz${cartlist}');
        });
      }
      _profileBloc?.add(GetUserInfoEvent());
    } else if (state is GetFavListFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is GetFavListProgressState) {
      startLoader(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        _profileBloc?.add(GetUserInfoEvent());
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: AppImages.back(context, height: 45)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        "Checkout",
                        style: GoogleFonts.encodeSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ).copyWith(color: Color(0xff1B2028)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            BlocBuilder<ProductsBloc, ProductState>(
              buildWhen: (ProductState prevState, ProductState currentState) {
                return currentState is FetchProductByIDSuccessState ||
                    currentState is FetchProductByIDFailedState ||
                    currentState is FetchProductByIDProgressState;
              },
              builder: (context, state) {
                if (state is FetchProductByIDSuccessState) {
                  Map<String, List<Value>> userProductNames = {};

                  ((state.fetchProductModel.productList) ?? []).forEach(
                    (e) {
                      String userID = e.value?.user?.sId ?? '';
                      Value val = e.value ?? Value();
                      userProductNames.putIfAbsent(userID, () => []);
                      userProductNames[userID]?.add(val);
                    },
                  );
                  print("Userssssss:${json.encode(userProductNames)} ");
                  List<MapEntry<String, List<Value>>> userProductNamesList =
                      userProductNames.entries.toList();

                  stopLoader(context);
                  return Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return userProductCard(
                            valuelist: userProductNamesList[index].value,
                          );
                        },
                        itemCount: userProductNames.keys.length),
                  );
                } else if (state is FetchProductByIDFailedState) {
                  stopLoader(context);
                  return Expanded(
                    child: Center(
                      child: Container(
                        child: Text(
                          state.message,
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(
                            color: Color(0xff1B2028),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is FetchProductByIDProgressState) {
                  startLoader(context);
                  return Container();
                } else {
                  return Flexible(
                    child: Center(
                      child: Container(
                        child: Text(
                          "No items found",
                          style: GoogleFonts.encodeSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(
                            color: Color(0xff1B2028),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        )),
      ),
    );
  }

  Widget userProductCard({List<Value>? valuelist}) {
    double sum = 0;
    (valuelist ?? [])
        .forEach((e) => sum += double.parse(e.productPrice ?? '0'));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            child: Container(
                              height: 80,
                              width: 80,
                              child: CachedNetworkImage(
                                  imageUrl: valuelist?[index].images?[0] ?? '',
                                  placeholder: (context, url) =>
                                      Icon(Icons.wallpaper_outlined),
                                  errorWidget: (context, url, error) => Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (valuelist?[index].productName)
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.encodeSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ).copyWith(color: Color(0xff1B2028)),
                                    ),
                                    Text(
                                      (valuelist?[index].productCategory)
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.encodeSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ).copyWith(color: Color(0xff1B2028)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  ("₹ ${valuelist?[index].productPrice}")
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ).copyWith(color: Color(0xff1B2028)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.more_horiz_sharp)
                        ],
                      ),
                    );
                  },
                  itemCount: valuelist?.length ?? 0,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      indent: 15,
                      endIndent: 15,
                    );
                  },
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: Color(0xFF292526),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Row(
                          children: [
                            Text(
                              "Total:",
                              style: GoogleFonts.encodeSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ).copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              "₹ ${sum.toStringAsFixed(2)}",
                              style: GoogleFonts.encodeSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ).copyWith(color: Colors.white),
                            )),
                          ],
                        )),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            print(valuelist![0].user?.mobileNumber ?? '');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5000))),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Color(0xff1B2028),
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Call Now",
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ).copyWith(color: Color(0xff1B2028)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 40,
            top: 2,
            child: Container(
              color: Colors.white,
              child: Text(
                valuelist![0].user?.userName ?? '',
                style: GoogleFonts.encodeSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ).copyWith(color: Color(0xff1B2028)),
              ),
            ),
          ),
          // Positioned(
          //     right: 60,
          //     child: CircleAvatar(
          //         backgroundColor: Colors.black,
          //         child: Icon(
          //           Icons.call,
          //           color: Colors.white,
          //         )))
        ],
      ),
    );
  }
}
