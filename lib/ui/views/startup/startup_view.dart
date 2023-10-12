import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

//local
import 'startup_viewmodel.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onViewModelReady: (viewModel) => SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic()),
      builder: (context, viewModel, child) => Scaffold(
        body: ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.2).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.fastOutSlowIn,
          )),
          child: Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
