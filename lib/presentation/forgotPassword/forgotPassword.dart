import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/app/di.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';
import 'package:learning_mvvm_architecture/presentation/forgotPassword/forgotPasswordViewModel.dart';
import '../resources/assetsManager.dart';
import '../resources/colorManager.dart';
import '../resources/stringManager.dart';
import '../resources/valueManager.dart';
import '../resources/routesManager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context, _getForgottenPasswordContent(), () {
                _viewModel.resetPassword();
              }) ??
              _getForgottenPasswordContent();
        },
      ),
    );
  }

  Widget _getForgottenPasswordContent() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p140),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(
                image: AssetImage(ImageAssets.splashLogo4),
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsEmailValid,
                  builder: (context, snapshot) {
                    return TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppString.email,
                        label: const Text(AppString.email),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppString.emailError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.resetPassword();
                              }
                            : null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorManager.pink1),
                        ),
                        child: Text(
                          AppString.resetPassword,
                          style: TextStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.forgotPasswordRoute);
                  },
                  child: Text(
                    AppString.emailNotSent,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
