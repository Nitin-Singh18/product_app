import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants.dart';
import '../../../common/extensions/context_extension.dart';
import '../../../common/utils.dart';
import '../../../theme/app_color.dart';
import '../../cart/view_model/cart_view_model.dart';
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
    SkeletonView(screenTitle: "Cart")
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
      extendBody: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Hey 😊\nLets search your products",
            style:
                context.textTheme.titleMedium?.copyWith(color: AppColor.white),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => navigateWithSlide(
              context,
              const SkeletonView(screenTitle: "Profile"),
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                AssetPath.profileImage,
              ),
              radius: 22,
            ),
          ),
          hGap(horizontalPaddingLarge),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: Consumer(builder: (context, ref, child) {
            return Badge.count(
                count: ref.watch(cartViewModelProvider).itemCount,
                alignment: Alignment.topCenter,
                child: FloatingActionButton(
                  onPressed: () => _onItemTapped(4),
                  backgroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 6, color: AppColor.green),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: svgPicture(
                      imagePath: AssetPath.cartIcon, color: AppColor.green),
                ));
          })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadiusMedium),
                topRight: Radius.circular(borderRadiusMedium))),
        child: BottomAppBar(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(top: 24),
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavBarItem(AssetPath.homeIcon, "Home", 0),
              _buildNavBarItem(AssetPath.orderIcon, "Order", 1),
              const SizedBox(width: 48),
              _buildNavBarItem(AssetPath.giftIcon, "Offer", 2),
              _buildNavBarItem(AssetPath.menuIcon, "More", 3),
            ],
          ),
        ),
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
          vGap(3),
          Text(
            name,
            style: context.textTheme.labelMedium?.copyWith(color: itemColor),
          )
        ],
      ),
    );
  }
}
