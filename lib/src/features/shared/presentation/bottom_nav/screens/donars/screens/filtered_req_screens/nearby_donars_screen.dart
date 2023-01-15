import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/models/user_profile_model.dart';
import '../../provider/donar_provider.dart';
import 'my_type_donars_screen.dart';

class NearbyDonarsScreen extends StatelessWidget {
  const NearbyDonarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DonarProvider>(builder: ((_, __, ___) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: __.isLoading ? 5 : __.nearby.length,
          itemBuilder: ((context, index) {
            if (!__.isLoading) {
              UserProfile requestData =
                  UserProfile.fromMap(__.nearby[index].data());
              return DonarCardWidget(userProfile: requestData,donarProvider: __,);
            } else {
              return const CircularProgressIndicator();
            }
          }));
    }));
  }
}
