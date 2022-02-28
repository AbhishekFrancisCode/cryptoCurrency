import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class Utils {
  static void showErrorToast(String msg, BuildContext context) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red);
  }

  static void showAlertDialog(
      BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static MaterialPageRoute getRoute(
      BuildContext context, StatelessWidget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static navigateToPage(BuildContext context, Widget widget) {
    final route = Utils.getRoute(context, widget);
    Navigator.push(context, route);
  }

  static trucateIfZero(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  static double getDouble(dynamic value) {
    final text = value?.toString() ?? "";
    return text.isEmpty ? 0.0 : double.parse(text);
  }

  static Future<String> getDeviceModel() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return '${info.model}, v${info.version.release}';
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return '${info.utsname.machine}';
    }
    return '';
  }

  // the list of positive integers starting from 0
  static Iterable<int> get positiveIntegers sync* {
    int i = 0;
    while (true) yield i++;
  }

  static Color getColorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return hexCode.isEmpty
        ? Colors.transparent
        : Color(int.parse(hexCode, radix: 16));
  }

  static void insertionSort<T>(List<T> list, int Function(T, T) compare) {
    for (var pos = 1; pos < list.length; pos++) {
      var min = 0;
      var max = pos;
      var element = list[pos];
      while (min < max) {
        var mid = min + ((max - min) >> 1);
        var comparison = compare(element, list[mid]);
        if (comparison < 0) {
          max = mid;
        } else {
          min = mid + 1;
        }
      }
      list.setRange(min + 1, pos + 1, list, min);
      list[min] = element;
    }
  }

  static String getDate() {
    String d_data = DateFormat("dd MMM yyyy").format(DateTime.now());
    return d_data;
  }

  static String getTime() {
    String t_data = DateFormat("hh:mm:ss").format(DateTime.now());
    return t_data;
  }

  static getRemoveBrackets(String list) {
    final removedBrackets = list.substring(1, list.length - 1);
    final parts = removedBrackets.split(', ');
    return parts;
  }

  static getRowOfList(
    String a,
    String b,
    String c,
    String d,
  ) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //SizedBox(height: 20),
      Text("${a}"),
      Text("${b}"),
      Text("${c}"),
      Text("${d}"),
    ]);
  }
}
