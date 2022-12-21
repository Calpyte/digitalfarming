import 'dart:collection';

import 'package:digitalfarming/blocs/binscr_bloc.dart';
import 'package:digitalfarming/blocs/grade_bloc.dart';
import 'package:digitalfarming/blocs/product_bloc.dart';
import 'package:digitalfarming/blocs/variety_bloc.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/utils/app_theme.dart';
import 'package:digitalfarming/utils/constants.dart';
import 'package:digitalfarming/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';

import '../models/Basic.dart';
import '../models/bin_scr.dart';
import '../widgets/border_button.dart';

class BinRegistrationScreen extends StatefulWidget {
  static const routeName = '/bin-registration';
  const BinRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<BinRegistrationScreen> createState() => _BinRegistrationScreenState();
}

class _BinRegistrationScreenState extends State<BinRegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  ProductBloc? productBloc;
  VarietyBloc? varietyBloc;
  GradeBloc? gradeBloc;
  BinBloc? binBloc;

  List<Basic> products = [];
  Basic selectedProduct = Basic();
  List<Basic> varieties = [];
  Basic selectedVariety = Basic();
  List<Basic> grades = [];
  Basic selectedGrade = Basic();

  @override
  void initState() {
    productBloc = ProductBloc();
    varietyBloc = VarietyBloc();
    gradeBloc = GradeBloc();
    binBloc = BinBloc();

    productBloc?.productStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            products = snapshot.data;
          });
          break;
        case Status.loading:
          // TODO: Handle this case.
          break;
        case Status.error:
          // TODO: Handle this case.
          break;
      }
    });

    productBloc?.getProducts();

    varietyBloc?.varietyStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            varieties = snapshot.data;
          });
          break;
        case Status.loading:
          // TODO: Handle this case.
          break;
        case Status.error:
          // TODO: Handle this case.
          break;
      }
    });

    gradeBloc?.gradeStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            grades = snapshot.data;
          });
          break;
        case Status.loading:
          // TODO: Handle this case.
          break;
        case Status.error:
          // TODO: Handle this case.
          break;
      }
    });

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
        physics: const PageScrollPhysics(),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
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
                                  color: selectedProduct.id != product.id
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      grades = [];
                                      selectedProduct = product;
                                      varietyBloc?.getVarieties(
                                          productId:
                                              selectedProduct.id.toString());
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
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity, height: 20),
                    const Text(
                      'Variety',
                      style: AppTheme.body,
                    ),
                    const SizedBox(width: double.infinity, height: 20),
                    Wrap(
                        spacing: 10.0,
                        runSpacing: 20.0,
                        children: varieties
                            .map(
                              (varieties) => Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedVariety.id != varieties.id
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedVariety = varieties;
                                      gradeBloc?.getGrades(
                                          varietyId:
                                              selectedVariety.id.toString());
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      varieties.name ?? '',
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
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  children: [
                    const SizedBox(width: double.infinity, height: 20),
                    const Text(
                      'Grade',
                      style: AppTheme.body,
                    ),
                    const SizedBox(width: double.infinity, height: 20),
                    Wrap(
                        spacing: 10.0,
                        runSpacing: 20.0,
                        children: grades
                            .map(
                              (grades) => Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedGrade.id != grades.id
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedGrade = grades;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      grades.name ?? '',
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
              const SizedBox(
                height: 15,
              ),
              NameTextField(name: 'name', maxLines: 5),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: BorderButton(
                    text: 'Proceed',
                    onPressed: () => save(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  save() async {
    if (_formKey.currentState?.saveAndValidate() ?? true) {
      print(_formKey.currentState?.value);
      // Basic binScreen = await getLocation();
      Map<String, dynamic>? binMap = HashMap();
      binMap["variety"] = selectedVariety.toJson();
      binMap['grade'] = selectedGrade.toJson();
      Bin binScr = Bin.fromFormJson(binMap!);
      binBloc?.saveBin(binScr: binScr);
    }
  }

  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
  }
}
