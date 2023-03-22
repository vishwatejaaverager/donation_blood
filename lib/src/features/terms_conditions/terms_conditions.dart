import 'package:donation_blood/src/utils/routes.dart';
import 'package:donation_blood/src/utils/utils.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  static const id = AppRoutes.termsAndConditions;
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Terms and Conditions",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topCenter,
          width: size.width / 1.1,
          child: const Text(
            '''
1) Blood care Serves only as platform to connect donars and receivers 

2) Blood care is not responsible for the donars action

3) Blood care is not responsible for mis use contact information displayed

4) donar and receiver is responsible for verifying authenticity,accuaracy 

5) blood care does not receive any protected health information 

6) blood care does not charge any money from donars or receivers 

7) blood care is not promoting any treatment drug or any other 





''',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
