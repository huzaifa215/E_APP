import 'dart:math';

import 'package:Eitox/src/utils/StaticRes.dart';
import 'package:Eitox/src/utils/TextUtility.dart';
import 'package:Eitox/src/utils/TextWidgetSearch.dart';
import 'package:Eitox/src/view/details/ProductDetail.dart';
import 'package:Eitox/src/view/login/LoginPage.dart';
import 'package:Eitox/src/view/products/ProductList.dart';
import 'package:Eitox/src/view/products/models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// variable
  double value = 0;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      productList = Res.fetchProducts();
    });
  }

  // TODO: Appbar
  Widget buildAnimatedDrawer() {
    return Scaffold(
        body: Stack(
      children: [
        //Creating the Background
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.amber[400], Colors.amber[800]],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
        ),

        // Navigator menu
        SafeArea(
          child: Container(
            width: 200.0,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(""),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Etiox",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  //TODO: listTile occur in list but can also click on it
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        title: Text(
                          "home",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: Text(
                          "profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Setting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        title: Text(
                          "logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
// TODO: make the code that wrap our main screen which allow us to animate it
        TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: Duration(milliseconds: 500),
            builder: (_, double val, __) {
              return (Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val) // allow us to translate
                  ..rotateY((pi / 6) * val),
                child: Column(
                  children: [
                    AppBar(
                      title: Text(
                        "Etoix",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      backgroundColor: Colors.amber,
                      actions: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen())),
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                    buildSearchRow(),
                    //SizedBox(height: 30),
                    buildCategoryRow("Categories"),
                    buildCategoryListView(),
                    buildCategoryRow("Other Products"),
                    Flexible(
                      child: buildProductGridView(
                          context), //getCardList(productList),
                    ),
                  ],
                ),
              ));
            }),
        // create a geasture to get the the acess of the drawer
        GestureDetector(

          // swaping
          onHorizontalDragUpdate: (e){
            if(e.delta.dx>0){
              setState(() {
                value=1;
              });
            }
            else{
              setState(() {
                value=0;
              });
            }
          },
          // tapping also
          onTap: () {
            setState(() {
              value == 0 ? value = 1 : value = 0;
            });
          },
        )
      ],
    ));
  }

  Container buildCategoryListView() {
    return Container(
      height: 150,
      width: double.infinity,
      child: renderProductCategories(),
    );
  }

  Widget buildCategoryRow(String section) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            section,
            style: mediumText,
          ),
          SizedBox(height: 10),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductList())),
              },
              tooltip: "Filter",
              visualDensity: VisualDensity.adaptivePlatformDensity,
              iconSize: 30,
              padding: EdgeInsets.all(8),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Row buildActionbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Furnitures',
          style: GoogleFonts.lato(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade400,
          ),
        )
      ],
    );
  }

  Row buildSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchProductWidget(),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.filter_list,
              size: 20,
            ),
            onPressed: () => {print("Filter clicked")},
            tooltip: "Filter",
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconSize: 30,
            padding: EdgeInsets.all(8),
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  ListView renderProductCategories() {
    return ListView.builder(
        padding: EdgeInsets.only(left: 0),
        itemCount: productList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            product: productList[index],
                          ))),
            },
            child: Container(width: 100, child: buildCardGrid(index)),
          );
        });
  }

  GridView buildProductGridView(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      itemCount: productList.length,
      padding: EdgeInsets.only(top: 0),
      reverse: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetail(
                          product: productList[index],
                        ))),
          },
          child: buildCardGrid(index),
        );
      },
    );
  }

  Card buildCardGrid(int index) {
    return Card(
      elevation: 0,
      color: productList[index].color,
      child: new GridTile(
        footer: Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productList[index].title,
                  style: TextStyle(fontSize: 10),
                ),
                CircleAvatar(
                  backgroundColor: productList[index].color,
                  radius: 8,
                )
              ],
            )),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            productList[index].image,
            fit: BoxFit.contain,
          ),
        ), //just for testing, will fill with image later
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var screenSize = MediaQuery.of(context).size;

    return Scaffold(
   backgroundColor: Colors.grey,
        body: Stack(
          children: [
            //Creating the Background
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber[400], Colors.amber[800]],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )
              ),
            ),

            // Navigator menu
            SafeArea(
              child: Container(
                width: 200.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DrawerHeader(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage(""),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Etiox",
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      //TODO: listTile occur in list but can also click on it
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            title: Text(
                              "home",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            title: Text(
                              "profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Setting",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: Text(
                              "logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
// TODO: make the code that wrap our main screen which allow us to animate it
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: value),
                duration: Duration(milliseconds: 500),
                builder: (_, double val, __) {
                  return (Transform(

                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val) // allow us to translate
                      ..rotateY((pi / 6) * val),
                    child: Scaffold(
                      body: Column(
                        children: [
                          AppBar(
                            leading: Icon(
                              Icons.menu,
                            ),
                            title: Text(
                              "Etoix",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            backgroundColor: Colors.amber[900],
                            actions: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen())),
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                          buildSearchRow(),
                          //SizedBox(height: 30),
                          buildCategoryRow("Categories"),
                          buildCategoryListView(),
                          buildCategoryRow("Other Products"),
                          Flexible(
                            child: buildProductGridView(
                                context), //getCardList(productList),
                          ),
                        ],
                      ),
                    ),
                  ));
                }),
            // create a geasture to get the the acess of the drawer
            GestureDetector(

              // swaping
              onHorizontalDragUpdate: (e){
                if(e.delta.dx>0){
                  setState(() {
                    value=1;
                  });
                }
                else{
                  setState(() {
                    value=0;
                  });
                }
              },
              // tapping also
              onTap: () {
                setState(() {
                  value == 0 ? value = 1 : value = 0;
                });
              },
            )
          ],
        )
    );

    // return Scaffold(
    //   backgroundColor: Colors.grey.shade100,
    //   body: Padding(
    //     padding: EdgeInsets.all(10),
    //     child: Column(
    //       children: <Widget>[
    //       SizedBox(height: 30),
    //        buildActionbar(),
    //        SizedBox(height: 20),
    //         buildSearchRow(),
    //         //SizedBox(height: 30),
    //         buildCategoryRow("Categories"),
    //         buildCategoryListView(),
    //         buildCategoryRow("Other Products"),
    //         Flexible(
    //           child: buildProductGridView(context), //getCardList(productList),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
