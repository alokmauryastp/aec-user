import 'package:aec_medical/api/AppConstant.dart';
import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/api/sharedprefrence.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/pages/authentication/sign_in_with_mobile_number_page.dart';
import 'package:aec_medical/pages/dashboard/drawer/account_settings/terms_of_use_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _isLogin = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoad = false;

  void _glogin() async {
      setState(() {
        _isLoad = true;
      });
      _googleSignIn.signIn().then((userData) async {
          // if( _isLogin = true) {
            _userObj = userData!;
          await  SharedPrefManager.savePrefString(AppConstant.IMAGE, _userObj.photoUrl.toString());
          await  SharedPrefManager.savePrefString(AppConstant.EMAIL, _userObj.email);
          await  SharedPrefManager.savePrefString(AppConstant.NAME, _userObj.displayName.toString());
          // await SharedPrefManager.savePreferenceBoolean(true);
            String name = await SharedPrefManager.getPrefrenceString(AppConstant.NAME);
            String email = await SharedPrefManager.getPrefrenceString(AppConstant.EMAIL);
            String photo = await SharedPrefManager.getPrefrenceString(AppConstant.IMAGE);
            print(name + " hddj " + email + " sshshs " + photo + " hdhddhd");

            AuthRepo authRepo = new AuthRepo();
            await  authRepo.googleLoginApi();


      }).catchError((e){
        print ("google login error");
        print(e);

      });
      setState(() {
        _isLoad = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      _logo(),
                      _welcometext(),
                      SizedBox(height: 10),
                      _signinoption(),
                      SizedBox(height: 30),
                      _termsandconditionsbanner(),
                    ],
                  ),
                ),
              ))),
    );
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5),
        Container(
            height: 190,
            width: 190,
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

  _welcometext() {
    return Column(
      children: [
        SizedBox(height: 100),
        Text(
          Strings.SIGNIN_HEADLINE1,
          style: StringsStyle.signinheadline1style,
        ),
        SizedBox(height: 5),
        Text(
          Strings.SIGNIN_HEADLINE2,
          style: StringsStyle.signinheadline2style,
        ),
      ],
    );
  }

  _signinoption() {
    return Column(children: [
      SizedBox(height: 10),
      // ignore: deprecated_member_use
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: () {
            Get.to(SignInWithMobileNumberPage(),
                transition: Transition.rightToLeftWithFade,
                duration: Duration(milliseconds: 600));
          },
          child: CustomButton(
              text2: Strings.SIGNIN_WITH_MOBILE,
              text1: '',
              width: Get.width,
              height: 50),
        ),
      ),
      SizedBox(height: 20),
      Text(Strings.OR),
      SizedBox(height: 20),
      // ignore: deprecated_member_use
      if(_isLoad)
        CircularProgressIndicator()
      else Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: _glogin,
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white60,
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: Get.width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/googleicon.png"))),
                    ),
                    Center(
                      child: Text(Strings.SIGNIN_WITH_GOOGLE,
                          style: StringsStyle.signinwithgoogle),
                    ),
                  ],
                ),
              )),
        ),
      ),
      // SizedBox(height: 12),
      // // ignore: deprecated_member_use
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 15),
      //   child: InkWell(
      //     onTap: () {
      //       //Get.to(PrefferredLanguagePickerPage());
      //     },
      //     child: CustomButton(
      //         text1: Strings.F,
      //         text2: Strings.SIGNIN_WITH_FACEBOOK,
      //         width: Get.width,
      //         height: 50),
      //   ),
      // )
    ]);
  }

  _termsandconditionsbanner() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Text(
        Strings.TERMS_AND_CONDITION_BANNER_TEXT,
        style: TextStyle(fontSize: 11),
      ),
      InkWell(
        onTap: () {
          Get.to(TermsOfUsePage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: Text(Strings.TERMS_AND_CONDITION_BANNER_SUBTEXT,
            style: StringsStyle.termsandconditionbanner),
      ),
    ]);
  }
}
