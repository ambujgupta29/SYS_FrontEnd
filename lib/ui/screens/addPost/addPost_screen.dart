import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/login/product/product_event.dart';
import 'package:sys_mobile/bloc/login/product/product_state.dart';
import 'package:sys_mobile/common/loader_control.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';
import 'package:sys_mobile/ui/utils/widgets.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  ProductsBloc? _productsBloc;
  TextEditingController productName = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  String selectedValue = 'Option 1';
  List<String> images = [
    'lib/assets/images/add.svg',
  ];

  @override
  void initState() {
    // TODO: implement initState
    _productsBloc = BlocProvider.of(context);
    _productsBloc?.stream.listen(addPostListener);
    super.initState();
  }

  Future<void> addPostListener(state) async {
    if (state is PostProductSuccessState) {
      stopLoader(context);
      return showPostStatusCard(
          context: context,
          icon: Icons.check,
          title: 'Congratulations!',
          iconColor: Color(0xff4CBB17),
          body: '${productName.text} listed successfully');
    } else if (state is PostProductFailedState) {
      stopLoader(context);
      showPostStatusCard(
          context: context,
          icon: Icons.close,
          title: 'Sorry!',
          iconColor: Colors.red.shade400,
          body: state.message);
      print(state.message);
    } else if (state is PostProductProgressState) {
      startLoader(context);
    } else if (state is ProductFailedState) {
      print("failed");
      stopLoader(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 25),
            child: Column(
              children: [
                FlutterCarousel(
                  items: (images ?? [])
                      .map(
                        (e) => Builder(builder: (context) {
                          return (e.compareTo('lib/assets/images/add.svg') != 0)
                              ? Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      height: 400,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        child: Image.file(File(e),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Positioned(
                                        right: 12,
                                        top: 12,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              images.remove(e);
                                            });
                                          },
                                          child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor: Colors.white,
                                              child:
                                                  Icon(Icons.close, size: 30)),
                                        ))
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: true,
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg', 'jpeg', 'png'],
                                    );

                                    if (result != null) {
                                      List<String> files = result.paths
                                          .map((path) => (path!))
                                          .toList();
                                      setState(() {
                                        images = [
                                          ...images.sublist(
                                              0, images.length - 1),
                                          ...files,
                                          'lib/assets/images/add.svg'
                                        ];
                                        // images.addAll(files);
                                      });
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                        )),
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(130),
                                        child: SvgPicture.asset(
                                          e,
                                        ),
                                      ),
                                    ),
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
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    slideIndicator: CircularSlideIndicator(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: productName,
                  decoration: InputDecoration(
                    hintText: 'Enter product name',
                    contentPadding: EdgeInsets.all(15),
                    label: Text("Product Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius here
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: productDesc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    // isDense: true,
                    hintText: 'Enter product Description',

                    label: Text("Product Description"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius here
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: TextField(
                          controller: productPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter product price',
                            contentPadding: EdgeInsets.all(15),
                            label: Text("Product price"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius here
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          value: selectedValue,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: <String>[
                            'Option 1',
                            'Option 2',
                            'Option 3',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Button(
                    text: "Post",
                    onTap: () {
                      _productsBloc?.add(PostProductEvent(
                          productName: productName.text,
                          productDesc: productDesc.text,
                          productPrice: productPrice.text,
                          productCategory: selectedValue,
                          images: images.sublist(0, images.length - 1)));
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void showPostStatusCard(
  //     {required BuildContext context,
  //     required IconData icon,
  //     required String body,
  //     required Color iconColor,
  //     required String title}) {
  //   // Show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         title: Text(
  //           title,
  //           style: GoogleFonts.encodeSans(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ).copyWith(color: Color(0xff1B2028)),
  //         ),
  //         content: Text(
  //           textAlign: TextAlign.center,
  //           body,
  //           style: GoogleFonts.encodeSans(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w500,
  //           ).copyWith(color: Color(0xff1B2028)),
  //         ),
  //         icon: CircleAvatar(
  //           backgroundColor: iconColor.withOpacity(0.3),
  //           child: Icon(
  //             icon,
  //             color: iconColor,
  //           ),
  //         ),
  //         // actions: <Widget>[
  //         //   Center(
  //         //     child: TextButton(
  //         //       onPressed: () {
  //         //         Navigator.of(context).pop();
  //         //       },
  //         //       child: Text('Ok',
  //         //           style: GoogleFonts.encodeSans(
  //         //             fontSize: 14,
  //         //             fontWeight: FontWeight.w500,
  //         //           )
  //         //           // .copyWith(
  //         //           //   color: Color(0xff1B2028),
  //         //           // ),
  //         //           ),
  //         //     ),
  //         //   ),
  //         // ],
  //       );
  //     },
  //   );
  // }

}
