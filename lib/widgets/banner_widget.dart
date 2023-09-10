import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_services.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _services = FirebaseService();

    return StreamBuilder<QuerySnapshot>(
      stream: _services.banners.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data?.docs.map((DocumentSnapshot? document) {
                  if (document == null || !document.exists) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Card(
                              elevation: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  (document.data()
                                          as Map<String, dynamic>)["image"] ??
                                      '',
                                  width: 400,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  _services.deleteBannerFromDb(document.id);
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        );
      },
    );
  }
}
