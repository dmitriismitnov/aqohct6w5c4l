import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:aqohct6w5c4l/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/products_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: theme.colorScheme.brightness,
      ),
      child: _MainSceenBlocsProvider(
        child: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: DecoratedBox(
            decoration: BoxDecoration(color: theme.colorScheme.background),
            child: Column(
              children: const [
                SizedBox(height: 24),
                _MainScreenHeader(),
                SizedBox(height: 8),
                Expanded(
                  child: MainScreenProductsList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainSceenBlocsProvider extends StatelessWidget {
  final Widget child;

  const _MainSceenBlocsProvider({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProductsBloc(productProvider: ProductProvider());
        return bloc..add(const ProductsBlocEvent.loadPart());
      },
      child: child,
    );
  }
}

class _MainScreenHeader extends StatelessWidget {
  const _MainScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Меню', style: theme.textTheme.headline1),
          PrimaryIconButton(
            onPressed: () {
              final bloc = context.read<ProductsBloc>();
              bloc.add(const ProductsBlocEvent.addOneRandom());
            },
            child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
          )
        ],
      ),
    );
    ;
  }
}
