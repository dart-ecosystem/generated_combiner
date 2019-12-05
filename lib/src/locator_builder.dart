import 'dart:io';

import 'package:build/build.dart';
import 'package:glob/glob.dart';

class LocatorBuilder extends Builder {
  final BuilderOptions options;

  LocatorBuilder(this.options);

  @override
  Future<void> build(BuildStep buildStep) async {
    final String generatedFolder = options.config["generate_path"];

    if (generatedFolder == null || generatedFolder.isEmpty) {
      return null;
    }

    final List<String> extraLocatorNames = await buildStep
        .findAssets(
          Glob("*.extra_locator"),
        )
        .map((assetId) => assetId.pathSegments.last.replaceAll(".extra_locator", ""))
        .toList();

    // double check pubspec.yaml file is in root
    var pathSegments = buildStep.inputId.uri.pathSegments;
    if (pathSegments.length != 2 || pathSegments.last != "pubspec.yaml") {
      return null;
    }

    // generate base locator
    _createLocatorFile(generatedFolder, "generated");

    for (var locatorName in extraLocatorNames) {
      _createLocatorFile("$generatedFolder/$locatorName", locatorName);
    }
  }

  void _createLocatorFile(String basePath, String locatorName) {
    var baseFolder = Directory(basePath);
    if (!baseFolder.existsSync()) {
      baseFolder.createSync(recursive: true);
    }

    var baseLocatorFile = File("$basePath/$locatorName.locator");
    if (!baseLocatorFile.existsSync()) {
      baseLocatorFile.writeAsStringSync("// DO NOT DELETE THIS FILE!!");
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        "pubspec.yaml": [".locator"],
      };
}
