// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

import 'package:flutter/services.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  // TODO: Set some variables, such as for keeping track of the user's input
  // value and units
  var _userInput;
  var inputTextFieldController = TextEditingController();
  var outputTextFieldController = TextEditingController();

  // TODO: Determine whether you need to override anything, such as initState()

  @override
  initState() {
    super.initState();
    
  }

  // TODO: Add other helper functions. We've given you one, _format()

  void _convertInput(String input) {
     outputTextFieldController.text = _format(double.parse(input));
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    // Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].

    final inputGroupWidget = Padding(
      padding: _padding,
      child: Column(
        children: <Widget>[
          TextField(
            inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9.]"))],
            onChanged: _convertInput,
            controller: inputTextFieldController,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Input',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );

    // Create a compare arrows icon.
    final compareIconWidget = Transform.rotate(
      angle: 1.57079632679,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    // Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].

    final outputGroupWidget = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9.]"))],
            controller: outputTextFieldController,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Output',
            ),
            keyboardType: TextInputType.number,
          )
        ],
      ),
    );

    //Return the input, arrows, and output widgets, wrapped in a Column.
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          inputGroupWidget,
          compareIconWidget,
          outputGroupWidget,
        ],
      ),
    );
  }
}
