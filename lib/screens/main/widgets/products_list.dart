import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/ui/ui.dart';
import 'package:flutter/widgets.dart';
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
          child = const LoadingIndicator();
        }

        if (state.maybeProducts != null) {
          child ??= GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: state.unsafeProducts.length,
            itemBuilder: (context, index) {
              final product = state.unsafeProducts[index];

              return MainScreenProductCard(
                key: ValueKey(product.id),
                product: product,
              );
            },
            primary: true,
          );
        }

        child ??= const SizedBox.shrink();

        return child;
      },
    );
  }
}
