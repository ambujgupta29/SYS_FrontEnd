import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';
import 'package:sys_mobile/bloc/login/product/product_state.dart';
import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';

import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';

class HorizontalItem {
  IconData? icon;
  String? title;

  HorizontalItem(this.icon, this.title) {}
}

class HomeScreen extends StatefulWidget {
  final dynamic arguments;
  const HomeScreen({super.key, this.arguments});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HorizontalItem> hItem = [
    HorizontalItem(Icons.grid_view_outlined, "All"),
    HorizontalItem(Icons.phone_android_outlined, "Electronics"),
    HorizontalItem(Icons.directions_car_outlined, "Vehicles"),
    HorizontalItem(Icons.bed_outlined, "Furniture"),
    HorizontalItem(Icons.local_mall_outlined, "Beauty"),
    HorizontalItem(Icons.auto_stories_outlined, "Books"),
    HorizontalItem(Icons.draw_outlined, "Stationery"),
    HorizontalItem(Icons.sports_volleyball_outlined, "Sports"),
    HorizontalItem(Icons.miscellaneous_services_outlined, "Misc"),
  ];
  ProductsBloc? _productsBloc;
  ProfileBloc? _profileBloc;
  Map<String, dynamic>? decodedToken;
  String? imageurl;
  Timer? _debounceTimer;
  StreamSubscription<ProfileState>? _subscriptionProfile;
  StreamSubscription<ProductState>? _subscriptionProduct;
  List<String>? favlist;
  String textValue = '';
  double maxPrice = 0.0;
  double maxSliderprice = 0.0;
  double minPrice = 0.0;
  String selectedTitle = "All";

  @override
  void initState() {
    _productsBloc = BlocProvider.of(context);
    _profileBloc = BlocProvider.of(context);
    _subscriptionProfile = _profileBloc?.stream.listen(favListener);
    _productsBloc?.add(GetMaxPriceEvent());
    _subscriptionProduct = _productsBloc?.stream.listen(maxPriceListener);

    _profileBloc?.add(GetProfilePictureEvent());
    _profileBloc?.add(GetFavListEvent());

    decodedToken = JwtDecoder.decode(AppStorage().getString(USER_TOKEN));
    print(decodedToken);
    super.initState();
  }

  Future<void> favListener(state) async {
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

  Future<void> maxPriceListener(state) async {
    if (state is GetMaxPriceSuccessState) {
      stopLoader(context);
      maxPrice = double.parse(state.maxPrice);
      maxSliderprice = double.parse(state.maxPrice);
      _productsBloc?.add(FetchAllProductsEvent(
          productName: '',
          productCategory: '',
          minValue: minPrice,
          maxValue: maxPrice));
    } else if (state is GetMaxPriceFailedState) {
      stopLoader(context);
      print(state.message);
    } else if (state is GetMaxPriceProgressState) {
      startLoader(context);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _subscriptionProfile?.cancel();
    _subscriptionProduct?.cancel();
    super.dispose();
  }

  bool isItemAddedtoWishlist = false;
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        _profileBloc?.add(GetFavListEvent());
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,Welcome 👋",
                            style: GoogleFonts.encodeSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ).copyWith(color: Color(0xff1B2028)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Text(
                              decodedToken?['fullname'] ?? 'NA',
                              style: GoogleFonts.encodeSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ).copyWith(color: Color(0xff1B2028)),
                            ),
                          ),
                        ],
                      ),
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
                            return ClipOval(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF292526),
                                radius: 27,
                                child: (state.fetchProfilePictureModel.url !=
                                            null &&
                                        state.fetchProfilePictureModel.url !=
                                            '')
                                    ? CachedNetworkImage(
                                        imageUrl: state
                                                .fetchProfilePictureModel.url ??
                                            '',
                                        placeholder: (context, url) =>
                                            Icon(Icons.wallpaper_outlined),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                        fit: BoxFit.cover)
                                    : Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                // Image.asset(
                                //     'lib/assets/images/model.png',
                                //     fit: BoxFit.cover,
                                //   ),
                              ),
                            );
                          } else if (state is GetProfilePictureFailedState) {
                            return ClipOval(
                              child: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Color(0xFF292526),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            );
                          } else if (state is GetProfilePictureProgressState) {
                            return Container();
                          } else {
                            return ClipOval(
                              child: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Color(0xFF292526),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the border radius as needed
                            border: Border.all(
                              color: Color(0XFFEDEDED),
                              width: 1.0,
                            ),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              _debounceTimer?.cancel();
                              _debounceTimer = Timer(
                                  const Duration(milliseconds: 1500), () async {
                                textValue = value;
                                _productsBloc?.add(FetchAllProductsEvent(
                                    minValue: minPrice,
                                    maxValue: maxPrice,
                                    productName: value,
                                    productCategory: (selectedTitle == 'All')
                                        ? ''
                                        : selectedTitle));
                              });
                            },
                            decoration: InputDecoration(
                              icon: AppImages.search(context),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              hintText: 'Search',
                              hintStyle: GoogleFonts.encodeSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ).copyWith(color: Color(0xff878787)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                RangeValues _currentRangeValues =
                                    RangeValues(minPrice, maxPrice);
                                return StatefulBuilder(
                                  builder: (BuildContext myContext,
                                      void Function(void Function())
                                          mySetState) {
                                    return Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Price range filter",
                                              style: GoogleFonts.encodeSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ).copyWith(
                                                  color: Color(0xff1B2028)),
                                            ),
                                            SliderTheme(
                                              data: SliderTheme.of(myContext)
                                                  .copyWith(
                                                activeTrackColor:
                                                    Colors.black87,
                                                inactiveTrackColor:
                                                    Colors.black26,
                                                trackShape:
                                                    RoundedRectSliderTrackShape(),
                                                trackHeight: 4.0,
                                                thumbColor: Colors.black,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius:
                                                            12.0),
                                                overlayColor:
                                                    Colors.black.withAlpha(32),
                                                overlayShape:
                                                    RoundSliderOverlayShape(
                                                        overlayRadius: 28.0),
                                              ),
                                              child: RangeSlider(
                                                values: _currentRangeValues,
                                                max: maxSliderprice,
                                                divisions: null,
                                                // (double.parse(state.maxPrice) * 100).toInt(),

                                                // labels: RangeLabels(
                                                //   _currentRangeValues.start
                                                //       .round()
                                                //       .toString(),
                                                //   _currentRangeValues.end
                                                //       .round()
                                                //       .toString(),
                                                // ),
                                                onChanged:
                                                    (RangeValues values) {
                                                  mySetState(() {
                                                    _currentRangeValues =
                                                        values;
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    _currentRangeValues.start
                                                        .toStringAsFixed(2),
                                                    style:
                                                        GoogleFonts.encodeSans(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ).copyWith(
                                                            color: Color(
                                                                0xff1B2028)),
                                                  ),
                                                  Text(
                                                    _currentRangeValues.end
                                                        .toStringAsFixed(2),
                                                    style:
                                                        GoogleFonts.encodeSans(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ).copyWith(
                                                            color: Color(
                                                                0xff1B2028)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (mounted) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      minPrice =
                                                          _currentRangeValues
                                                              .start;
                                                      maxPrice =
                                                          _currentRangeValues
                                                              .end;
                                                    });
                                                    _productsBloc?.add(
                                                        FetchAllProductsEvent(
                                                            productName:
                                                                textValue,
                                                            productCategory:
                                                                (selectedTitle ==
                                                                        'All')
                                                                    ? ''
                                                                    : selectedTitle,
                                                            minValue: minPrice,
                                                            maxValue:
                                                                maxPrice));
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff1B2028),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 15.0),
                                                    child: Text(
                                                      "Set",
                                                      style: GoogleFonts
                                                          .encodeSans(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ).copyWith(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color(0XFF292526),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: AppImages.filter(context, height: 25)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 36,
                    child: ListView.builder(
                      itemCount: hItem.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 10,
                          child: horizontalListCard(
                              icon: hItem[index].icon!,
                              title: hItem[index].title!),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<ProductsBloc, ProductState>(
                    buildWhen:
                        (ProductState prevState, ProductState currentState) {
                      return currentState is FetchAllProductSuccessState ||
                          currentState is FetchAllProductFailedState ||
                          currentState is FetchAllProductProgressState;
                    },
                    builder: (context, state) {
                      if (state is FetchAllProductSuccessState) {
                        stopLoader(context);
                        return Flexible(
                          child: SingleChildScrollView(
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(
                                    1, (index == 0) ? 1.9 : 2.1);
                              },
                              crossAxisCount: 2,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              itemCount:
                                  state.fetchProductModel.productList?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/product-detail',
                                        arguments: {
                                          "productModel": state
                                              .fetchProductModel
                                              .productList?[index]
                                              .value
                                        });
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Positioned.fill(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(14),
                                                  ),
                                                  child: CachedNetworkImage(
                                                      imageUrl: state
                                                              .fetchProductModel
                                                              .productList![
                                                                  index]
                                                              .value
                                                              ?.images?[0] ??
                                                          '',
                                                      placeholder: (context,
                                                              url) =>
                                                          Icon(Icons
                                                              .wallpaper_outlined),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                            Icons.error,
                                                            color: Colors.red,
                                                          ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Positioned(
                                                right: 12,
                                                top: 12,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if ((favlist ?? [])
                                                        .contains(state
                                                            .fetchProductModel
                                                            .productList![index]
                                                            .value
                                                            ?.sId)) {
                                                      _profileBloc?.add(
                                                          RemoveItemFromFavEvent(
                                                              productId: state
                                                                      .fetchProductModel
                                                                      .productList![
                                                                          index]
                                                                      .value
                                                                      ?.sId ??
                                                                  ''));
                                                    } else {
                                                      _profileBloc?.add(
                                                          AddItemToFavEvent(
                                                              productId: state
                                                                      .fetchProductModel
                                                                      .productList![
                                                                          index]
                                                                      .value
                                                                      ?.sId ??
                                                                  ''));
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 13,
                                                      backgroundColor:
                                                          Color(0xff292526),
                                                      child: (!(favlist ?? [])
                                                              .contains(state
                                                                  .fetchProductModel
                                                                  .productList![
                                                                      index]
                                                                  .value
                                                                  ?.sId))
                                                          ? AppImages
                                                              .isNotFavourite(
                                                                  context)
                                                          : AppImages
                                                              .isFavourite(
                                                                  context)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 8, 0, 8),
                                          child: Text(
                                            state
                                                    .fetchProductModel
                                                    .productList?[index]
                                                    .value
                                                    ?.productName ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.encodeSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ).copyWith(
                                                color: Color(0xff1B2028)),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 8),
                                          child: Text(
                                            state
                                                    .fetchProductModel
                                                    .productList?[index]
                                                    .value
                                                    ?.productDesc ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.encodeSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ).copyWith(
                                                color: Color(0xffA4AAAD)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              ('₹ ${state.fetchProductModel.productList?[index].value?.productPrice ?? 0}')
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.encodeSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ).copyWith(
                                                  color: Color(0xff1B2028)),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.0),
                                              child: Row(
                                                children: [
                                                  AppImages.rating(context),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            7, 0, 0, 0),
                                                    child: Text(
                                                      "5.0",
                                                      style: GoogleFonts
                                                          .encodeSans(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ).copyWith(
                                                        color:
                                                            Color(0xff1B2028),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else if (state is FetchAllProductFailedState) {
                        stopLoader(context);
                        return Expanded(
                          child: Center(
                            child: Container(
                              child: Text(
                                textAlign: TextAlign.center,
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
                      } else if (state is FetchAllProductProgressState) {
                        startLoader(context);
                        return Container();
                      } else {
                        return Expanded(
                          child: Center(
                            child: Container(
                              child: Text(
                                textAlign: TextAlign.center,
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
              ),
            ),
          )),
    );
  }

  Widget horizontalListCard({required IconData icon, required String title}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTitle = title;
        });

        _productsBloc?.add(FetchAllProductsEvent(
            minValue: minPrice,
            maxValue: maxPrice,
            productName: textValue,
            productCategory: (title == 'All') ? '' : title));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: (selectedTitle == title) ? Color(0xff1B2028) : Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(color: Color(0xffEDEDED))),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color:
                    (selectedTitle == title) ? Colors.white : Color(0xff1B2028),
                size: 16,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.encodeSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ).copyWith(
                color:
                    (selectedTitle == title) ? Colors.white : Color(0xff1B2028),
              ),
            )
          ],
        ),
      ),
    );
  }
}
