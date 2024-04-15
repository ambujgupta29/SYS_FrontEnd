import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sys_mobile/bloc/login/product/product_bloc.dart';
import 'package:sys_mobile/bloc/profile/profile_bloc.dart';
import 'package:sys_mobile/ui/screens/addPost/addPost_screen.dart';
import 'package:sys_mobile/ui/screens/cart/cart_screen.dart';
import 'package:sys_mobile/ui/screens/home/home_screen.dart';
import 'package:sys_mobile/ui/screens/likes/likes_screen.dart';
import 'package:sys_mobile/ui/screens/profile/profile_screen.dart';
import 'package:sys_mobile/ui/utils/app_images.dart';

class BottomNavBarScreen extends StatefulWidget {
  final dynamic arguments;
  const BottomNavBarScreen({super.key, this.arguments});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  // Define the widgets for each tab
  final List<Widget> _tabs = [
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: LikesScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: AddPostScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: Cartscreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: ProfileScreen(),
    ),
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _tabs[_selectedIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color(0xFF292526),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedLabelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 27,
                width: 27,
                child: (_selectedIndex == 0)
                    ? AppImages.homeSelected(context)
                    : AppImages.homeUnselected(context),
              ),
              label: '•',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 27,
                width: 27,
                child: (_selectedIndex == 1)
                    ? AppImages.likesSelected(context)
                    : AppImages.likesUnselected(context),
              ),
              label: '•',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 32,
                width: 32,
                child: (_selectedIndex == 2)
                    ? AppImages.addSelected(context)
                    : AppImages.addUnselected(context),
              ),
              label: '•',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 27,
                width: 27,
                child: (_selectedIndex == 3)
                    ? AppImages.cartSelected(context)
                    : AppImages.cartUnselected(context),
              ),
              label: '•',
            ),

            BottomNavigationBarItem(
              icon: SizedBox(
                height: 27,
                width: 27,
                child: (_selectedIndex == 4)
                    ? AppImages.profileSelected(context)
                    : AppImages.profileUnselected(context),
              ),
              label: '•',
            ),
            // BottomNavigationBarItem(
            //   icon: AppImages.home(context),
            //   label: '',
            // ),
          ],
        ),
      ),
    );
  }
}
