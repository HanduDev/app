// Mocks generated by Mockito 5.4.5 from annotations
// in app/test/ui/login/login_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i6;

import 'package:app/providers/auth_provider.dart' as _i4;
import 'package:flutter/material.dart' as _i2;
import 'package:flutter/src/foundation/assertions.dart' as _i7;
import 'package:flutter/src/foundation/diagnostics.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWidget_0 extends _i1.SmartFake implements _i2.Widget {
  _FakeWidget_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);

  @override
  String toString({_i2.DiagnosticLevel? minLevel = _i2.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_1 extends _i1.SmartFake
    implements _i2.InheritedWidget {
  _FakeInheritedWidget_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);

  @override
  String toString({_i2.DiagnosticLevel? minLevel = _i2.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_2 extends _i1.SmartFake
    implements _i2.DiagnosticsNode {
  _FakeDiagnosticsNode_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);

  @override
  String toString({
    _i3.TextTreeConfiguration? parentConfiguration,
    _i2.DiagnosticLevel? minLevel = _i2.DiagnosticLevel.info,
  }) => super.toString();
}

/// A class which mocks [AuthProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthProvider extends _i1.Mock implements _i4.AuthProvider {
  MockAuthProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isAuthenticated =>
      (super.noSuchMethod(
            Invocation.getter(#isAuthenticated),
            returnValue: false,
          )
          as bool);

  @override
  bool get isGoogleLoading =>
      (super.noSuchMethod(
            Invocation.getter(#isGoogleLoading),
            returnValue: false,
          )
          as bool);

  @override
  bool get isLoading =>
      (super.noSuchMethod(Invocation.getter(#isLoading), returnValue: false)
          as bool);

  @override
  bool get isAuthenticating =>
      (super.noSuchMethod(
            Invocation.getter(#isAuthenticating),
            returnValue: false,
          )
          as bool);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i5.Future<void> init() =>
      (super.noSuchMethod(
            Invocation.method(#init, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> signInWithGoogle() =>
      (super.noSuchMethod(
            Invocation.method(#signInWithGoogle, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> signOut() =>
      (super.noSuchMethod(
            Invocation.method(#signOut, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> signIn({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#signIn, [], {
              #email: email,
              #password: password,
            }),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> signUp({
    required String? name,
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#signUp, [], {
              #name: name,
              #email: email,
              #password: password,
            }),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> verifyCode({required String? code}) =>
      (super.noSuchMethod(
            Invocation.method(#verifyCode, [], {#code: code}),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  _i5.Future<void> resendCode({required String? code}) =>
      (super.noSuchMethod(
            Invocation.method(#resendCode, [], {#code: code}),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);

  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#addListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#removeListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );

  @override
  void notifyListeners() => super.noSuchMethod(
    Invocation.method(#notifyListeners, []),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i2.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Widget get widget =>
      (super.noSuchMethod(
            Invocation.getter(#widget),
            returnValue: _FakeWidget_0(this, Invocation.getter(#widget)),
          )
          as _i2.Widget);

  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);

  @override
  bool get debugDoingBuild =>
      (super.noSuchMethod(
            Invocation.getter(#debugDoingBuild),
            returnValue: false,
          )
          as bool);

  @override
  _i2.InheritedWidget dependOnInheritedElement(
    _i2.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #dependOnInheritedElement,
              [ancestor],
              {#aspect: aspect},
            ),
            returnValue: _FakeInheritedWidget_1(
              this,
              Invocation.method(
                #dependOnInheritedElement,
                [ancestor],
                {#aspect: aspect},
              ),
            ),
          )
          as _i2.InheritedWidget);

  @override
  void visitAncestorElements(_i2.ConditionalElementVisitor? visitor) =>
      super.noSuchMethod(
        Invocation.method(#visitAncestorElements, [visitor]),
        returnValueForMissingStub: null,
      );

  @override
  void visitChildElements(_i2.ElementVisitor? visitor) => super.noSuchMethod(
    Invocation.method(#visitChildElements, [visitor]),
    returnValueForMissingStub: null,
  );

  @override
  void dispatchNotification(_i2.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(#dispatchNotification, [notification]),
        returnValueForMissingStub: null,
      );

  @override
  _i2.DiagnosticsNode describeElement(
    String? name, {
    _i7.DiagnosticsTreeStyle? style = _i7.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#describeElement, [name], {#style: style}),
            returnValue: _FakeDiagnosticsNode_2(
              this,
              Invocation.method(#describeElement, [name], {#style: style}),
            ),
          )
          as _i2.DiagnosticsNode);

  @override
  _i2.DiagnosticsNode describeWidget(
    String? name, {
    _i7.DiagnosticsTreeStyle? style = _i7.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#describeWidget, [name], {#style: style}),
            returnValue: _FakeDiagnosticsNode_2(
              this,
              Invocation.method(#describeWidget, [name], {#style: style}),
            ),
          )
          as _i2.DiagnosticsNode);

  @override
  List<_i2.DiagnosticsNode> describeMissingAncestor({
    required Type? expectedAncestorType,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#describeMissingAncestor, [], {
              #expectedAncestorType: expectedAncestorType,
            }),
            returnValue: <_i2.DiagnosticsNode>[],
          )
          as List<_i2.DiagnosticsNode>);

  @override
  _i2.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
            Invocation.method(#describeOwnershipChain, [name]),
            returnValue: _FakeDiagnosticsNode_2(
              this,
              Invocation.method(#describeOwnershipChain, [name]),
            ),
          )
          as _i2.DiagnosticsNode);
}
