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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                width: size.width / 1,
                child: const Text(
                  '''
1)Blood Flow blood donation feature, designed to connect volunteer blood donors ("Donors") with nearby Receivers who require blood donations, enables Donors to locate people in their local geographic area ("Receivers"). These Terms govern the use of the Feature by Donors, Receivers, and their authorized Third Parties.

2)Blood Flow is not a blood bank, nor is it affiliated with any specific blood recipient. The company does not engage in any activities related to blood donation, such as selecting donors or handling blood collection, storage, processing, or transportation. There is no medical supervision or assistance provided by UBload, nor is the company required to have any licenses, certifications, or registrations under Applicable Law. The goal of UBload's blood donation feature is to use technology to facilitate connections between Donors and Receivers. However, it is important to note that blood donation is voluntary and there is no guarantee that a potential Donor will agree to donate blood. Donors may remove their status at any time. Participation in the Feature is also voluntary, and UBload cannot guarantee connections between Donors and Receivers or be held liable for any injury or loss of life resulting from such connections. Finally, no contractual relationship is established between any parties using the Feature or with UBload, whether expressed or implied.

3)Blood Flow's role is solely that of a platform provider for connecting Donors and Receivers using its smart app. The company facilitates contact between these two parties by providing relevant information about Donors and those in need of blood. However, UBload is not responsible for any direct contact made between Donors and Receivers, nor for the actions of Donors before or after contact is made. Blood Flow also does not assume responsibility for any misuse of contact information displayed through its app. While the company provides information about Donors and those in need of blood, it cannot guarantee the authenticity, accuracy, or correctness of this information, and it is up to the Donor and the Receiver to verify each other's information with their respective hospitals or blood banks. Blood Flow does not receive any protected health information, and under no circumstances will it have access to any Donor's health records or eligibility exams. Blood Flow will not be responsible for any claims, disputes, suits, actions, proceedings, losses, injury, damages, or harm caused to the Donor, Receiver, or any third party as a result of their interaction.



4)Blood Flow does not assume any responsibility for verifying the licensure, accreditation, or reputation of a Blood Bank. It is solely the responsibility of the Donors to ensure that the Blood Bank is suitable before donating blood.
Any information obtained or created by the Blood Bank is not the responsibility of Blood Flow.
Donors should comply with Applicable Law and review local regulations and policies.


5)It is important that you consult with qualified medical professionals before engaging in any blood donation activities. Blood Flow does not conduct any independent health or background checks and cannot guarantee that you will be eligible or able to donate blood. The responsibility of determining your eligibility and ability to donate blood lies solely with the Receiver or any Third Party, such as hospitals, blood banks, or diagnostic laboratories.

6)Donating blood is a voluntary activity, and it is completely up to you to decide whether or not to do so. You have the right to revoke your status as a blood donor and cease receiving notifications at any time by adjusting your Blood Flow profile settings.

7)By registering as a Donor on Blood Flow, you indicate your willingness to donate blood voluntarily and consent to receiving notifications when blood Receivers in your local area require a blood donation through our platform.


8)When using the Feature, Donors and Receivers must comply with Blood Flow's Standards, Data Policy, and other applicable terms and conditions ("Blood Flow Website Terms") regarding the use of Blood Flow's products, services, and brands. If there are any conflicts or inconsistencies between these Blood Donation Feature Terms and other Blood Flow Website Terms, the latter will take precedence.
You acknowledge that Blood Flow's collection, processing, storage, and transfer of information obtained in relation to your use of the Feature are in accordance with Blood Flow's Data Policy.
Information or content provided through the Feature should only be used for the purposes outlined in these Terms.
Blood Flow reserves the right to deny or revoke Donor access to or participation in the Feature, or to remove the Feature for any reason at any time.

9)While providing the Feature, Blood Flow does not endorse or promote any treatment, drugs, services, remedies, or activities that claim to cure, diagnose, prevent, or mitigate any disease or illness.

10)Blood Flow does not require any monetary compensation from Donors or Receivers for their voluntary blood donation.





''',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
