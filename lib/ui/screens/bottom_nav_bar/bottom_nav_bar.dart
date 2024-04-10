import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sys_mobile/ui/screens/home/home_screen.dart';
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
    HomeScreen(),
    Text('likes Page'),
    Text('add Page'),
    Text('cart Page'),
    Text('profile Page'),
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
          showSelectedLabels: true,
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
