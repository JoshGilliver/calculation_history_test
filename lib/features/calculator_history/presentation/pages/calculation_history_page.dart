import 'dart:io';

import '../../../../core/utilities/format_date_to_string.dart';
import '../cubit/calculation_history_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculationHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CalculationHistoryCubit, CalculationHistoryState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.entries.length,
              itemBuilder: (context, index) {
                final entry = state.entries[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        entry.calculation + " = " + entry.result.toString()),
                    subtitle: Text(formatDate(entry.calculationDate)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  _buildAppBar() {
    final Widget title = Text('Calculation History');
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: title,
          )
        : AppBar(
            title: title,
          );
  }
}
