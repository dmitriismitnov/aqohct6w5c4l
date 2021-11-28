import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/ui/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card.dart';

class MainScreenProductsList extends StatelessWidget {
  static const _loadOffset = 4;

  const MainScreenProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(
      builder: (context, state) {
        Widget? child;

        if (state.isPendingState && state.unsafeProducts.isEmpty) {
          child = const LoadingIndicator();
        }

        if (state.maybeProducts != null) {
          child ??= CustomScrollView(
            primary: true,
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    if (state.maybeHasMoreReached != true &&
                        !state.isPendingState &&
                        i + _loadOffset == state.unsafeProducts.length) {
                      context.read<ProductsBloc>().add(const ProductsBlocEvent.loadPart());
                    }

                    final product = state.unsafeProducts[i];

                    return MainScreenProductCard(
                      key: ValueKey(product.id.parseToString()),
                      product: product,
                    );
                  },
                  childCount: state.unsafeProducts.length,
                ),
              ),
              if (state.isPendingState)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: LoadingIndicator(dimension: 24),
                  ),
                ),
            ],
          );
        }

        child ??= const SizedBox.shrink();

        return child;
      },
    );
  }
}
