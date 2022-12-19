import 'package:digitalfarming/blocs/product_bloc.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../models/Basic.dart';

class BinRegistrationScreen extends StatefulWidget {
  static const routeName = '/bin-registration';
  const BinRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<BinRegistrationScreen> createState() => _BinRegistrationScreenState();
}

class _BinRegistrationScreenState extends State<BinRegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  ProductBloc? productBloc;

  List<Basic> products = [];
  String selectedProduct = '';



  @override
  void initState() {
    productBloc = ProductBloc();
    productBloc?.productStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            products = snapshot.data;
          });
          break;
      }
    });

    productBloc?.getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.BIN_REGISTRATION,
          style: AppTheme.body,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bin',
                style: AppTheme.headline,
              ),
              NameTextField(name: 'name'),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity, height: 20),
                    const Text(
                      'Add Product',
                      style: AppTheme.body,
                    ),
                    const SizedBox(width: double.infinity, height: 20),
                    Wrap(
                        spacing: 10.0,
                        runSpacing: 20.0,
                        children: products
                            .map(
                              (product) => Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedProduct! != product.id
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedProduct = product.id ?? '';
                                    });

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      product.name ?? '',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
