import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/widgets/app_text_button.dart';
import 'package:taski/features/login/ui/widgets/dont_have_account_text.dart';
import 'package:taski/features/login/ui/widgets/login_art.dart';
import 'package:taski/features/login/ui/widgets/login_textformfields.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/routing/routs.dart';
import '../../../core/theming/styles.dart';
import '../logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if(state is LoginSuccess){
              context.pushNamed(Routes.homeScreen);
            }
          },
          builder: (context, state){
            final cubit = LoginCubit.get(context);
            final formKey = GlobalKey<FormState>();
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      loginArt(),
                      Form(
                        key: formKey,
                          child: LoginTextFormFields(cubit: cubit,)),
                      state is LoginLoading ? CupertinoActivityIndicator() : Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        child: AppTextButton(
                          verticalPadding: 10.h,
                          buttonText: "Sign In",
                          textStyle: AppTextStyles.font16WhiteMedium,
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                            cubit.userLogin(context: context);}
                          },
                        ),
                      ),
                      verticalSpace(24),
                      doNotHaveAccountText(context),
                      verticalSpace(16),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
