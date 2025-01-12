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
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.sizeOf(context).width, 80),
            painter: CurvedBottomNavBarPainter(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomAppBar(
              color: Colors.transparent,
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
          vGap(3),
          Text(
            name,
            style: context.textTheme.labelMedium?.copyWith(color: itemColor),
          )
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 40,
            child: SizedBox(
              height: 68,
              width: 66,
              child: FloatingActionButton(
                onPressed: () => _onItemTapped(4),
                backgroundColor: AppColor.white,
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: AppColor.green,
                    width: 8,
                  ),
                ),
                child: svgPicture(
                  imagePath: AssetPath.cartIcon,
                  color: AppColor.green,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            child: Consumer(
              builder: (context, ref, child) {
                return SizedBox(
                  height: 24,
                  width: 24,
                  child: Badge.count(
                    backgroundColor: Colors.orange,
                    count: ref.watch(cartViewModelProvider).itemCount,
                    alignment: Alignment.topCenter,
                  ),
                );
              },
            ),
          ),
        ],
      );
}

class CurvedBottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 32)
      // start curve
      ..arcToPoint(Offset(size.width * 0.06, 10),
          radius: const Radius.circular(borderRadiusLarge))
      ..lineTo(size.width * 0.38, 1)
      // left edge for curve
      ..arcToPoint(Offset(size.width * 0.4, 6),
          radius: const Radius.circular(8))
      // under curve
      ..arcToPoint(Offset(size.width * 0.6, 6),
          radius: const Radius.circular(40), clockwise: false)
      // right edge for curve
      ..arcToPoint(Offset(size.width * 0.62, 1),
          radius: const Radius.circular(8))
      ..lineTo(size.width * 0.94, 10)
      // end curve
      ..arcToPoint(Offset(size.width, 32),
          radius: const Radius.circular(borderRadiusLarge))
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
