import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/extensions/context_extension.dart';
import '../../../common/utils.dart';
import '../../../theme/app_color.dart';
import '../../home/view/home_view.dart';
import '../../skeleton_view/view/skeleton_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _screens = const [
    HomeView(),
    SkeletonView(screenTitle: "Order"),
    SkeletonView(screenTitle: "Offer"),
    SkeletonView(screenTitle: "More"),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16
          ),
          child: Text(
            "Hey 😊\nLets search your prodcut",
            style: context.textTheme.titleMedium?.copyWith(color: AppColor.white),
          ),
        ),
         actions: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const SkeletonView(screenTitle: "Profile"))),
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                AssetPath.profileImage,
              ),
              radius: 20,
            ),
          ),
          hGap(horizontalPaddingLarge),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(AssetPath.homeIcon, "Home", 0),
                _buildNavBarItem(AssetPath.orderIcon, "Order", 1),
                const SizedBox(width: 48), // Space for FAB
                _buildNavBarItem(AssetPath.giftIcon, "Offer", 2),
                _buildNavBarItem(AssetPath.menuIcon, "More", 3),
              ],
            ),
          ),
          Positioned(
            top: -30,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SkeletonView(screenTitle: "Cart"))),
              child: svgPicture(
                  imagePath: AssetPath.cartIcon, color: AppColor.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(String icon, String name, int index) {
    final itemColor = _selectedIndex == index ? AppColor.white : AppColor.grey;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        children: [
          svgPicture(
            imagePath: icon,
            color: itemColor,
          ),
          vGap(2),
          Text(
            name,
            style: context.textTheme.labelMedium?.copyWith(color: itemColor),
          )
        ],
      ),
    );
  }
}
