import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theming/styles.dart';
import '../../../logic/home_cubit.dart';

Future<dynamic> showSignOutDialog(BuildContext context,HomeCubit cubit){

  return showDialog(
    context: context,
    barrierDismissible: false, // User must tap a button to close
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: Text('Do you want to Sign Out??',style: AppTextStyles.font12OrangeMedium,),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false); // Returns false
            },
          ),
          TextButton(
            child: const Text('sign out'),
            onPressed: () {
              cubit.userLogOut(context: context);
            },
          ),
        ],
      );
    },
  );
}