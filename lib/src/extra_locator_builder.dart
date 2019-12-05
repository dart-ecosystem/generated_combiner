import 'dart:async';

import 'package:build/build.dart';

class ExtraLocatorBuilder extends Builder {
  BuilderOptions options;

  ExtraLocatorBuilder(this.options);

  String get extraLocatorName => this.options.config["extra_locator_name"];

  @override
  FutureOr<void> build(BuildStep buildStep) {
    String package = buildStep.inputId.package;
    assert(
      extraLocatorName != null && extraLocatorName.isEmpty,
      "extra_locator_name can't be null or empty string.",
    );
    AssetId outputId = AssetId(package, "$extraLocatorName.extra_locator");

    buildStep.writeAsString(outputId, "");
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        "pubspec.yaml": ["$extraLocatorName.extra_locator"],
      };
}
