import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/widgets/product_widget.dart';
import '../../../../../common/constants.dart';
import '../../../../../common/widgets/k_text_field.dart';
import '../../../common/widgets/product_app_bar.dart';
import '../../../common/widgets/screen_content_wrapper_widget.dart';
import '../../../data/models/product.dart';
import '../../home/view_model/home_view_model.dart';

class SearchView extends ConsumerStatefulWidget {
  final TextEditingController searchController;

  const SearchView({required this.searchController, super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchView> {
  List<Product> _filteredProducts = [];
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: ProductAppBar(context: context, viewTitle: ""),
      body: ScreenContentWrapperWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              KTextField(
                controller: widget.searchController,
                focusNode: _focusNode,
                label: "Search...",
                prefixIcon: AssetPath.searchIcon,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() => _filteredProducts = []);
                  } else {
                    final products = homeState.products.value ?? [];
                    setState(() {
                      _filteredProducts = products
                          .where((product) => product.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _filteredProducts.isEmpty
                    ? const Center(
                        child: Text("No products to display."),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return ProductWidget(product: product);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
