import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../styles/styles.dart';
import '../../../widgets/widget_export.dart';
import '../../../utils/utils_export.dart';
import '../../app.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: "admin@mail.com");
  TextEditingController passwordController =
      TextEditingController(text: "Test123");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(context),
      child: BlocConsumer<SignInCubit, SignInState>(
        listenWhen: (previous, current) =>
            previous.authStatus != current.authStatus,
        buildWhen: (previous, current) => false,
        listener: (context, state) {
          switch (state.authStatus) {
            case AuthStatus.success:
              Helpers.showToast(
                context: context,
                title: state.authMessage,
              );
              break;
            case AuthStatus.failed:
              Helpers.showToast(
                context: context,
                title: state.authMessage,
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: CustomColors.whiteColor,
            body: SafeArea(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "assets/images/background2.jpeg",
                            ),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 286,
                      bottom: 0,
                      right: 286,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        constraints: BoxConstraints(maxWidth: 800),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Admin Login",
                                    style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.blueColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Sizes.s32,
                                  ),
                                  TextInputField(
                                    controller: emailController,
                                    label: 'Email',
                                    validator: emailValidator,
                                    labelTextColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: Sizes.s10,
                                  ),
                                  TextInputField(
                                    controller: passwordController,
                                    label: 'Password',
                                    validator: passwordValidator,
                                    labelTextColor: Colors.white,
                                    obscureText: true,
                                  ),
                                  const SizedBox(
                                    height: Sizes.s40,
                                  ),
                                  BlocBuilder<SignInCubit, SignInState>(
                                    buildWhen: (previous, current) =>
                                        previous.loading != current.loading,
                                    builder: (context, state) {
                                      var cubit = context.read<SignInCubit>();
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(Sizes.s4),
                                        child: CustomFilledButton(
                                          backgroundColor:
                                              CustomColors.blueColor,
                                          labelStyle: const TextStyle(
                                            color: CustomColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          childWidget: state.loading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        CustomColors.whiteColor,
                                                  ),
                                                )
                                              : null,
                                          onPressed: () {
                                            if (!state.loading) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                cubit.onLoginPressed(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                );
                                              }
                                            }
                                          },
                                          label: 'Login',
                                          height: Sizes.s48,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
