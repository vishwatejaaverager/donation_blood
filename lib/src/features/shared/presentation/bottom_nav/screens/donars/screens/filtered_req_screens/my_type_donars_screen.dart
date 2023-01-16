import 'dart:developer';

import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/provider/donar_provider.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/donars_card.dart';

class MyTypeDonarsScreen extends StatelessWidget {
  const MyTypeDonarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DonarProvider>(builder: ((_, __, ___) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: __.isLoading ? 5 : __.sameType.length,
          itemBuilder: ((context, index) {
            if (!__.isLoading) {
              UserProfile requestData =
                  UserProfile.fromMap(__.sameType[index].data());
              return DonarCardWidget(
                userProfile: requestData,
                donarProvider: __,
              );
            } else {
              return const CircularProgressIndicator();
            }
          }));
    }));
  }
}
