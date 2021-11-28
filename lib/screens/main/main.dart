import 'package:aqohct6w5c4l/blocs/products_bloc/products_bloc.dart';
import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:aqohct6w5c4l/ui/ui.dart';
import 'package:flutter/material.dart' show AppBar, Icons, Scaffold, Theme;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/products_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _MainSceenBlocsProvider(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Меню', style: theme.textTheme.headline1),
          actions: const [
            _MainScreenAppBarAddProductAction(),
          ],
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: theme.colorScheme.brightness,
          ),
        ),
        body: const MainScreenProductsList(),
        backgroundColor: theme.colorScheme.background,
      ),
    );
  }
}

class _MainScreenAppBarAddProductAction extends StatelessWidget {
  const _MainScreenAppBarAddProductAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: PrimaryIconButton(
          onPressed: () {
            final bloc = context.read<ProductsBloc>();
            bloc.add(const ProductsBlocEvent.addOneRandom());
          },
          child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
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
