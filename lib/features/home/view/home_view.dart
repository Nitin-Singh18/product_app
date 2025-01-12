import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants.dart';
import '../../../common/utils.dart';
import '../../../common/widgets/category_item_widget.dart';
import '../../../common/widgets/items_tile_widget.dart';
import '../../../common/widgets/k_text_field.dart';
import '../../../common/widgets/product_widget.dart';
import '../../../common/widgets/screen_content_wrapper_widget.dart';
import '../../../data/models/product.dart';
import '../../skeleton_view/view/skeleton_view.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            vGap(16),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPaddingLarge),
              child: InkWell(
                onTap: () => navigateWithSlide(
                  context,
                  const SkeletonView(screenTitle: "Search Screen"),
                ),
                child: KTextField(
                  controller: searchController,
                  label: "Search your product ...",
                  prefixIcon: AssetPath.searchIcon,
                  isEnabled: false,
                ),
              ),
            ),
            vGap(24),
            Expanded(
              child: ScreenContentWrapperWidget(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(homeViewModelProvider).products.when(
                          data: (products) {
                            final homeViewState =
                                ref.read(homeViewModelProvider);
                            final categories = homeViewState.categories;
                            final popularDeals = homeViewState.popularDeals;
                            return Column(
                              children: [
                                _buildCategories(categories.entries.toList()),
                                vGap(12),
                                _buildPopularDeals(popularDeals),
                              ],
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => Center(
                            child: Text('Error: $error'),
                          ),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(List<MapEntry<String, String>> categories) =>
      ItemsTileWidget(
        title: "Categories",
        isCategories: true,
        categories: categories,
        items: SizedBox(
          height: 146,
          child: ListView.builder(
            itemCount: categories.take(4).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: horizontalPaddingSmall),
                child: CategoryItemWidget(
                  image: category.value,
                  title: category.key,
                ),
              );
            },
          ),
        ),
      );

  Widget _buildPopularDeals(List<Product> popularDeals) => ItemsTileWidget(
        title: "Popular Deals",
        isCategories: false,
        popularDeals: popularDeals,
        items: SizedBox(
          height: 220,
          child: ListView.builder(
            itemCount: popularDeals.take(4).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = popularDeals[index];
              return Padding(
                padding: const EdgeInsets.only(right: horizontalPaddingSmall),
                child: SizedBox(
                  width: 140,
                  child: ProductWidget(
                    product: product,
                  ),
                ),
              );
            },
          ),
        ),
      );
}
