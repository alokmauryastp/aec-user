import 'package:aec_medical/api/repository/home_repo.dart';
import 'package:aec_medical/model/homeModel/Counselling/blog_model.dart';
import 'package:aec_medical/pages/dashboard/drawer/total_health/health_description_page.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:aec_medical/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthBlogsTipsPage extends StatefulWidget {
  const HealthBlogsTipsPage({Key? key}) : super(key: key);

  @override
  _HealthBlogsTipsPageState createState() => _HealthBlogsTipsPageState();
}

class _HealthBlogsTipsPageState extends State<HealthBlogsTipsPage> {

  late List<BlogData> blogData = [];

  @override
  void initState() {
    print("******this is the page");
    super.initState();
    HomeRepo homeRepo = new HomeRepo();
    Future future = homeRepo.blogApi();
    future.then((value) {
      setState(() {
        blogData = value;
        print("kktitle" + blogData[0].title.toString());
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 30,
          ),
        ),
        backgroundColor: AppColors.appbarbackgroundColor,
        title: Text(Strings.HEALTHBLOG,
            style: TextStyle(
                color: AppColors.whitetextColor,
                fontSize: 16,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(blogData.isNull)
              Center(child: Container(
                  height: 250,
                  alignment: Alignment.center,
                  child: Text("Sorry! No Data Found.")))
            else  if(blogData.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(Strings.HEALTHBLOG,
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppColors.appbarbackgroundColor),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: blogData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: InkWell(
                              onTap: (){
                                Get.to(HealthBlogAndTipsDescriptionPage(),arguments: blogData[index].blogId.toString());
                              },
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 120,
                                              width: Get.width/1.1,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(blogData[index].image),
                                                    fit: BoxFit.fill
                                                ),
                                              )),


                                          SizedBox(height: 8),
                                          Text(blogData[index].title,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors.appbarbackgroundColor,
                                                    child:  Image.asset("assets/images/logo.png",
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(blogData[index].author,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      )),
                                                  // SizedBox(width: 16),
                                                ],

                                              ),
                                              Text(blogData[index].timeAgo,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          );

                        }),
                  ),
                ],
              ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
