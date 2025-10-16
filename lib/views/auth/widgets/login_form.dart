import 'package:evently/core/app_routes.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/firebase/firebase_service.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isPassword = ValueNotifier<bool>(true);
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController emailText = TextEditingController();
    TextEditingController passwordText = TextEditingController();
    ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailText,
            hintText: AppLocalizations.of(context)!.email,
            prefixIcon: const Icon(Icons.email),
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field can't be empty";
              }
              if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return "Invalid Email";
              }
              {
                return null;
              }
            },
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder(
            valueListenable: isPassword,
            builder: (context, value, child) {
              return CustomTextField(
                hintText: AppLocalizations.of(context)!.password,
                controller: passwordText,
                prefixIcon: const Icon(Icons.lock),
                textInputType: TextInputType.visiblePassword,
                isPassword: value,
                suffixIcon: InkWell(
                  onTap: () {
                    isPassword.value = !value;
                  },
                  child: Icon(
                    isPassword.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This can't be empty";
                  }

                  return null;
                },
              );
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.forgetPasswordRoute);
              },
              child: Text(AppLocalizations.of(context)!.forgetPassword),
            ),
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder:
                (context, value, child) => SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      isLoading.value = true;
                      if (formKey.currentState!.validate()) {
                        try {
                          await FirebaseService().loginUser(
                            email: emailText.text,
                            password: passwordText.text,
                          );
                          if (context.mounted) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(AppRoutes.homeRoute);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'No user found for that email.',
                                  ),
                                ),
                              );
                            }
                          } else if (e.code == 'wrong-password') {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Wrong password provided for that user.',
                                  ),
                                ),
                              );
                            }
                          }
                        } finally {
                          isLoading.value = false;
                        }
                      }
                    },
                    child:
                        value
                            ? CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.surface,
                            )
                            : Text(AppLocalizations.of(context)!.login),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
