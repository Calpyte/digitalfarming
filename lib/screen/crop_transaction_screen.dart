import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/border_button.dart';

class CropTransactionScreen extends StatefulWidget {
  static const routeName = '/crop-transaction';

  const CropTransactionScreen({Key? key}) : super(key: key);

  @override
  State<CropTransactionScreen> createState() => _CropTransactionScreenState();
}

class _CropTransactionScreenState extends State<CropTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.CROP_TRANSACTION,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: FormBuilder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Input Weight(KG)',
                        style: AppTheme.title,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Material(
                        shadowColor: Colors.black,
                        elevation: 8,
                        child: TextFormField(
                          onTap: () {},
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Amount(INR)',
                        style: AppTheme.title,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Material(
                        shadowColor: Colors.black,
                        elevation: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Total Amount(INR)',
                        style: AppTheme.title,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Material(
                        shadowColor: Colors.black,
                        elevation: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: BorderButton(
                    text: 'Proceed',
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
