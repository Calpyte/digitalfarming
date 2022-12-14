import 'package:digitalfarming/blocs/grade_bloc.dart';
import 'package:digitalfarming/blocs/product_bloc.dart';
import 'package:digitalfarming/blocs/variety_bloc.dart';
import 'package:digitalfarming/models/Basic.dart';
import 'package:digitalfarming/resources/result.dart';
import 'package:digitalfarming/widgets/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SearchCrop extends StatefulWidget {
  const SearchCrop({Key? key}) : super(key: key);

  @override
  State<SearchCrop> createState() => _SearchCropState();
}

class _SearchCropState extends State<SearchCrop> {
  ProductBloc? productBloc;
  VarietyBloc? varietyBloc;
  GradeBloc? gradeBloc;

  List<Basic> products = [];
  List<Basic> varities = [];
  List<Basic> grades = [];

  String selectedProduct = '';
  String selectedVariety = '';
  String selectedGrade = '';

  @override
  void initState() {
    productBloc = ProductBloc();
    varietyBloc = VarietyBloc();
    gradeBloc = GradeBloc();

    productBloc?.productStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            products = snapshot.data;
            if (products.isNotEmpty) {
              selectedProduct = products[0].id!;
              varietyBloc?.getVarieties(productId: selectedProduct);
              gradeBloc?.getGrades(varietyId: selectedProduct);
            }
          });
          break;
      }
    });

    varietyBloc?.varietyStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            varities = snapshot.data;
            if (varities.isNotEmpty) {
              selectedVariety = varities[0].id!;
            }
          });
          break;
      }
    });

    gradeBloc?.gradeStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.completed:
          setState(() {
            grades = snapshot.data;
            if (grades.isNotEmpty) {
              selectedGrade = grades[0].id!;
            }
          });
          break;
      }
    });

    productBloc?.getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0.0,
          child: Column(
            children: [
              const SizedBox(width: double.infinity, height: 20),
              DropDownField(
                  name: 'product',
                  items: getItems(products),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please select Product'),
                  ],
                  hintText: 'Product',
                  onChanged: (product) {
                    varietyBloc?.getVarieties(
                      productId: product?.id,
                    );
                    gradeBloc?.getGrades(
                      varietyId: product?.id,
                    );
                  }),
              const SizedBox(width: double.infinity, height: 20),
              DropDownField(
                  name: 'variety',
                  items: getItems(varities),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'Please select Variety'),
                  ],
                  hintText: 'Variety',
                  ),
              const SizedBox(width: double.infinity, height: 20),
              DropDownField(
                name: 'grade',
                items: getItems(grades),
                validators: [
                  FormBuilderValidators.required(
                      errorText: 'Please select Grade'),
                ],
                hintText: 'Grade',
              ),
              /*  Wrap(
                spacing: 10.0,
                runSpacing: 20.0,
                children: grades
                    .map(
                      (grade) => Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: selectedGrade! != grade.id
                              ? Colors.white
                              : AppTheme.brandingColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedGrade = grade.id ?? '';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              grade.name ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedGrade! != grade.id
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ), */
            ],
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem> getItems(List<Basic> options) {
    return List.generate(
      options.length,
      (index) => DropdownMenuItem(
        value: options[index],
        child: Text(options[index].name ?? ''),
      ),
    );
  }
}
