abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
//  shared variables and functions that will be used through anny view model

}

abstract class BaseViewModelInputs {
  void start(); //called when .int of view model
  void dispose(); //called when viewModel dies

}

abstract class BaseViewModelOutputs {}
