import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pathbyte/Constants/textfield_constant.dart';

class FormulaField extends StatefulWidget {
  final String hinttext;
  final String formula;
  final Map<String, double> values;

  const FormulaField({
    super.key,
    required this.hinttext,
    required this.formula,
    required this.values,
  });

  @override
  State<FormulaField> createState() => _FormulaFieldState();
}

class _FormulaFieldState extends State<FormulaField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _updateValue();
  }

  void _updateValue() {
    if (_isSingleVariable(widget.formula)) {
      controller.text = widget.values[widget.formula]?.toString() ?? "";
    } else {
      controller.text = _calculate(widget.formula, widget.values).toString();
    }
  }

  bool _isSingleVariable(String formula) {
    final regex = RegExp(r'^[A-Za-z]+$');
    return regex.hasMatch(formula);
  }

  double _calculate(String formula, Map<String, double> values) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(formula);

      ContextModel cm = ContextModel();
      values.forEach((key, value) {
        cm.bindVariable(Variable(key), Number(value));
      });

      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldConstant(
      controller: controller,
      hintText: widget.hinttext,
      keyboardType: TextInputType.number,
      isReadOnly: !_isSingleVariable(widget.formula),
      onChanged: (val) {
        if (_isSingleVariable(widget.formula)) {
          final num = double.tryParse(val) ?? 0;
          widget.values[widget.formula] = num;
          setState(_updateValue);
        }
      },
    );
  }
}
