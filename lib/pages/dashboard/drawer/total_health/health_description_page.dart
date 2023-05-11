import 'package:aec_medical/api/repository/healthBlogTipsDescription_repo.dart';
import 'package:aec_medical/model/healthBlogTipsDescription.dart';
import 'package:aec_medical/utils/colors.dart';
import 'package:aec_medical/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

class HealthBlogAndTipsDescriptionPage extends StatefulWidget {
  const HealthBlogAndTipsDescriptionPage({Key? key}) : super(key: key);

  @override
  _HealthBlogAndTipsDescriptionPageState createState() =>
      _HealthBlogAndTipsDescriptionPageState();
}

class _HealthBlogAndTipsDescriptionPageState
    extends State<HealthBlogAndTipsDescriptionPage> {
  List<HealthBlogAndTipsDescription> discriptionData = [];
  bool isLoading = true;
  String bId='';
  @override
  void initState() {
    print("calling api");
    bId=Get.arguments;
    getDescription(bId);
    super.initState();
  }

  void getDescription(blogId) {
    setState(() {
      isLoading = true;
    });
    HealthBlogTipsDescription().getDescription(blogId).then((value) {
      if (value[0]['status'] == 1) {
        HealthBlogAndTipsDescription resposeData =
            HealthBlogAndTipsDescription.fromJson(value[0]);
        discriptionData.add(resposeData);

        setState(() {
          isLoading = false;
        });
      }
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
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _headingCard(),
                          SizedBox(height: 10),
                          _description(),
                          SizedBox(height: 10),
                         // _relatedBlogs()
                        ]))));
  }

  _headingCard() {
    return Card(
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
                    height: 140,
                    width: Get.width/1.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(discriptionData[0].data.image),
                         fit: BoxFit.fill
                    ),
                    )),
              
            
            SizedBox(height: 8),
            Text(discriptionData[0].data.title,
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
                    Text(discriptionData[0].data.author,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        )),
                    SizedBox(width: 16),
                    Text(discriptionData[0].data.timeAgo,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        )),
                  ],
                ),
                //Icon(Icons.bookmark, color: AppColors.appbarbackgroundColor,size:30)
              ],
            )
          ],
        ),
      ),
    );
  }

  _description() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Html(
        data: discriptionData[0].data.description,
      ),
    );
  }

  _relatedBlogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Related blogs",
              style: TextStyle(
                  color: AppColors.appbarbackgroundColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ),
        ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Heading of the\nblog or article",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Username",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      )),
                                  SizedBox(width: 16),
                                  Text("5 min, read",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
