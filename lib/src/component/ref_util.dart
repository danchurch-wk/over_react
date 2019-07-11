// Copyright 2019 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:react/react_client.dart' hide forwardRef, createRef;
import 'package:react/react_client.dart' as react_client show forwardRef, createRef;
import 'package:over_react/component_base.dart';

/// Creates a [Ref] object that can be attached to an element via the ref attribute.
///
/// When the element renders, a reference to that node becomes accessible at the
/// [current] attribute of the [Ref].
///
/// __Example__:
///
///     @Factory()
///     UiFactory<BasicProps> Basic = _$Basic;
///
///     @Props()
///     class _$BasicProps extends UiProps {}
///
///     @Component2()
///     class BasicComponent extends UiComponent2<BasicProps> {
///       final Ref<InputElement> inputRef = createRef();
///
///       showInputCreateRefValue(_) {
///         print(inputRef.current.value);
///       }
///
///       @override
///       render() => Dom.div()(
///         (Dom.input()
///           ..ref = inputRef
///         )(),
///         (Dom.button()
///           ..onClick = showInputCreateRefValue
///         )('Click this button'),
///       );
///     }
///
/// Learn more: <https://reactjs.org/docs/refs-and-the-dom.html#creating-refs>.
Ref<CurrentType> createRef<CurrentType>() {
  return react_client.createRef<CurrentType>();
}

/// A function that wraps a component and allows a [Ref] to be passed through the
/// component to one of its children.
///
/// __Example__:
///
///     UiFactory<DomProps> DivForwarded = forwardRef<DomProps>((props, ref) {
///       return (Dom.div()
///         ..ref = ref
///         ..className = 'special-class'
///       )(
///         props.children
///       );
///     })(Dom.div);
///
/// ___ OR ___
///
///     UiFactory<FooProps> FooForwarded = forwardRef<FooProps>((props, ref) {
///       return Dom.form()(
///         (Dom.input()
///           ..ref = ref
///         )(),
///         (Dom.button()
///           ..onClick = props.clickHandler
///         )('Click this button'),
///       );
///     })(Foo);
///
/// Learn more: <https://reactjs.org/docs/forwarding-refs.html>.
UiFactory<TProps> Function(UiFactory<TProps>) forwardRef<TProps extends UiProps>(
    Function(TProps props, Ref ref) wrapperFunction) {

  UiFactory<TProps> wrapWithForwardRef(UiFactory<TProps> factory) {
    Object wrapProps(Map props, Ref ref) {
      return wrapperFunction(factory(props), ref);
    }
    ReactComponentFactoryProxy hoc = react_client.forwardRef(wrapProps);

    TProps forwardedFactory([Map props]) {
      return factory(props)..componentFactory = hoc;
    }

    return forwardedFactory;
  }

  return wrapWithForwardRef;
}
