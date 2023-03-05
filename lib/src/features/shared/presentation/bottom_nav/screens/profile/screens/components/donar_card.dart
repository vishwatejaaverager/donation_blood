import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../utils/utils.dart';
import '../../../../../../../../utils/widget_utils/size_config.dart';
import '../../../../../../domain/models/user_profile_model.dart';
import '../../provider/user_profile_provider.dart';

class DonarCard extends StatelessWidget {
  const DonarCard({
    Key? key,
    required UserProfile profile,
  })  : _profile = profile,
        super(key: key);

  final UserProfile _profile;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(builder: ((context, value, child) {
      return Container(
        margin: const EdgeInsets.all(16),
        // height: size.height / 3,
        width: getProportionateScreenWidth(size.width),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Coins",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Blood Donation",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              sbh(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value.coins,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  const Text(
                    " Coins",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
              sbh(12),
              Text(
                _profile.name!,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                _profile.phone!.substring(3),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              )
            ],
          ),
        ),
      );
    }));
  }
}
