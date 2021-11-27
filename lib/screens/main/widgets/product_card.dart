import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/models/models.dart';
import 'package:aqohct6w5c4l/ui/ui.dart';
import 'package:flutter/material.dart' show Colors, Icons, Theme;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MainScreenProductCard extends StatelessWidget {
  final ProductModel product;

  const MainScreenProductCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainScreenProductCardContainer(
      child: Stack(
        children: [
          Positioned.fill(
            child: _MainScreenProductCardBackground(
              title: product.title,
              url: product.imageUrl,
            ),
          ),
          Positioned(
            left: 16,
            right: 0,
            bottom: 0,
            child: _MainScreenProductCardTitle(title: product.title),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: _MainScreenProductCardRemoveButton(
              product: product,
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreenProductCardSkeleton extends StatelessWidget {
  const MainScreenProductCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _MainScreenProductCardContainer(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.amber),
      ),
    );
  }
}

class _MainScreenProductCardContainer extends StatelessWidget {
  final Widget child;

  const _MainScreenProductCardContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: child,
    );
  }
}

class _MainScreenProductCardBackground extends StatelessWidget {
  final String title;
  final String url;

  const _MainScreenProductCardBackground({
    required this.title,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      semanticLabel: title,
    );
  }
}

class _MainScreenProductCardTitle extends StatelessWidget {
  final String title;

  const _MainScreenProductCardTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.background,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.subtitle1,
      ),
    );
  }
}

class _MainScreenProductCardRemoveButton extends StatelessWidget {
  final ProductModel product;

  const _MainScreenProductCardRemoveButton({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryIconButton(
      onPressed: () {
        HapticFeedback.mediumImpact();
        context.read<ProductsBloc>().add(ProductsBlocEvent.removeOneById(product.id));
      },
      child: const Icon(
        Icons.restore_from_trash_rounded,
      ),
    );
  }
}
