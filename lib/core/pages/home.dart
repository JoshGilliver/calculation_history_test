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
    final title =
        FittedBox(fit: BoxFit.scaleDown, child: Text('Calculate Values'));
    return Platform.isIOS
        ? CupertinoNavigationBar(
            leading: _buildSettingsIconButton(context),
            middle: title,
            trailing: _buildCalculationHistoryIconButton(context))
        : AppBar(
            title: title,
            leading: _buildSettingsIconButton(context),
            centerTitle: true,
            actions: [_buildCalculationHistoryIconButton(context)],
          );
  }

  Widget _buildCalculationHistoryIconButton(BuildContext context) {
    final _theme = Theme.of(context);
    return TextButton(
      child: Text(
        'History',
        style: _theme.textTheme.button
            .copyWith(color: _theme.colorScheme.onPrimary),
      ),
      onPressed: () => Navigator.of(context).pushNamed('/history'),
    );
  }

  Widget _buildSettingsIconButton(BuildContext context) => IconButton(
        icon: Icon(
          Icons.settings,
        ),
        onPressed: () => Navigator.of(context).pushNamed('/settings'),
      );
}
