# Generated Locator
A helper generator creates index files for generators, 
in order to generate file in another folder.

## Usage
1. add these code to generate your dedicated generated folder.
you can ignore this, if you don't need extra folder.
```yaml
builders:
  ANY_UNIQUE_NAME_YOU_WANT:
    import: 'package:generated_locator/src/builder.dart'
    builder_factories: ['extraLocatorBuilder']
    build_extensions: { 'pubspec.yaml': ['YOUR_PACKAGE_NAME.extra_locator'] }
    auto_apply: root_package
    build_to: cache
    defaults:
      generate_for:
        include:
          - pubspec.yaml
        exclude:
          - lib/**
      options:
        extra_locator_name: YOUR_PACKAGE_NAME
```

2. use generated.locator as reference to generate you code.
or use YOUR_PACKAGE_NAME.locator as reference.
