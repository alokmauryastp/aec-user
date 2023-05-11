import 'package:aec_medical/api/repository/account_settions_repo.dart';
import 'package:aec_medical/model/tpa_model.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {


  List<TPAModel> tPAModel = [];

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    AccountSettingsRepo accountSettingsRepo = new AccountSettingsRepo();
    Future future = accountSettingsRepo.tpaApi();
    future.then((value) {
      setState(() {
        tPAModel = value;
        print("kktitle" + tPAModel[0].data.termCondiion);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whitetextColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.PRIVACYPOLICYTITLE,
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: Center(
        child: tPAModel.isEmpty?SizedBox(): Container(
               // height: Get.height,
               child: WebView(
                initialUrl: tPAModel[0].data.privacyPolicy,
                javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
        ));
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5),
        Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png")))),
        Text(
          Strings.LOGO_TITLE,
          style: StringsStyle.redlogotitlestyle,
        ),
      ],
    );
  }

  _middilebanner() {
    return SizedBox(
      width: Get.width,
      child: Card(
          color: AppColors.appbarbackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(Strings.BANNERTEXT,
                  style: TextStyle(
                    color: AppColors.whitetextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),
            ),
          )),
    );
  }

  _description() {
    return Expanded(
      child: Container(
        height: Get.height,
        child: WebView(
          initialUrl: tPAModel[0].data.privacyPolicy,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
