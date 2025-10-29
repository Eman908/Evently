import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/generated/i18n/app_localizations.dart';
import 'package:evently/views/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> password = ValueNotifier<bool>(true);
    ValueNotifier<bool> rePassword = ValueNotifier<bool>(true);
    ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController passwordText = TextEditingController();
    TextEditingController rePasswordText = TextEditingController();
    TextEditingController nameText = TextEditingController();
    TextEditingController emailText = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          CustomTextField(
            controller: nameText,
            hintText: AppLocalizations.of(context)!.name,
            prefixIcon: const Icon(Icons.person),
            textInputType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field can't be empty";
              }
              if (!RegExp(
                r'^[a-zA-Z\u0600-\u06FF][a-zA-Z\u0600-\u06FF\s]*$',
              ).hasMatch(value)) {
                return "Invalid Name";
              }
              {
                return null;
              }
            },
          ),
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
          ValueListenableBuilder(
            valueListenable: password,
            builder: (context, value, child) {
              return CustomTextField(
                hintText: AppLocalizations.of(context)!.password,
                controller: passwordText,
                prefixIcon: const Icon(Icons.lock),
                textInputType: TextInputType.visiblePassword,
                isPassword: value,
                suffixIcon: InkWell(
                  onTap: () {
                    password.value = !value;
                  },
                  child: Icon(
                    password.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This can't be empty";
                  }

                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return 'Password must contain at least one number';
                  }
                  if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
                    return 'Password must contain at least one special character';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }

                  return null;
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: rePassword,
            builder: (context, value, child) {
              return CustomTextField(
                hintText: AppLocalizations.of(context)!.rePassword,
                controller: rePasswordText,
                prefixIcon: const Icon(Icons.lock),
                textInputType: TextInputType.visiblePassword,
                isPassword: value,
                suffixIcon: InkWell(
                  onTap: () {
                    rePassword.value = !value;
                  },
                  child: Icon(
                    rePassword.value ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This can't be empty";
                  }
                  if (passwordText.text != rePasswordText.text) {
                    return "Password don't match";
                  }
                  {
                    return null;
                  }
                },
              );
            },
          ),
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
                          await FirebaseService().registerUser(
                            name: nameText.text,
                            email: emailText.text,
                            password: passwordText.text,
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                  'Verification email sent! Please check your inbox.',
                                ),
                              ),
                            );

                            Navigator.of(context).pop();
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'The password provided is too weak.',
                                  ),
                                ),
                              );
                            }
                          } else if (e.code == 'email-already-in-use') {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'The account already exists for that email.',
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
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
                            : Text(AppLocalizations.of(context)!.createAccount),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
