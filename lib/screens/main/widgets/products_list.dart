import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card.dart';

class MainScreenProductsList extends StatelessWidget {
  const MainScreenProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(
      builder: (context, state) {
        Widget? child;

        if (state.isPendingState && state.unsafeProducts.isEmpty) {
          child = _MainScreenProductListContainer(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const MainScreenProductCardSkeleton();
            },
          );
        }

        if (state.maybeProducts != null) {
          child ??= _MainScreenProductListContainer(
            itemCount: state.unsafeProducts.length,
            itemBuilder: (context, index) {
              final product = state.unsafeProducts[index];

              return MainScreenProductCard(
                key: ValueKey(product.id),
                product: product,
              );
            },
          );
        }

        child ??= const SizedBox.shrink();

        return child;
      },
    );
  }
}

class _MainScreenProductListContainer extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const _MainScreenProductListContainer({
    required this.itemBuilder,
    required this.itemCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
