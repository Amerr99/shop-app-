import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection("products");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? myRow]) async {
    if (myRow != null) {
      nameController.text = myRow['name'];
      priceController.text = myRow['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = nameController.text;
                    final double? price = double.tryParse(priceController.text);
                    if (price != null) {
                      await _products
                          .doc(myRow!.id)
                          .update({"name": name, "price": price});
                      nameController.text = '';
                      priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
  Future<void> _create([DocumentSnapshot? myRow]) async {
    if (myRow != null) {
      nameController.text = myRow['name'];
      priceController.text = myRow['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () async {
                    final String name = nameController.text;
                    final double? price = double.tryParse(priceController.text);
                    if (price != null) {
                      await _products.add({"name": name, "price": price});
                      nameController.text = '';
                      priceController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Product Deleted"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      body: StreamBuilder(
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot myRow = streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(myRow['name']),
                    subtitle: Text(myRow['price'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            _update(myRow);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _delete(myRow.id);
                          },
                          icon: Icon(Icons.delete),
                        )
                      ]),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text("you have no data"),
          );
        },
      ),
    );
  }
}
