import 'package:flutter/material.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Views/CreateAccount/index.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Privacy Policy",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "Who we are",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\n\nSolo Conneckt LLC built the Solo Conneckt app as a Free app. This SERVICE is provided by Solo Conneckt LLC at no cost and is intended for use as is.\nThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Solo Conneckt unless otherwise defined in this Privacy Policy.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "Suggested text: Our website address is: https://www.soloconneckt.com.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nInterpretation and Definitions",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nInterpretation",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nDefinitions",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "For the purposes of this End-User License Agreement:",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nDefinitions",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      "\nAgreement ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "means this End-User License Agreement that forms the entire agreement between You and the Company regarding the use of the Application. This Agreement has been created with the help of the EULA Generator.",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nApplication ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "means the software program provided by the Company downloaded by You to a Device, named Solo Conneckt",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nCompany ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "(referred to as either “the Company”, “We”, “Us” or “Our” in this Agreement) refers to Solo Conneckt LLC.",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nContent ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "refers to content such as text, images, or other information that can be posted, uploaded, linked to or otherwise made available by You, regardless of the form of that content.",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nCountry  ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "refers to: North Dakota, United States",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nDevice ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "means any device that can access the Application such as a computer, a cellphone or a digital tablet.",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nThird-Party Services",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "means any services or content (including data, information, applications and other products services) provided by a third-party that may be displayed, included or made available by the Application.",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "\nYou ",
                      style: ThemeHelper().TextStyleMethod2(
                        16,
                        context,
                        FontWeight.w600,
                        Colors.black,
                      ),
                    ),
                    Text(
                      "means the individual accessing or using the Application or the company, or other legal entity on behalf of which such individual is accessing or using the Application, as applicable.",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\nAcknowledgment",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nBy clicking the “I Agree” button, downloading or using the Application, You are agreeing to be bound by the terms and conditions of this Agreement. If You do not agree to the terms of this Agreement, do not click on the “I Agree” button, do not download or do not use the Application.\nThis Agreement is a legal document between You and the Company and it governs your use of the Application made available to You by the Company.\nThe Application is licensed, not sold, to You by the Company for use strictly in accordance with the terms of this Agreement.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nLicense",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nScope of License",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe Company grants You a revocable, non-exclusive, non-transferable, limited license to download, install and use the Application strictly in accordance with the terms of this Agreement.\n\nThe license that is granted to You by the Company is solely for your personal, non-commercial purposes strictly in accordance with the terms of this Agreement.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nThird-Party Services",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe Application may display, include or make available third-party content (including data, information, applications and other products services) or provide links to third-party websites or services.\n\nYou acknowledge and agree that the Company shall not be responsible for any Third-party Services, including their accuracy, completeness, timeliness, validity, copyright compliance, legality, decency, quality or any other aspect thereof. The Company does not assume and shall not have any liability or responsibility to You or any other person or entity for any Third-party Services.\n\nYou must comply with applicable Third parties’ Terms of agreement when using the Application. Third-party Services and links thereto are provided solely as a convenience to You and You access and use them entirely at your own risk and subject to such third parties’ Terms and conditions.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nTerm and Termination",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThis Agreement shall remain in effect until terminated by You or the Company. The Company may, in its sole discretion, at any time and for any or no reason, suspend or terminate this Agreement with or without prior notice.\n\nThis Agreement will terminate immediately, without prior notice from the Company, in the event that you fail to comply with any provision of this Agreement. You may also terminate this Agreement by deleting the Application and all copies thereof from your Device or from your computer.\n\nUpon termination of this Agreement, You shall cease all use of the Application and delete all copies of the Application from your Device.\n\nTermination of this Agreement will not limit any of the Company’s rights or remedies at law or in equity in case of breach by You (during the term of this Agreement) of any of your obligations under the present Agreement.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nIndemnification",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nYou agree to indemnify and hold the Company and its parents, subsidiaries, affiliates, officers, employees, agents, partners and licensors (if any) harmless from any claim or demand, including reasonable attorneys’ fees, due to or arising out of your: (a) use of the Application; (b) violation of this Agreement or any law or regulation; or (c) violation of any right of a third party.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nNo Warranties",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe Application is provided to You “AS IS” and “AS AVAILABLE” and with all faults and defects without warranty of any kind. To the maximum extent permitted under applicable law, the Company, on its own behalf and on behalf of its affiliates and its and their respective licensors and service providers, expressly disclaims all warranties, whether express, implied, statutory or otherwise, with respect to the Application, including all implied warranties of merchantability, fitness for a particular purpose, title and non-infringement, and warranties that may arise out of course of dealing, course of performance, usage or trade practice. Without limitation to the foregoing, the Company provides no warranty or undertaking, and makes no representation of any kind that the Application will meet your requirements, achieve any intended results, be compatible or work with any other software, applications, systems or services, operate without interruption, meet any performance or reliability standards or be error free or that any errors or defects can or will be corrected.\n\nWithout limiting the foregoing, neither the Company nor any of the company’s provider makes any representation or warranty of any kind, express or implied: (i) as to the operation or availability of the Application, or the information, content, and materials or products included thereon; (ii) that the Application will be uninterrupted or error-free; (iii) as to the accuracy, reliability, or currency of any information or content provided through the Application; or (iv) that the Application, its servers, the content, or e-mails sent from or on behalf of the Company are free of viruses, scripts, trojan horses, worms, malware, timebombs or other harmful components.\n\nSome jurisdictions do not allow the exclusion of certain types of warranties or limitations on applicable statutory rights of a consumer, so some or all of the above exclusions and limitations may not apply to You. But in such a case the exclusions and limitations set forth in this section shall be applied to the greatest extent enforceable under applicable law. To the extent any warranty exists under law that cannot be disclaimed, the Company shall be solely responsible for such warranty.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nLimitation of Liability",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nNotwithstanding any damages that You might incur, the entire liability of the Company and any of its suppliers under any provision of this Agreement and your exclusive remedy for all of the foregoing shall be limited to the amount actually paid by You for the Application or through the Application or 100 USD if You haven’t purchased anything through the Application.\n\nTo the maximum extent permitted by applicable law, in no event shall the Company or its suppliers be liable for any special, incidental, indirect, or consequential damages whatsoever (including, but not limited to, damages for loss of profits, loss of data or other information, for business interruption, for personal injury, loss of privacy arising out of or in any way related to the use of or inability to use the Application, third-party software and/or third-party hardware used with the Application, or otherwise in connection with any provision of this Agreement), even if the Company or any supplier has been advised of the possibility of such damages and even if the remedy fails of its essential purpose.\n\nSome states/jurisdictions do not allow the exclusion or limitation of incidental or consequential damages, so the above limitation or exclusion may not apply to You.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nSeverability and Waiver",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSeverability",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nIf any provision of this Agreement is held to be unenforceable or invalid, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nWaiver",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nExcept as provided herein, the failure to exercise a right or to require performance of an obligation under this Agreement shall not effect a party’s ability to exercise such right or require such performance at any time thereafter nor shall the waiver of a breach constitute a waiver of any subsequent breach.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nProduct Claims",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe Company does not make any warranties concerning the Application.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nUnited States Legal Compliance",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nYou represent and warrant that\n\n(i) You are not located in a country that is subject to the United States government embargo, or that has been designated by the United States government as a “terrorist supporting” country\n\n(ii) You are not listed on any United States government list of prohibited or restricted parties.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nGoverning Law",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe laws of the Country, excluding its conflicts of law rules, shall govern this Agreement and your use of the Application. Your use of the Application may also be subject to other local, state, national, or international laws.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nUsage Precautions",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nAbusive or Hateful Content",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nNo harmful or abusive content or comments to creators or other users are allowed. This includes disclosure of personal information (real name, contact information, address, social security number, etc.). This includes the use of symbols in malicious expressions without meaningful context.\n\n Content or comments of hatred that encourages or encourages violence are primarily based on race, ethnicity, religion, disability, gender, age, veteran status, sexual orientation, gender identity, political orientation, etc. Or it is intended to incite hatred for the group. prohibited.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nCopyright",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nCopyrighted material may not be published, distributed, or transmitted without the consent of the copyright holder. This includes posting or distributing links to pirated content from another website or service. Any unauthorized content you share on SOLO CONNECKT may be removed by the rights-holder(s) to remove the infringing content.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nMature or Sexual Content",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nContent with nudity or sexual gratification is not allowed. This includes, but is not limited to, full and partial nudity and graphic depictions of sexual acts.\n\n The “Mature Content Warning” feature should be used to identify adult topics and content, including those related to sex. Please note, however, that using the “Mature Content Warning” feature does not mean that nudity or pornography is allowed on the platform.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nViolent or Graphic Content",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nWe don’t allow explicit depictions of gratuitous violence or content that incites violence. Here are examples of prohibited content:\n\n • Violent, prolonged and apparent violence\n\n • Showing sadism, or glorifying/advocating hurting others \n\n • Praise or promote self-harm",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nDangerous or Illegal Content",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nContent that promotes, promotes, or instigates harmful or illegal activities is not permitted. Examples of dangerous or illegal content include, but are not limited to:\n\n • Spreading misinformation\n\n • Content with  incest and grooming themes\n\n • Praising or promoting illegal substances or drug use",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nSpam and Advertising",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nPosting unsolicited or unsolicited content or links is not permitted. This includes creating profiles or uploading content whose primary purpose is to drive traffic to external websites. Unsolicited or solicited content or links are not allowed. This includes creating profiles or uploading content whose primary purpose is to drive traffic to external websites. Grant volumes that are pre-approved in writing by SOLO CONNECKT  must be identified as such to avoid deletion. Sponsored episodes must be identified as such to avoid deletion. Using automated means to increase views or perform social interactions, or creating multiple accounts to increase views or perform social media interactions will result in suspension or termination. account.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nPotentially Unlawful Content",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nWe reserve the right to remove content and disciplinary action that, in our sole discretion, is potentially illegal. Examples of potentially illegal conduct or content include (i) defamatory content, (ii)  false or misleading content, (iii) content that violates another’s privacy, and (iii) repeatedly or severely harassing other users through the Service.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nReporting Inappropriate Content",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nReporting Comments and Posts",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nTo report a comment, post, or other creator profile content that violates this policy or our Terms of Service, click the “Report” link under each comment or the “more” button on the current post or creator profile. Reported material will be reviewed by our moderation team, and comments, posts, or other content from creator profiles that violate our policies will be removed.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nReporting Series and Episodes",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nTo report episodes that violate our content guidelines, click the “Report” button at the bottom of each episode.\n\nVolumes with multiple reports may be automatically deleted until the further review is available. If the same episode or series is reported multiple times and we determine that the reporting is warranted, the episode or series may be removed and users will receive a warning about inappropriate content.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nCopyright Infringement",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nProcess for Reporting Copyright Infringement",
                style: ThemeHelper().TextStyleMethod2(
                  16,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nIf you believe a user`s content violates your copyright or if you are the legal representative to represent the copyright holder, you may send a takedown notice to contact@soloconneckt.com with the following information. These requests should only be submitted by the copyright owner or an agent authorized to act on the owner`s behalf.  1. Materials that prove that the person is the copyright holder;\n\n 2. The specific URL of the infringing content on SOLO CONNECKT;\n\n 3. A statement that:\n\n You believe that the use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.\n\n The information in this notice is correct and for perjury, penalties are incurred, you are the owner or authorized representative on behalf of the owner of the monopoly allegedly infringed.  4. Information from the copyright owner or legal representative sufficient to permit SOLO CONNECKT to contact you, such as an address, phone number, or e-mail address\n\n 5. Signature of the copyright owner or the copyright owner’s legal representative (entering your full legal name is enough)\n\n Once we receive a valid takedown notice, we will immediately remove the content in question and notify the user. If we don’t get a response from the user within 14 days, the content will still be blocked.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nCounter-notice",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nIf you believe that the content that has been removed is not infringed, or if you are authorized by the copyright owner, the copyright owner’s agent, or by law, you may submit a counter-notice to  contact@soloconneckt.com us with the following information.\n\n1. Identification of the removed content and the specific URL of the content on SOLO CONNECKT;\n\n 2. A statement that:\n\n You have a good faith belief that the Content has been removed or disabled by mistake or misidentification;\n\n You agree to the jurisdiction of the Federal District Court for the jurisdiction in which your address is located, and you will accept processing services from the person who provided the original DMCA notice or from the person’s representative. there. 3. Your name, address, phone number, and email address\n\n 4. Your physical or electronic signature (entering your full legal name is enough)\n\n Upon receipt of a valid counter-notice, we may forward it to the notifying party that submitted the original notice of copyright infringement. Thereafter, the original notifying party will have 10 days to file a lawsuit over the alleged infringing material. Notice to prevent legal action, the deleted content may be replaced in 10 business days or more at SOLO CONNECKT’s sole discretion.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nViolations of this Policy",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nNotwithstanding any remedies available to us in the Terms of Service, we reserve the right to take any action we deem appropriate in response to violations of this Policy. Users who violate this policy may be suspended from posting or submitting User Posts (temporarily or permanently) or have their account and access to the Service suspended or terminated.  While we generally strive to notify users in advance of the actions we are taking in response to policy violations, we may choose not to do so at our sole discretion. Accordingly, violations of this Policy or the Terms of Service may result in the permanent loss of User Submissions and other Content previously accessed through the Service. If your content has been removed or suspended for policy violations, you can contact our Creator Support team at contact@soloconneckt.com. Please note, however, that we do not offer a complaint process for actions we take in violation of this policy.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nEntire Agreement",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThe Agreement constitutes the entire agreement between You and the Company regarding your use of the Application and supersedes all prior and contemporaneous written or oral agreements between You and the Company.\n\nYou may be subject to additional terms and conditions that apply when You use or purchase other Company’s services, which the Company will provide to You at the time of such use or purchase.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nInformation Collection and Use",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nFor a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Email. The information that we request will be retained by us and used as described in this privacy policy.\n\nThe app does use third-party services that may collect information used to identify you.\n\nLink to the privacy policy of third-party service providers used by the app\n\nGoogle Play Services",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\Log Data",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nWe want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nService Providers",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nWe may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nWe want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nSecurity",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nWe value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nLinks to Other Sites",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThis Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nChildren’s Privacy",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nThese Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nComments",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor’s IP address and browser user agent string to help spam detection.\n\nAn anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nMedia",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nCookies",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.\n\nIf you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.\n\nWhen you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select “Remember Me”, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.\n\nIf you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.\n\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nEmbedded content from other websites",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.\n\nThese websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nWho we share your data with",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: If you request a password reset, your IP address will be included in the reset email.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nHow long we retain your data",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.\n\nFor users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nWhat rights you have over your data",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nWhere we send your data",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nSuggested text: Visitor comments may be checked through an automated spam detection service.",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nChanges to This Privacy Policy",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nWe may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2022-05-04",
                style: ThemeHelper().TextStyleMethod2(
                  12,
                  context,
                  FontWeight.normal,
                  Colors.black,
                ),
              ),
              Text(
                "\nTerms And Condition",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "\nTo check our END USER LICENSE AGREEMENT (EULA)",
                      style: ThemeHelper().TextStyleMethod2(
                        12,
                        context,
                        FontWeight.normal,
                        Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateAccount()),
                        );
                      },
                      child: Text(
                        "click here",

                        // : TextDecoration.underline,
                        style: ThemeHelper().TextStyleMethod2(
                          12,
                          context,
                          FontWeight.normal,
                          Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "\nContact Us",
                style: ThemeHelper().TextStyleMethod2(
                  20,
                  context,
                  FontWeight.w600,
                  Colors.black,
                ),
              ),
              Text(
                "\nIf you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at contact@soloconneckt.com",
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
