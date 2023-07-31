import 'dart:async';

import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
//  shared variables and functions that will be used through anny view model

  final StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); //called when .int of view model
  void dispose(); //called when viewModel dies

Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState>get outputState;
}
