import 'package:aec_medical/api/repository/auth_repo.dart';
import 'package:aec_medical/custom/custom_button.dart';
import 'package:aec_medical/pages/authentication/otp_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInWithMobileNumberPage extends StatefulWidget {
  const SignInWithMobileNumberPage({Key? key}) : super(key: key);

  @override
  _SignInWithMobileNumberPageState createState() =>
      _SignInWithMobileNumberPageState();
}

class _SignInWithMobileNumberPageState
    extends State<SignInWithMobileNumberPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();
  bool _isLoad = false;
  void _trySubmit()async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoad = true;
      });
      AuthRepo authRepo = new AuthRepo();
      await authRepo.loginWithOtp(_mobile.text);
      setState(() {
        _isLoad = false;
      });}}

  bool isChecked = true;

  TextEditingController numbers = TextEditingController();
  TextEditingController phoneCode = TextEditingController();

  List _currencies = [
    "+91",
    "+92",
    "+358",
    "+1",
  ];


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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        _logo(),
                        SizedBox(height: 50),
                        _welcometext(),
                        SizedBox(height: 30),
                        _numberfield(),
                       if(_isLoad)
                         CircularProgressIndicator()
                            else _continuebutton(),
                        SizedBox(height: 10),
                      ])),
                ))));
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

  _welcometext() {
    return Column(
      children: [
        SizedBox(height: 100),
        Text(
          Strings.SIGNIN_WITH_MOBILE_HEADLINE1,
          style: StringsStyle.signinwithmobileheadline1style,
        ),
        SizedBox(height: 5),
        Text(
          Strings.SIGNIN_WITH_MOBILE_HEADLINE2,
          style: StringsStyle.signinwithmobileheadline2style,
        ),
      ],
    );
  }

  _numberfield() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          // height: 50,
          // width: Get.width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 1),
            child: Row(
              children: [
                Container(
                  // height: 45,
                  // width: 120,
                  child: CountryCodePicker(
                    onChanged: print,
                    initialSelection: 'IN',
                    favorite: ['+19', 'IN'],
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: false,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    controller: _mobile,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter mobile number";
                      } else if (value.length < 10) {
                        return "Mobile number have must be atleast 10 digits";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      labelStyle: new TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                // Icon(
                //   Icons.clear,
                //   color: Colors.grey,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _continuebutton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
          onTap: _trySubmit,
          child: CustomButton(
              text1: "", text2: "Continue", width: Get.width, height: 50)),
    );
  }
}
