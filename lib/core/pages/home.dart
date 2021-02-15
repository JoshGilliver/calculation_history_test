import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../features/calculator/presentation/widgets/calculator_form.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget _appBar = _buildAppBar(context);
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Container(
                width: _mediaQuery.size.width,
                height: _mediaQuery.size.height -
                    _mediaQuery.viewPadding.vertical -
                    _appBar.preferredSize.height,
                child: CalculatorForm()),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            leading: _buildSettingsIconButton(context),
            trailing: _buildCalculationHistoryIconButton(context))
        : AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: _buildSettingsIconButton(context),
            actions: [_buildCalculationHistoryIconButton(context)],
          );
  }

  Widget _buildCalculationHistoryIconButton(BuildContext context) => TextButton(
        child: Text('Calculation history'),
        onPressed: () => Navigator.of(context).pushNamed('/history'),
      );

  Widget _buildSettingsIconButton(BuildContext context) => IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pushNamed('/settings'),
      );
}
