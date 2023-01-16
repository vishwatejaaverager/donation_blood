import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes.dart';
import '../../../utils/utils.dart';
import '../provider/profile_provider.dart';
import '../provider/search_provider.dart';

class LocationSeachScreen extends StatefulWidget {
  static const id = AppRoutes.locationSearchScreen;
  const LocationSeachScreen({super.key});

  @override
  State<LocationSeachScreen> createState() => _LocationSeachScreenState();
}

class _LocationSeachScreenState extends State<LocationSeachScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: ((_, __, ___) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  "Search Location",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    __.placeAutocomplete(value);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Your Location",
                      icon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.gps_not_fixed),
                      )),
                ),
              ),
              sbh(12),
              const Divider(
                height: 4,
                thickness: 4,
              ),
              sbh(12),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gps_fixed,
                        color: Colors.grey.shade500,
                      ),
                      sbw(12),
                      const Text("Use My Current Location")
                    ],
                  ),
                ),
              ),
              sbh(12),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: __.placesData.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            String a = __.placesData[index]['place_id'];
                            Provider.of<ProfileProvider>(context, listen: false)
                                .setDescription(
                                    __.placesData[index]['description']);

                            __.getCoOrdinates(a, context);
                          },
                          leading: const Icon(Icons.gps_fixed),
                          title: Text(
                            __.placesData[index]['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Divider(
                          height: 4,
                          thickness: 2,
                        ),
                      ],
                    );
                  }))
            ],
          ),
        ),
      );
    }));
  }
}
