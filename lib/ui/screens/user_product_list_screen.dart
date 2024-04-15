import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';
import 'package:sys_mobile/bloc/login/product/product_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';

class UserProductListScreen extends StatefulWidget {
  final dynamic arguments;
  const UserProductListScreen({super.key, this.arguments});

  @override
  State<UserProductListScreen> createState() => _UserProductListScreenState();
}

class _UserProductListScreenState extends State<UserProductListScreen> {
  ProductsBloc? _productsBloc;
  @override
  void initState() {
    // TODO: implement initState
    _productsBloc = BlocProvider.of(context);
    _productsBloc?.add(FetchUserProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "My Listings",
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
                  )
                ],
              ),
            ),
           
            Flexible(
              child: BlocBuilder<ProductsBloc, ProductState>(
                buildWhen: (ProductState prevState, ProductState currentState) {
                  return currentState is FetchUserProductsSuccessState ||
                      currentState is FetchUserProductsFailedState ||
                      currentState is FetchUserProductsProgressState;
                },
                builder: (context, state) {
                  if (state is FetchUserProductsSuccessState) {
                    stopLoader(context);
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20),
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.fetchProductModel.productList?.length ??
                          0, // Number of items in the list
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          indent: 15,
                          endIndent: 15,
                        ); // Separator widget between items
                      },
                      itemBuilder: (BuildContext context, int index) {
                        // Builder function for each item in the list
                        return userProductCard(
                          productName: state.fetchProductModel
                              .productList![index].value?.productName,
                          productCategory: state.fetchProductModel
                              .productList![index].value?.productCategory,
                          productImage: state.fetchProductModel
                              .productList![index].value?.images?[0],
                          productPrice: state.fetchProductModel
                              .productList![index].value?.productPrice,
                        );
                      },
                    );
                  } else if (state is FetchUserProductsFailedState) {
                    stopLoader(context);
                    return Center(
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
                    );
                  } else if (state is FetchUserProductsProgressState) {
                    startLoader(context);
                    return Container();
                  } else {
                    return Container(
                      child: Text(
                        "No items found",
                        style: GoogleFonts.encodeSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ).copyWith(
                          color: Color(0xff1B2028),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userProductCard(
      {String? productName,
      String? productCategory,
      String? productImage,
      String? productPrice}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            child: Container(
              height: 100,
              width: 100,
              child: CachedNetworkImage(
                  imageUrl: productImage ?? '',
                  placeholder: (context, url) => Icon(Icons.wallpaper_outlined),
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
                      (productName).toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.encodeSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ).copyWith(color: Color(0xff1B2028)),
                    ),
                    Text(
                      (productCategory).toString(),
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
                  ("₹ ${productPrice}").toString(),
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
  }

}
