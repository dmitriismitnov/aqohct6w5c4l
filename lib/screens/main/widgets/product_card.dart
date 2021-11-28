import 'dart:math' as math;

import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/models/models.dart';
import 'package:aqohct6w5c4l/ui/ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' show Icons, Theme;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
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
      background: _MainScreenProductCardBackground(title: product.title, url: product.imageUrl),
      title: _MainScreenProductCardTitle(title: product.title),
      removeButton: _MainScreenProductCardRemoveButton(product: product),
    );
  }
}

class _MainScreenProductCardContainer extends StatelessWidget {
  final Widget background;
  final Widget removeButton;
  final Widget title;

  const _MainScreenProductCardContainer({
    required this.background,
    required this.removeButton,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Positioned.fill(child: background),
          Positioned(
            left: 16,
            right: 0,
            bottom: 0,
            child: title,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: removeButton,
          ),
        ],
      ),
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
    final theme = Theme.of(context);

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      fadeOutDuration: const Duration(milliseconds: 500),
      fadeInDuration: const Duration(milliseconds: 500),
      errorWidget: (BuildContext context, String url, dynamic error) {
        return FadeWidget(
          duration: const Duration(milliseconds: 500),
          child: SvgPicture.asset(
            _randomPlaceholderPath,
            color: theme.colorScheme.error.withOpacity(0.6),
          ),
        );
      },
    );
  }

  static const List<String> _placeholdersPaths = <String>[
    'assets/images/vector/placeholder_a_can.svg',
    'assets/images/vector/placeholder_bottle.svg',
    'assets/images/vector/placeholder_pack.svg',
  ];

  String get _randomPlaceholderPath {
    return _placeholdersPaths[math.Random().nextInt(_placeholdersPaths.length)];
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
        context.read<ProductsBloc>().add(ProductsBlocEvent.removeOneById(product.id));
      },
      child: const Icon(
        Icons.restore_from_trash_rounded,
      ),
    );
  }
}
