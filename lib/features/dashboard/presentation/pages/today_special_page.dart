import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdine_queue_manager/core/theme/smartdine_colors.dart';
import 'package:smartdine_queue_manager/core/widgets/circular_progress_widget.dart';

/// lastly added feature
class TodaySplEditPage extends StatefulWidget {
  const TodaySplEditPage({Key? key}) : super(key: key);

  @override
  State<TodaySplEditPage> createState() => _TodaySplEditPageState();
}

class _TodaySplEditPageState extends State<TodaySplEditPage> {
  final TextEditingController _textEditingController1N =
      TextEditingController();
  final TextEditingController _textEditingController1P =
      TextEditingController();
  final TextEditingController _textEditingController1E =
      TextEditingController();

  final TextEditingController _textEditingController2N =
      TextEditingController();
  final TextEditingController _textEditingController2P =
      TextEditingController();
  final TextEditingController _textEditingController2E =
      TextEditingController();

  final TextEditingController _textEditingController3N =
      TextEditingController();
  final TextEditingController _textEditingController3P =
      TextEditingController();
  final TextEditingController _textEditingController3E =
      TextEditingController();

  final TextEditingController _textEditingController4N =
      TextEditingController();
  final TextEditingController _textEditingController4P =
      TextEditingController();
  final TextEditingController _textEditingController4E =
      TextEditingController();

  /// lastly added feature

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ar_menu')
            .doc('CNfUkqMQFNIsR1ek2nym')
            .collection('ar_snacks')
            .doc('dess_1')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressWidget();
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data found');
          }

          final String fieldValue1N = snapshot.data?.get('i_name') ?? '';
          final String fieldValue1P =
              snapshot.data?.get('i_price').toString() ?? '';
          final String fieldValue1E =
              snapshot.data?.get('i_eta').toString() ?? '';

          final String fieldValue2N = snapshot.data?.get('i_name2') ?? '';
          final String fieldValue2P =
              snapshot.data?.get('i_price2').toString() ?? '';
          final String fieldValue2E =
              snapshot.data?.get('i_eta2').toString() ?? '';

          final String fieldValue3N = snapshot.data?.get('i_name3') ?? '';
          final String fieldValue3P =
              snapshot.data?.get('i_price3').toString() ?? '';
          final String fieldValue3E =
              snapshot.data?.get('i_eta3').toString() ?? '';

          final String fieldValue4N = snapshot.data?.get('i_name4') ?? '';
          final String fieldValue4P =
              snapshot.data?.get('i_price4').toString() ?? '';
          final String fieldValue4E =
              snapshot.data?.get('i_eta4').toString() ?? '';

          _textEditingController1N.text = fieldValue1N;
          _textEditingController1E.text = fieldValue1E;
          _textEditingController1P.text = fieldValue1P;

          _textEditingController2N.text = fieldValue2N;
          _textEditingController2E.text = fieldValue2E;
          _textEditingController2P.text = fieldValue2P;

          _textEditingController3N.text = fieldValue3N;
          _textEditingController3E.text = fieldValue3E;
          _textEditingController3P.text = fieldValue3P;

          _textEditingController4N.text = fieldValue4N;
          _textEditingController4E.text = fieldValue4E;
          _textEditingController4P.text = fieldValue4P;

          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: SmartDineColors.lightPrimaryColor,
              title: const Text('Edit Today Special'),
              actions: [
                GestureDetector(
                  onTap: () {
                    //tod o Save Data in firebase
                    editData();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Save ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(1) Name'),
                            controller: _textEditingController1N,
                            //initialValue: _textEditingController1N.text,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(1) Price'),
                            controller: _textEditingController1P,
                            keyboardType: TextInputType.number,
                            // initialValue: _textEditingController1P.text,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(1) Estimate'),
                            controller: _textEditingController1E,
                            keyboardType: TextInputType.number,
                            //initialValue: _textEditingController1N.text,
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(2) Name'),
                            controller: _textEditingController2N,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(2) Price'),
                            controller: _textEditingController2P,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(2) Estimate'),
                            controller: _textEditingController2E,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(3) Name'),
                            controller: _textEditingController3N,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(3) Price'),
                            controller: _textEditingController3P,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(3) Estimate'),
                            controller: _textEditingController3E,
                            keyboardType: TextInputType.number,
                            // initialValue: '',
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ), //3

                  Card(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(4) Name'),
                            controller: _textEditingController4N,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(4) Price'),
                            controller: _textEditingController4P,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '  Today Special(4) Estimate'),
                            controller: _textEditingController4E,
                            keyboardType: TextInputType.number,
                            // initialValue: '',
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ), //3
                ],
              ),
            ),
          ));
        });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('ar_menu')
        .doc('CNfUkqMQFNIsR1ek2nym')
        .collection('ar_snacks')
        .doc('dess_1')
        .get();

    return snapshot;
  }

  Future<void> editData() async {
    DocumentReference<Map<String, dynamic>> docRef = FirebaseFirestore.instance
        .collection('ar_menu')
        .doc('CNfUkqMQFNIsR1ek2nym')
        .collection('ar_snacks')
        .doc('dess_1');

    await docRef.update({
      'i_name': _textEditingController1N.text,
      'i_price': int.parse(_textEditingController1P.text),
      'i_eta': int.parse(_textEditingController1E.text),
      'i_name2': _textEditingController2N.text,
      'i_price2': int.parse(_textEditingController2P.text),
      'i_eta2': int.parse(_textEditingController2E.text),
      'i_name3': _textEditingController3N.text,
      'i_price3': int.parse(_textEditingController3P.text),
      'i_eta3': int.parse(_textEditingController3E.text),
      'i_name4': _textEditingController4N.text,
      'i_price4': int.parse(_textEditingController4P.text),
      'i_eta4': int.parse(_textEditingController4E.text),
    });

    Navigator.pop(context);
  }
}
