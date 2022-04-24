import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/controller/store_controller.dart';
import 'package:providerexample/screens/testScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<storeController>(context, listen: false).getProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print('Ali');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestScreen()),
                );
              },
              icon: Icon(Icons.access_alarm_sharp))
        ],
      ),
      body: Consumer<storeController>(
        builder: (context, value, child) {
          if (value.status == dataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (value.status == dataStatus.error) {
            return Center(child: Text('there is error'));
          } else {
            return Center(
              child: Container(
                // height: MediaQuery.of(context).size.height * .3,
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: value.allProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .3,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .2,
                              height: MediaQuery.of(context).size.height * .15,
                              child: Image.network(
                                  value.allProducts[index].image!),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              value.allProducts[index].title!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(value.allProducts[index].price!
                                      .toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
