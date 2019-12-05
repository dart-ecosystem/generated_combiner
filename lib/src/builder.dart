import 'package:build/build.dart';
import 'package:generated_locator/src/extra_locator_builder.dart';
import 'package:generated_locator/src/locator_builder.dart';

Builder locatorBuilder(BuilderOptions ops) => LocatorBuilder(ops);

Builder extraLocatorBuilder(BuilderOptions ops) => ExtraLocatorBuilder(ops);
