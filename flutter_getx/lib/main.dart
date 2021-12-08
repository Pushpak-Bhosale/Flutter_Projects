import 'package:flutter/material.dart';
import 'package:flutter_getx/commonmodule/AppColor.dart';
import 'package:flutter_getx/commonmodule/AppString.dart';
import 'package:flutter_getx/home.dart';
import 'package:get/get.dart';

import 'productmodule/views/product_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.fetchApiData,
      theme: ThemeData(
        primarySwatch: AppColor.purpleColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("This is snack bar"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.snackbar("Its Snackbar", "Hello Snack Bar");
                },
                child: Text("Show Snack Bar"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog();
                },
                child: Text("Show Dialog"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text("Bottom Sheet"),
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: Icon(Icons.wb_sunny_outlined),
                            title: Text("Light Theme"),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Icon(Icons.wb_sunny),
                            title: Text("Dark Theme"),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(Home());
                },
                child: Text("Go to home"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(ProductListView());
                },
                child: Text("Go to api"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
