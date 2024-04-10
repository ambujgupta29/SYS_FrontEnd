import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';
import 'package:sys_mobile/bloc/login/product/product_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/models/products/fetch_product_model.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';
import 'package:sys_mobile/ui/utils/store/app_storage.dart';
import 'package:sys_mobile/ui/utils/store/storage_constants.dart';

class HomeScreen extends StatefulWidget {
  final dynamic arguments;
  const HomeScreen({super.key, this.arguments});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductsBloc? _productsBloc;
  Map<String, dynamic>? decodedToken;
  String? imageurl;
  @override
  void initState() {
    // TODO: implement initState
    _productsBloc = BlocProvider.of(context);
    _productsBloc?.add(FetchAllProductsEvent());
    decodedToken = JwtDecoder.decode(AppStorage().getString(USER_TOKEN));
    print(decodedToken);
    super.initState();
  }

  bool isItemAddedtoWishlist = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
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
                              decodedToken?['fullname']??'NA',
                              style: GoogleFonts.encodeSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ).copyWith(color: Color(0xff1B2028)),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 27,
                        child: Image.asset('lib/assets/images/model.png',
                            fit: BoxFit.cover),
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
                      Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0XFF292526),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          child: AppImages.filter(context, height: 25)),
                    ],
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
                        return
                            // Container(
                            //   child: Text(json.encode(state.fetchProductModel)),
                            // );
                            StaggeredGridView.countBuilder(
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
                            imageurl = state.fetchProductModel
                                .productList?[index].images?[0];
                            _productsBloc?.add(
                                FetchImageEvent(fileName: imageurl ?? ''));
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/product-detail', arguments: {
                                  "productModel": state
                                      .fetchProductModel.productList?[index]
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocBuilder<ProductsBloc, ProductState>(
                                      buildWhen: (ProductState prevState,
                                          ProductState currentState) {
                                        return currentState
                                                is FetchImageSuccessState ||
                                            currentState
                                                is FetchImageFailedState ||
                                            currentState
                                                is FetchImageProgressState;
                                      },
                                      builder: (context, state) {
                                        if (state is FetchImageSuccessState) {
                                          return Expanded(
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Positioned.fill(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(14),
                                                    ),
                                                    child: Image.network(
                                                        state.fetchImageModel
                                                                .files?.url ??
                                                            '',
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 12,
                                                  top: 12,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (isItemAddedtoWishlist) {
                                                          isItemAddedtoWishlist =
                                                              false;
                                                        } else {
                                                          isItemAddedtoWishlist =
                                                              true;
                                                        }
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                        radius: 13,
                                                        backgroundColor:
                                                            Color(0xff292526),
                                                        child: !isItemAddedtoWishlist
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
                                          );

                                          // Container(
                                          //   child: Text(json.encode(state.fetchProductModel)),
                                          // );
                                        } else if (state
                                            is FetchImageFailedState) {
                                          return Container(
                                            child: Text(state.message),
                                          );
                                        } else if (state
                                            is FetchImageProgressState) {
                                          return CircularProgressIndicator();
                                        } else {
                                          return Container(
                                            child: Text("hello"),
                                          );
                                        }
                                      },
                                    ),

                                    // Expanded(
                                    //   child: Stack(
                                    //     alignment: Alignment.topRight,
                                    //     children: [
                                    //       Positioned.fill(
                                    //         child: ClipRRect(
                                    //           borderRadius: BorderRadius.all(
                                    //             Radius.circular(14),
                                    //           ),
                                    //           child: Image.asset(
                                    //               'lib/assets/images/model.png',
                                    //               fit: BoxFit.cover),
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //         right: 12,
                                    //         top: 12,
                                    //         child: GestureDetector(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               if (isItemAddedtoWishlist) {
                                    //                 isItemAddedtoWishlist =
                                    //                     false;
                                    //               } else {
                                    //                 isItemAddedtoWishlist =
                                    //                     true;
                                    //               }
                                    //             });
                                    //           },
                                    //           child: CircleAvatar(
                                    //               radius: 13,
                                    //               backgroundColor:
                                    //                   Color(0xff292526),
                                    //               child: !isItemAddedtoWishlist
                                    //                   ? AppImages
                                    //                       .isNotFavourite(
                                    //                           context)
                                    //                   : AppImages.isFavourite(
                                    //                       context)),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Text(
                                        state
                                                .fetchProductModel
                                                .productList?[index]
                                                .productName ??
                                            "",
                                        style: GoogleFonts.encodeSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ).copyWith(color: Color(0xff1B2028)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        state
                                                .fetchProductModel
                                                .productList?[index]
                                                .productDesc ??
                                            "",
                                        style: GoogleFonts.encodeSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ).copyWith(color: Color(0xffA4AAAD)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          (state
                                                      .fetchProductModel
                                                      .productList?[index]
                                                      .productPrice ??
                                                  0)
                                              .toString(),
                                          style: GoogleFonts.encodeSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ).copyWith(color: Color(0xff1B2028)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Row(
                                            children: [
                                              AppImages.rating(context),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    7, 0, 0, 0),
                                                child: Text(
                                                  "5.0",
                                                  style: GoogleFonts.encodeSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ).copyWith(
                                                      color: Color(0xff1B2028)),
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
                        );
                      } else if (state is FetchAllProductFailedState) {
                        stopLoader(context);
                        return Container(
                          child: Text(state.message),
                        );
                      } else if (state is FetchAllProductProgressState) {
                        startLoader(context);
                        return Container();
                      } else {
                        return Container(
                          child: Text("hello"),
                        );
                      }
                    },
                  ),

                  // StaggeredGridView.countBuilder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   staggeredTileBuilder: (index) {
                  //     return StaggeredTile.count(1, (index == 0) ? 1.9 : 2.1);
                  //   },
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 20.0,
                  //   crossAxisSpacing: 20.0,
                  //   itemCount: 6,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return itemCard();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ));
  }

  // Widget itemCard({ProductList? productList}) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.of(context).pushNamed('/product-detail');
  //     },
  //     child: Container(
  //       color: Colors.white,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           Expanded(
  //             child: Stack(
  //               alignment: Alignment.topRight,
  //               children: [
  //                 Positioned.fill(
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(14),
  //                     ),
  //                     child: Image.asset('lib/assets/images/model.png',
  //                         fit: BoxFit.cover),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   right: 12,
  //                   top: 12,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         if (isItemAddedtoWishlist) {
  //                           isItemAddedtoWishlist = false;
  //                         } else {
  //                           isItemAddedtoWishlist = true;
  //                         }
  //                       });
  //                     },
  //                     child: CircleAvatar(
  //                         radius: 13,
  //                         backgroundColor: Color(0xff292526),
  //                         child: !isItemAddedtoWishlist
  //                             ? AppImages.isNotFavourite(context)
  //                             : AppImages.isFavourite(context)),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
  //             child: Text(
  //               productList?.productName ?? "",
  //               style: GoogleFonts.encodeSans(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ).copyWith(color: Color(0xff1B2028)),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
  //             child: Text(
  //               productList?.productDesc ?? "",
  //               style: GoogleFonts.encodeSans(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w400,
  //               ).copyWith(color: Color(0xffA4AAAD)),
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 (productList?.productPrice ?? 0).toString(),
  //                 style: GoogleFonts.encodeSans(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                 ).copyWith(color: Color(0xff1B2028)),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(right: 20.0),
  //                 child: Row(
  //                   children: [
  //                     AppImages.rating(context),
  //                     Padding(
  //                       padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
  //                       child: Text(
  //                         "5.0",
  //                         style: GoogleFonts.encodeSans(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w400,
  //                         ).copyWith(color: Color(0xff1B2028)),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
