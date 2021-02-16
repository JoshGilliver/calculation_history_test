import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../calculator_history/presentation/cubit/calculation_history_cubit.dart';
import '../cubit/calculator_form_cubit.dart';

class CalculatorForm extends StatefulWidget {
  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm>
    with WidgetsBindingObserver {
  final formKey = GlobalKey<FormState>();

  final formCubit = sl<CalculatorFormCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    formCubit.saveFormState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorFormCubit, CalculatorFormState>(
        cubit: formCubit,
        builder: (context, state) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final orientation = MediaQuery.of(context).orientation;
              final height = orientation == Orientation.portrait
                  ? constraints.minHeight
                  : constraints.minWidth;
              final width = orientation == Orientation.portrait
                  ? constraints.minWidth
                  : constraints.minHeight;
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Positioned(
                      bottom: 10,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ListView(
                        children: [
                          Container(
                            height: height * 0.02,
                          ),
                          Container(
                            width: width,
                            child: _buildFormFields(state),
                          ),
                          Container(
                            height: height * 0.05,
                          ),
                          _buildCalculationResult(state),
                          Container(
                            height: height * 0.09,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: _buildActionButtons(state, height, width)),
                  ],
                ),
              );
            },
          );
        });
  }

  Widget _buildCalculationResult(CalculatorFormState state) {
    return Align(
        alignment: Alignment.center,
        child: buildAdaptiveFlexParent(context, [
          Text(
            '=',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.black),
          ),
          Container(
            width: 20,
            height: 20,
          ),
          Text(
            state is CalculatorHasValue ? state.result.toString() : '0.0',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ]));
  }

  Widget _buildFormFields(CalculatorFormState state) {
    List<Widget> children = [];

    for (var i = 0; i < state.formFields.length; i++) {
      final entry = state.formFields.entries.toList()[i];
      final textField = IntrinsicWidth(
          child: TextFormField(
        autofocus: false,
        onChanged: (_) {
          if (state is CalculatorHasValue) {
            formCubit.clearCalculatedValue();
          }
        },
        key: ValueKey(entry.key),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30)),
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(color: Colors.black, fontWeight: FontWeight.w300),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Value required";
          }
          if (double.tryParse(value) == null) {
            return "Please enter a valid number";
          }

          return null;
        },
        controller: entry.value,
      ));

      if (i == (state.formFields.entries.length - 1)) {
        children.add(textField);
      } else {
        children.addAll(
          [
            textField,
            Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 10, left: 15, right: 15),
                child: Icon(Icons.add))
          ],
        );
      }
    }

    return Form(
      key: formKey,
      child: buildAdaptiveFlexParent(context, children),
    );
  }

  Widget _buildActionButtons(CalculatorFormState state, double availableHeight,
      double availableWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Builder(builder: (ctx) {
          return ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(availableWidth * 0.2, availableHeight * 0.07))),
              child: Text(
                'Calculate Sum',
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  final entry = formCubit.sum();
                  BlocProvider.of<CalculationHistoryCubit>(context,
                          listen: false)
                      .addEntry(entry);
                }
              });
        }),
      ],
    );
  }
}

Widget buildAdaptiveFlexParent(BuildContext context, List<Widget> children) =>
    MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: children,
          );
