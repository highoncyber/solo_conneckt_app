import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';

class EULA extends StatelessWidget {
  const EULA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: Text("EULA"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "END USER LICENSE AGREEMENT",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "Last updated May 24, 2022",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n\nSOLO CONNECKT is licensed to You (End-User) by SOLO CONNECKT LLC, located and registered at Business address: 6600 SE 74th Okc, ok 73135 EIN: 88-0768809, Oklahoma United States (\"Licensor\"), for use only under the terms of this License Agreement. Our VAT number is 880768809.By downloading the Licensed Application from Apple's software distribution platform (\"App Store\") and Google's software distribution platform (\"Play Store\"), and any update thereto (as permitted by this License Agreement), You indicate that you agree to be bound by all of the terms and conditions of this License Agreement, and that you accept this License Agreement. App Store and Play Store are referred to in this License Agreement as \"Services.\"The parties of this License Agreement acknowledge that the Services are not a Party to this License Agreement and are not bound by any provisions or obligations with regard to the Licensed Application, such as warranty, liability, maintenance and support thereof. SOLO CONNECKT LLC, not the Services, is solely responsible for the Licensed Application and the content thereof.This License Agreement may not provide for usage rules for the Licensed Application that are in conflict with the latest Apple Media Services Terms and Conditions and Google Play Terms of Service (\"Usage Rules\"). SOLO CONNECKT LLC acknowledges that it had the opportunity to review the Usage Rules and this License Agreement is not conflicting with them. SOLO CONNECKT when purchased or downloaded through the Services, is licensed to You for use only under the terms of this License Agreement. The Licensor reserves all rights not expressly granted to You. SOLO CONNECKT is to be used on devices that operate with Apple's operating systems (\"iOS\" and \"Mac OS\") or Google's operating system (\"Android\").2",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nTABLE OF CONTENTS",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n1. THE APPLICATION \n2. SCOPE OF LICENSE \n3. TECHNICAL REQUIREMENTS \n4. MAINTENANCE AND SUPPORT \n5. USE OF DATA  \n6. USER-GENERATED CONTRIBUTIONS \n7. CONTRIBUTION LICENSE \n8. LIABILITY \n9. WARRANTY \n10. PRODUCT CLAIMS \n11. LEGAL COMPLIANCE \n12. CONTACT INFORMATION \n13. TERMINATION \n14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY \n15. INTELLECTUAL PROPERTY RIGHTS \n16. APPLICABLE LAW \n17. MISCELLANEOUS",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n1. THE APPLICATION",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSOLO CONNECKT (\"Licensed Application\") is a piece of software created to Social Media and communication App — and customized for iOS and Android mobile devices (\"Devices\"). It is used to Social Media and communication App.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n2. SCOPE OF LICENSE",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n2.1 You are given a non-transferable, non-exclusive, non-sublicensable license to install and use the Licensed Application on any Devices that You (End-User) own or control and as permitted by the Usage Rules, with the exception that such Licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.2.2 This license will also govern any updates of the Licensed Application provided by Licensor that replace, repair, and/or supplement the first Licensed Application, unless a separate license is provided for such update, in which case the terms of that new license will govern. \n2.3 You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with SOLO CONNECKT LLC's prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application.\n2.4 You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with SOLO CONNECKT LLC's prior written consent).\n2.5 You may not copy (excluding when expressly authorized by this license and the Usage Rules) or alter the Licensed Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this license, the Usage Rules, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorized third parties may gain access to these copies at any time. If you sell your Devices to a third party, you must remove the Licensed Application from the Devices before doing so.\n2.6 Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages.\n2.7 Licensor reserves the right to modify the terms and conditions of licensing.\n2.8 Nothing in this license should be interpreted to restrict third-party terms. When using the Licensed Application, You must ensure that you comply with applicable third-party terms and conditions.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n3. TECHNICAL REQUIREMENTS",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n3.1 Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n4. MAINTENANCE AND SUPPORT",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n4.1 The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the App Store or Play Store Overview for this Licensed Application.\n4.2 SOLO CONNECKT LLC and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n5. USE OF DATA",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nYou acknowledge that Licensor will be able to access and adjust Your downloaded Licensed Application content and Your personal information, and that Licensor's use of such material and information is subject to Your legal agreements with Licensor and Licensor's privacy policy: https://www.soloconneckt.com/privacypolicyl.You acknowledge that the Licensor may periodically collect and use technical data and related information about your device, system, and application software, and peripherals, offer product support, facilitate the software updates, and for purposes of providing other services to you (if any) related to the Licensed Application. Licensor may also use this information to improve its products or to provide services or technologies to you, as long as it is in a form that does not personally identify you.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n6. USER-GENERATED CONTRIBUTIONS",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe Licensed Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Licensed Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, \"Contributions\"). Contributions may be viewable by other users of the Licensed Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:\n1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party. \n2. You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Licensed Application, and other users of the Licensed Application to use your Contributions in any manner contemplated by the Licensed Application and this License Agreement. \n3. You have the written consent, release, and/or permission of each and every identifiable individual person in your contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your contributions in any manner contemplated by the Licensed Application and this License Agreement. \n4. Your Contributions are not false, inaccurate, or misleading. \n5. Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation. \n6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us).\n7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone. \n8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people. \n9. Your Contributions do not violate any applicable law, regulation, or rule.\n10. Your Contributions do not violate the privacy or publicity rights of any third party. \n11. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors. \n12. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.\n13. Your Contributions do not otherwise violate, or link to material that violates, any provision of this License Agreement, or any applicable law or regulation.\nAny use of the Licensed Application in violation of the foregoing violates this License Agreement and may result in, among other things, termination or suspension of your rights to use the Licensed Application.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n7. CONTRIBUTION LICENSE",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nBy posting your Contributions to any part of the Licensed Application or making Contributions accessible to the Licensed Application by linking your account from the Licensed Application to any of your social networking accounts, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and license to host, use copy, reproduce, disclose, sell, resell, publish, broad cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and grant and authorize sublicenses of the foregoing. The use and distribution may occur in any media formats and through any media channels.This license will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your contributions.We do not assert any ownership over your contributions. You retain full ownership of all of your contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your contributions provided by you in any area in the Licensed Application. You are solely responsible for your contributions to the Licensed Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to recategorize any Contributions to place them in more appropriate locations in the Licensed Application; and (3) to prescreen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n8. LIABILITY",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n8.1 Licensor takes no accountability or responsibility for any damages caused due to a breach of duties according to Section 2 of this License Agreement. To avoid data loss, You are required to make use of backup functions of the Licensed Application to the extent allowed by applicable third-party terms and conditions of use. You are aware that in case of alterations or manipulations of the Licensed Application, You will not have access to the Licensed Application.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n9. WARRANTY",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n9.1 Licensor warrants that the Licensed Application is free of spyware, trojan horses, viruses, or any other malware at the time of your download. Licensor warrants that the Licensed Application works as described in the user documentation.\n9.2 No warranty is provided for the Licensed Application that is not executable on the device, that has been unauthorizedly modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of SOLO CONNECKT LLC's sphere of influence that affect the executability of the Licensed Application.\n9.3 You are required to inspect the Licensed Application immediately after installing it and notify SOLO CONNECKT LLC about issues discovered without delay by email provided in Product Claims. The defect report will be taken into consideration and further investigated if it has been emailed within a period of ninety (90) days after discovery.\n9.4 If we confirm that the Licensed Application is defective, SOLO CONNECKT LLC reserves a choice to remedy the situation either by means of solving the defect or substitute delivery.\n9.5 In the event of any failure of the Licensed Application to conform to any applicable warranty, You may notify the Services Store Operator, and Your Licensed Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the Services Store Operator will have no other warranty obligation whatsoever with respect to the Licensed Application, and any other losses, claims, damages, liabilities, expenses, and costs attributable to any negligence to adhere to any warranty.\n9.6 If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Licensed Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n10. PRODUCT CLAIMS",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSOLO CONNECKT LLC and the End-User acknowledge that SOLO CONNECKT LLC, and not the Services, is responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the End-User's possession and/or use of that Licensed Application, including, but not limited to:\n(i) product liability claims;\n(ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and \n(iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application's use of the Health Kit and HomeKit.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n11. LEGAL COMPLIANCE",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nYou represent and warrant that you are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a \"terrorist supporting\" country, and that you are not listed on any US Government list of prohibited or restricted parties.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n12. CONTACT INFORMATION",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nFor general inquiries, complaints, questions or claims concerning the Licensed Application, please contact:\nDecarlos Sanders Business address: 6600 SE 74th Okc, ok 73135 EIN: 88-0768809_, OK United States Decarlos.sanders@gmail.com",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n13. TERMINATION",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe license is valid until terminated by SOLO CONNECKT LLC or by You. Your rights under this license will terminate automatically and without notice from SOLO CONNECKT LLC if You fail to adhere to any term(s) of this license. Upon License termination, You shall stop all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSOLO CONNECKT LLC represents and warrants that SOLO CONNECKT LLC will comply with applicable third-party terms of agreement when using Licensed Application.\n\nIn Accordance with Section 9 of the \"Instructions for Minimum Terms of Developer's End-User License Agreement,\" both Apple and Google and their subsidiaries shall be third-party beneficiaries of this End User License Agreement and — upon Your acceptance of the terms and conditions of this License Agreement, both Apple and Google will have the right (and will be deemed to have accepted the right) to enforce this End User License Agreement against you as a third-party beneficiary thereof.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n15. INTELLECTUAL PROPERTY RIGHTS",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSOLO CONNECKT LLC and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User's possession and use of that Licensed Application infringes on the third party's intellectual property rights, SOLO CONNECKT LLC, and not the Services, will be solely responsible for the investigation, defense, settlement, and discharge or any such intellectual property infringement claims.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n16. APPLICABLE LAW",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThis License Agreement is governed by the laws of the State of Oklahoma excluding its conflicts of law rules.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\n17. MISCELLANEOUS",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n17.1 If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose.\n\n17.2 Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing.\n\n17.3 There is no tolerance for objectionable content or abusive users. User profile will be deleted immediately if user posts any irrelevant content. Other users can report such user who is posting or posted such irrelevant content our system will automatically block that user and delete their posts and account. You can block other mis-behaving and abusing users and report their posts and content us from app and give username of that user so we can take action against him.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
