import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: const Center(
            child: Text("Starting"),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () { model.ready(); },child: Icon(Icons.add),),
        );
      },
      onModelReady: (model) => model.ready,
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
