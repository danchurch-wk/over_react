library prop_mixins_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

import 'prop_utils.dart';

import 'dart:collection' show MapView;

main() {
  // Testing for ReactProps within prop_mixins.dart
  group('ReactProps', () {
    testKeys(ReactProps.Z_$propKeys, (() => new ReactPropMixinsTest({})));
  });

  // Testing for CssClassProps within prop_mixins.dart
  group('CssClassProps', () {
    testKeys(CssClassProps.Z_$propKeys, (() => new CssClassPropMixinsTest({})));
  });

  // Testing for DomProps within prop_mixins.dart
  group('DomProps', () {
    testKeys(DomProps.Z_$propKeys, (() => new DomPropMixinsTest({})));
  });
}

class DomPropMixinsTest extends MapView with DomProps {
  /// Create a new instance backed by the specified map.
  DomPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw 'Map does not contain this key: $key';
    }
    return super[key];
  }
}

class ReactPropMixinsTest extends MapView with ReactProps {
  /// Create a new instance backed by the specified map.
  ReactPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw 'Map does not contain this key: $key';
    }
    return super[key];
  }
}

class CssClassPropMixinsTest extends MapView with CssClassProps {
  /// Create a new instance backed by the specified map.
  CssClassPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw 'Map does not contain this key: $key';
    }
    return super[key];
  }
}
