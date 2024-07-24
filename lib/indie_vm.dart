library indie_vm;

import 'package:flutter/widgets.dart';

interface class IndieVM {
  void onDispose() {
  }

  void onInit(BuildContext context) {
  }
}

abstract class IndieView<T extends IndieVM> extends StatefulWidget {
  // Start of immutable state:
  const IndieView({super.key});

  T viewModelBuilder(BuildContext context);
  Widget builder(BuildContext context, T viewModel);

  @override
  State<IndieView> createState() => _IndieViewState<T>();
}

class _IndieViewState<T extends IndieVM> extends State<IndieView<T>> {
  late T _viewModel; // Local reference to the ViewModel
  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelBuilder(context);
    _viewModel.onInit(context); // Call onInit on the ViewModel
  }

  @override
  void dispose() {
    _viewModel.onDispose(); // Call onDispose on the ViewModel
    super.dispose();
  }

  // Start of UI:
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _viewModel); // Return the passed child widget
  }
}
