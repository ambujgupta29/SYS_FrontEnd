import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic arguments;
  const ProductDetailScreen({super.key, this.arguments});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProfileBloc? _profileBloc;
  StreamSubscription<ProfileState>? _subscription;
  List<String>? favlist;
  List<String>? images;

  @override
  void initState() {
    // TODO: implement initState
    _profileBloc = BlocProvider.of(context);
    _profileBloc?.add(GetFavListEvent());
    _subscription = _profileBloc?.stream.listen(userInfoListener);
    print(json.encode(widget.arguments['productModel'].sId));
    // _productsBloc?.add(FetchMultipleImagesEvent(
    //     fileName: widget.arguments['productModel'].images));

    super.initState();
  }

  Future<void> userInfoListener(state) async {
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
          favlist = state.fetchFavListModel.favourites;
          print('xxxx${favlist}');
        });
      }
    } else if (state is GetFavListFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is GetFavListProgressState) {
      startLoader(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              right: 30.0, left: 30.0, top: 25, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: [
                          FlutterCarousel(
                            items: (widget.arguments['productModel'].images
                                        as List<String> ??
                                    [])
                                .map(
                                  (e) => Builder(builder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        child:
                                            Image.network(e, fit: BoxFit.cover),
                                      ),
                                    );
                                  }),
                                )
                                .toList(),
                            options: CarouselOptions(
                              height: 400.0,
                              showIndicator: true,
                              viewportFraction: 1.0,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              slideIndicator: CircularSlideIndicator(),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 12,
                            child: GestureDetector(
                              onTap: () {
                                if ((favlist ?? []).contains(
                                    widget.arguments['productModel'].sId)) {
                                  _profileBloc?.add(RemoveItemFromFavEvent(
                                      productId: widget
                                              .arguments['productModel'].sId ??
                                          ''));
                                } else {
                                  _profileBloc?.add(AddItemToFavEvent(
                                      productId: widget
                                              .arguments['productModel'].sId ??
                                          ''));
                                }
                              },
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: ((favlist ?? []).contains(
                                        widget.arguments['productModel'].sId))
                                    ? AppImages.isFavouriteBlack(context,
                                        height: 25)
                                    : AppImages.isNotFavouriteBlack(context,
                                        height: 25),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12,
                            top: 12,
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
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget
                                        .arguments['productModel'].productName,
                                    style: GoogleFonts.encodeSans(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ).copyWith(color: Color(0xff1B2028)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xffEAEAEA),
                                        radius: 22,
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: AppImages.minus(context,
                                                height: 25)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "1",
                                        style: GoogleFonts.encodeSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ).copyWith(color: Color(0xff1B2028)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xffEAEAEA),
                                        radius: 22,
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: AppImages.add(context,
                                                height: 25)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: SizedBox(
                                          height: 30,
                                          width: 20,
                                          child: AppImages.rating(context)),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3.0, right: 3),
                                child: Text(
                                  "5.0",
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ).copyWith(color: Color(0xff878787)),
                                ),
                              ),
                              Text(
                                "(7.932 reviews)",
                                style: GoogleFonts.encodeSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ).copyWith(color: Color(0xff347EFB)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child:
                                      AppImages.profileSelectedBlack(context),
                                ),
                                Text(
                                  widget
                                      .arguments['productModel'].user.userName,
                                  style: GoogleFonts.encodeSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ).copyWith(color: Color(0xff878787)),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Padding(
                                padding: EdgeInsets.only(top: 6.0),
                                child: SingleChildScrollView(
                                  child: ReadMoreText(
                                    widget
                                        .arguments['productModel'].productDesc,
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    style: GoogleFonts.encodeSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ).copyWith(color: Color(0xff878787)),
                                    colorClickableText: Colors.black,
                                    trimCollapsedText: 'Read more',
                                    trimExpandedText: 'Read less',
                                    moreStyle: GoogleFonts.encodeSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ).copyWith(color: Color(0xff1B2028)),
                                  ),
                                )

                                // Text(
                                //   "Its simple and elegant shape makes it perfect for those of you who like you who want minimalistclothes",
                                //   style: GoogleFonts.encodeSans(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w400,
                                //   ).copyWith(color: Color(0xff878787)),
                                // ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 22),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Color(0xff292526),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: AppImages.cartUnselected(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Add to Cart | ₹ ${widget.arguments['productModel'].productPrice}",
                          style: GoogleFonts.encodeSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
