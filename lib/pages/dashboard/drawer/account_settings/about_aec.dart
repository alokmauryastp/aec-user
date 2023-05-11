import 'package:aec_medical/api/repository/account_settions_repo.dart';
import 'package:aec_medical/model/tpa_model.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
          title: Text("About us",
            style: StringsStyle.pagetitlestyle,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
        ),
        body: Center(
          child: tPAModel.isEmpty? SizedBox(): Container(
            // height: Get.height,
            child: WebView(
              initialUrl: tPAModel[0].data.aboutUs.replaceAll('/apollo/AboutUs/about', '/AboutUs/about'),
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
              child: Text("Apollo E-clinic About us",
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
    return Container(
      height: 1000,
      child: WebView(
        initialUrl: tPAModel[0].data.aboutUs,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
// _description() {
//   return Column(children: [
//     Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
//       child: Text(
//           "asda dasdada bhda asdna esa ds adc zXf zXce zsc de zs tyh , kscn aksf l zcke zxcn ithpoerp dkl asfiojpasdf dfs asfpeo zsfdclkdsof zslfjodr a sdjna askj dakj aer kdajk kajsdkaj jhdk ajsdja adj ajsdjk jakj  aueasd kjasdajk c asd akasdhakr ajaskjasdfakj asjdbajhsda ",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 15,
//           )),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Text(
//           "asda dasdada bhda asdna esa ds adc zXf zXce zsc de zs tyh , kscn aksf l zcke zxcn ithpoerp dkl asfiojpasdf dfs asfpeo zsfdclkdsof zslfjodr a sdjna askj dakj aer kdajk kajsdkaj jhdk ajsdja adj ajsdjk jakj  aueasd kjasdajk c asd akasdhakr ajaskjasdfakj asjdbajhsda ",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 15,
//           )),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Text(
//           "asda dasdada bhda asdna esa ds adc zXf zXce zsc de zs tyh , kscn aksf l zcke zxcn ithpoerp dkl asfiojpasdf dfs asfpeo zsfdclkdsof zslfjodr a sdjna askj dakj aer kdajk kajsdkaj jhdk ajsdja adj ajsdjk jakj  aueasd kjasdajk c asd akasdhakr ajaskjasdfakj asjdbajhsda ",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 15,
//           )),
//     ),
//   ]);
// }
}
