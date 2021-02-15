import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../cubit/theme_cubit/theme_cubit.dart';

class ThemeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildColourTitle(context, 'Theme Colour'),
            Container(
              height: 10,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return _buildColourPickerDialog(
                          context,
                          state.swatch,
                          (color) => BlocProvider.of<ThemeCubit>(context,
                                  listen: false)
                              .changeTheme(color));
                    });
              },
              child: Container(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: state.swatch),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Change',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColourTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget _buildColourPickerDialog(BuildContext context,
      MaterialColor currentSwatch, void Function(Color) onSelectColour) {
    return AlertDialog(
        content: BlockPicker(
      onColorChanged: onSelectColour,
      availableColors: Colors.primaries,
      pickerColor: currentSwatch,
    ));
  }
}
