import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/features/signup/ui/widgets/already_have_account.dart';
import 'package:taski/features/signup/ui/widgets/sign_up_art.dart';
import 'package:taski/features/signup/ui/widgets/sign_up_text_fom_fields.dart';

import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../logic/sighn_up_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SignUpCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      signUpArt(),
                      signUpTextFormField(
                        context: context,
                         cubit: SignUpCubit.get(context),
                      ),
                      verticalSpace(24),
                    state is SignUpLoading? CupertinoActivityIndicator()  :Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: AppTextButton(
                          buttonText: 'Sign up',
                          textStyle: AppTextStyles.font16WhiteBold,
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(context: context);}
                          },
                        ),
                      ) ,
                      verticalSpace(24),
                      alreadyHaveAccountText(context),
                      verticalSpace(16),
                      verticalSpace(24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
