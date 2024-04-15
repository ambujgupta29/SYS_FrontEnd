import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';

import 'package:sys_mobile/bloc/login/product/product_state.dart';
import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_event.dart';
import 'package:sys_mobile/bloc/profile/profile_state.dart';

import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';

class LikesScreen extends StatefulWidget {
  final dynamic arguments;
  const LikesScreen({super.key, this.arguments});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  ProductsBloc? _productsBloc;
  ProfileBloc? _profileBloc;
  StreamSubscription<ProfileState>? _subscription;
  List<String>? favlist;

  String? imageurl;
  @override
  void initState() {
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
          productIdList: state.fetchUserInfoModel.favourites ?? []));
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
          favlist = state.fetchFavListModel.favourites;
          print('xxxx${favlist}');
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
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  bool isItemAddedtoWishlist = false;
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        _profileBloc?.add(GetUserInfoEvent());
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
                          Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Text(
                              'Favourites',
                              style: GoogleFonts.encodeSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ).copyWith(color: Color(0xff1B2028)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<ProductsBloc, ProductState>(
                    buildWhen:
                        (ProductState prevState, ProductState currentState) {
                      return currentState is FetchProductByIDSuccessState ||
                          currentState is FetchProductByIDFailedState ||
                          currentState is FetchProductByIDProgressState;
                    },
                    builder: (context, state) {
                      if (state is FetchProductByIDSuccessState) {
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
              ),
            ),
          )),
    );
  }
}
