import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/provider/donar_provider.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/screens/filtered_req_screens/my_type_donars_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllDonarsScreen extends StatelessWidget {
  const AllDonarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, value, child) {
      return Consumer<DonarProvider>(builder: ((_, __, ___) {
        return ListView.builder(
            itemCount: __.isLoading ? 40 : __.allDonars.length,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              UserProfile requestData =
                  UserProfile.fromMap(__.allDonars[index].data());
              return __.isLoading
                  ? const CircularProgressIndicator()
                  :  DonarCardWidget(userProfile: requestData,donarProvider: __,);
            }));
      }));
    }));
  }
}
