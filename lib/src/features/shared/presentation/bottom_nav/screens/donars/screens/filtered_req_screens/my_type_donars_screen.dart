import 'package:donation_blood/src/features/shared/domain/models/user_profile_model.dart';
import 'package:donation_blood/src/features/shared/presentation/bottom_nav/screens/donars/provider/donar_provider.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:donation_blood/src/utils/widget_utils/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class DonarCardWidget extends StatelessWidget {
  final UserProfile userProfile;
  final DonarProvider donarProvider;

  const DonarCardWidget({
    required this.userProfile,
    required this.donarProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      child: ListTile(
        onTap: () {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(240)
              ),
              builder: ((context) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CacheImage(image: userProfile.profileImage!),
                      title: Text(userProfile.name!),
                      subtitle: Text(donarProvider.calcDistFromUser(
                                  userProfile, context) ==
                              "0.0"
                          ? "0.10 km"
                          : donarProvider.calcDistFromUser(
                              userProfile, context)),
                      trailing: InkWell(
                        onTap: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/home/blood_help.png",
                              scale: 20,
                            ),
                            const Text("Request"),

                          ],
                        ),
                      ),
                    ),
                   
                  ],
                );
              }));
        },
        title: Text(userProfile.name!),
        leading: CircleAvatar(
          radius: 30,
          child: CacheImage(
              fit: BoxFit.fitWidth, image: userProfile.profileImage!),
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.redAccent,
          radius: 30,
          child: Text(
            userProfile.bloodGroup!,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: SizedBox(
            width: size.width / 3,
            child: Text(
              userProfile.location!,
              overflow: TextOverflow.ellipsis,
            )),
      ),
    );
  }
}
