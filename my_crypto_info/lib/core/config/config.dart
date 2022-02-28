import 'dart:convert' as json;
import 'dart:ui';

import 'package:cryptodata/components/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

enum Environment { DEV, PROD }

class Config {
  String baseUrl;
  Color brandColor;
  Color backgroundColor;
  String brandName;
  String appVersion;
  Future initialized;
  Map<String, String> brandNamesMap = Map<String, String>();

  Config() {
    initialized = init();
  }

  init() async {
    final configJson = await loadAsset();
    final config = json.jsonDecode(configJson);
    baseUrl = config['base_url'];
    brandColor = Utils.getColorFromHex(config['brand_color']);
    backgroundColor = Utils.getColorFromHex(config['background_color']);
    brandName = config['brand_name'];

    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version} (${packageInfo.buildNumber})";
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }
  String getBrandName(String brandValue) {
    return brandNamesMap[brandValue];
  }
}

Config config = Config();
