// // @dart=2.9
// import 'package:flutter/material.dart';
//
//
// class SliderModel{
//   String icon;
//   String imageAssetPath;
//   String title;
//   String desc;
//
//   SliderModel({this.icon,this.imageAssetPath,this.title,this.desc});
//
//   void setIcon(String getIcon){
//     icon = getIcon;
//   }
//
//   void setImageAssetPath(String getImageAssetPath){
//     imageAssetPath = getImageAssetPath;
//   }
//
//   void setTitle(String getTitle){
//     title = getTitle;
//   }
//
//   void setDesc(String getDesc){
//     desc = getDesc;
//   }
//
//   String getIcon(){
//     return icon;
//   }
//
//   String getImageAssetPath(){
//     return imageAssetPath;
//   }
//
//   String getTitle(){
//     return title;
//   }
//
//   String getDesc(){
//     return desc;
//   }
//
// }
//
//
// List<SliderModel> getSlides(){
//
//   List<SliderModel> slides = new List<SliderModel>();
//   SliderModel sliderModel = new SliderModel();
//
//   //1
//   sliderModel.setIcon("assets/images/logo.png");
//   sliderModel.setDesc("Consultaon");
//   sliderModel.setTitle("High Quality Online");
//   sliderModel.setImageAssetPath("assets/images/onboard1.png");
//   slides.add(sliderModel);
//
//   sliderModel = new SliderModel();
//
//   //2
//   sliderModel.setIcon("assets/images/logo.png");
//   sliderModel.setDesc("Health");
//   sliderModel.setTitle("Dedicated to total");
//   sliderModel.setImageAssetPath("assets/images/onboard2.png");
//   slides.add(sliderModel);
//
//   sliderModel = new SliderModel();
//
//   //3
//   sliderModel.setIcon("assets/images/logo.png");
//   sliderModel.setDesc("Your Home");
//   sliderModel.setTitle("Comfort of");
//   sliderModel.setImageAssetPath("assets/images/onboard3.png");
//   slides.add(sliderModel);
//   sliderModel = new SliderModel();
//
//   return slides;
// }
//
//
//
// // class UnbordingContent {
// //   String image;
// //   String title;
// //   String discription;
// //
// //   UnbordingContent(
// //       {required this.image, required this.title, required this.discription});
// // }
// //
// // List<UnbordingContent> contents = [
// //   UnbordingContent(
// //       image: 'assets/images/onboard1.png',
// //       title: 'Easy Shopping',
// //       discription:
// //           "All in one shopping website that provides 100% quality with huge"
// //           "discount and easy shopping site the carrer ads."),
// //   UnbordingContent(
// //       image: 'assets/images/onboard2.png',
// //       title: 'Secure Payment',
// //       discription:
// //           "The career ads endues a secure payment platform and your all credentials information"
// //           "is private with online payment gateway."),
// //   UnbordingContent(
// //       image: 'assets/images/onboard3.png',
// //       title: 'Quick Delivery',
// //       discription:
// //           "Customer satisfaction with high quality products that gives a quick"
// //           "delivery option without any delay with 100% free service."),
// // ];
// @dart=2.9
import 'package:flutter/material.dart';


class SliderModel{
  String icon;
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.icon,this.imageAssetPath,this.title,this.desc});

  void setIcon(String getIcon){
    icon = getIcon;
  }

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getIcon(){
    return icon;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setIcon("assets/images/logo.png");
  sliderModel.setDesc("Consultaon");
  sliderModel.setTitle("High Quality Online");
  sliderModel.setImageAssetPath("assets/images/onboard1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setIcon("assets/images/logo.png");
  sliderModel.setDesc("Health");
  sliderModel.setTitle("Dedicated to total");
  sliderModel.setImageAssetPath("assets/images/onboard2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setIcon("assets/images/logo.png");
  sliderModel.setDesc("Your Home");
  sliderModel.setTitle("Comfort of");
  sliderModel.setImageAssetPath("assets/images/onboard3.png");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  return slides;
}



// class UnbordingContent {
//   String image;
//   String title;
//   String discription;
//
//   UnbordingContent(
//       {required this.image, required this.title, required this.discription});
// }
//
// List<UnbordingContent> contents = [
//   UnbordingContent(
//       image: 'assets/images/onboard1.png',
//       title: 'Easy Shopping',
//       discription:
//           "All in one shopping website that provides 100% quality with huge"
//           "discount and easy shopping site the carrer ads."),
//   UnbordingContent(
//       image: 'assets/images/onboard2.png',
//       title: 'Secure Payment',
//       discription:
//           "The career ads endues a secure payment platform and your all credentials information"
//           "is private with online payment gateway."),
//   UnbordingContent(
//       image: 'assets/images/onboard3.png',
//       title: 'Quick Delivery',
//       discription:
//           "Customer satisfaction with high quality products that gives a quick"
//           "delivery option without any delay with 100% free service."),
// ];
