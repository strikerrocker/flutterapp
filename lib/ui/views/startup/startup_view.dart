import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'startup_view_model.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: const Center(
            child: Text("Starting"),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () { model.ready(context); },child: const Icon(Icons.add),),
        );
      },
      onModelReady: (model) => model.ready(context),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
