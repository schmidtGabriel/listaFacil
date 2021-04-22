import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  var StringLocale;

  CurrencyInputFormatter(String StringLocale){
    this.StringLocale = StringLocale;
  }

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    var formatter;
    if(NumberFormat.localeExists(StringLocale)) {
       formatter = NumberFormat.simpleCurrency(locale: StringLocale);
    }else{
       formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
    }

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class MeasureInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    // final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
    final formatter = new NumberFormat("0.000", "pt_Br");

    String newText = formatter.format(value/1000);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}