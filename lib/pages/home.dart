import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_team/pages/details.dart';
import 'package:flutter_project_team/service/database.dart';
import 'package:flutter_project_team/widget/widget_support.dart';
import 'package:flutter_project_team/service/shared_pref.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool shirt = false, trousers = false, jacket = false, hat = false;
  String? profile, name, email;
  Stream? secondhanditemsStream;
  ontheload() async {
    secondhanditemsStream = await DatabaseMethods().get2handItem("Shirt");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: secondhanditemsStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      detail: ds["Detail"],
                                      name: ds["Name"],
                                      price: ds["Price"],
                                      image: ds["Image"],
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(ds["Name"],
                                      style:
                                          AppWidget.semiBoldTextFeildStyle()),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("New Zealand",
                                      style: AppWidget.LightTextFeildStyle()),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\$" + ds["Price"],
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hi", style: AppWidget.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("2handLand", style: AppWidget.HeadlineTextFeildStyle()),
              Text("Vintage & Thrift Clothing",
                  style: AppWidget.LightTextFeildStyle()),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  margin: EdgeInsets.only(right: 20.0), child: showItem()),
              SizedBox(
                height: 30.0,
              ),

              Container(height: 270, child: allItemsVertically()),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (context) => Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     ClipRRect(
              //                       borderRadius: BorderRadius.circular(24),
              //                       child: Image.asset(
              //                         "images/shirt1.jpeg",
              //                         height: 150,
              //                         width: 150,
              //                         fit: BoxFit.cover,
              //                         // Image.asset(
              //                         //   "images/shirt1.jpeg",
              //                         //   height: 150,
              //                         //   width: 150,
              //                         //   fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                     Text("CANTEBURY",
              //                         style:
              //                             AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     Text("New Zealand",
              //                         style: AppWidget.LightTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     Text(
              //                       "\$25",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),
              //       Container(
              //         margin: EdgeInsets.all(4),
              //         child: Material(
              //           elevation: 5.0,
              //           borderRadius: BorderRadius.circular(20),
              //           child: Container(
              //             padding: EdgeInsets.all(14),
              //             child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   ClipRRect(
              //                     borderRadius: BorderRadius.circular(24),
              //                     child: Image.asset(
              //                       "images/jacket1.jpeg",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     // Image.asset(
              //                     //   "images/jacket1.jpeg",
              //                     //   height: 150,
              //                     //   width: 150,
              //                     //   fit: BoxFit.cover,
              //                   ),
              //                   Text("Lee Rider",
              //                       style: AppWidget.semiBoldTextFeildStyle()),
              //                   SizedBox(
              //                     height: 5.0,
              //                   ),
              //                   Text("America",
              //                       style: AppWidget.LightTextFeildStyle()),
              //                   SizedBox(
              //                     height: 5.0,
              //                   ),
              //                   Text(
              //                     "\$28",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   )
              //                 ]),
              //             // decoration: BoxDecoration(
              //             //   borderRadius: BorderRadius.circular(10),
              //             //   color: Colors.white,
              //             //   border: Border(
              //             //     left: BorderSide(
              //             //       color: Colors.green,
              //             //       width: 3,
              //             //     ),
              //             //   ),
              //             // ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 30.0,
              // ),
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(24),
              //             child: Image.asset(
              //               "images/shirt2.jpeg",
              //               height: 120,
              //               width: 120,
              //               fit: BoxFit.cover,
              //             ),
              //             // Image.asset(
              //             //   "images/shirt2.jpeg",
              //             //   height: 120,
              //             //   width: 120,
              //             //   fit: BoxFit.cover,
              //           ),
              //           SizedBox(
              //             width: 20.0,
              //           ),
              //           Column(
              //             children: [
              //               Container(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Vintage N.I.K.E",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               Container(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Baby Tee, Crop Top",
              //                     style: AppWidget.LightTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               Container(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "\$28",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   ))
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30.0,
              // ),
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(24),
              //             child: Image.asset(
              //               "images/jacket2.jpeg",
              //               height: 120,
              //               width: 120,
              //               fit: BoxFit.cover,
              //             ),
              //             // Image.asset(
              //             //   "images/jacket2.jpeg",
              //             //   height: 120,
              //             //   width: 120,
              //             //   fit: BoxFit.cover,
              //           ),
              //           SizedBox(
              //             width: 20.0,
              //           ),
              //           Column(
              //             children: [
              //               Container(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "VINTAGE N.I.K.E",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               Container(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "Black Nike",
              //                     style: AppWidget.LightTextFeildStyle(),
              //                   )),
              //               SizedBox(
              //                 height: 5.0,
              //               ),
              //               Container(
              //                   width: MediaQuery.of(context).size.width / 2,
              //                   child: Text(
              //                     "\$28",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   ))
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            shirt = true;
            trousers = false;
            jacket = false;
            hat = false;
            secondhanditemsStream =
                await DatabaseMethods().get2handItem("Shirt");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: shirt ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/shirt.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: shirt ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            shirt = false;
            trousers = true;
            jacket = false;
            hat = false;
            secondhanditemsStream =
                await DatabaseMethods().get2handItem("Trousers");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: trousers ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/trousers.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: trousers ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            shirt = false;
            trousers = false;
            jacket = true;
            hat = false;
            secondhanditemsStream =
                await DatabaseMethods().get2handItem("Jacket");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: jacket ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/jacket.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: jacket ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            shirt = false;
            trousers = false;
            jacket = false;
            hat = true;
            secondhanditemsStream = await DatabaseMethods().get2handItem("Hat");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: hat ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/hat.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: hat ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
