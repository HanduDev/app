// Mocks generated by Mockito 5.4.6 from annotations
// in app/test/ui/traducao_texto/view_model/translate_text_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i7;

import 'package:app/data/repositories/translate/translate_repository.dart'
    as _i3;
import 'package:app/models/translate/translate.dart' as _i2;
import 'package:app/models/translate/translate_text_request.dart' as _i5;
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart'
    as _i6;
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

class _FakeTranslate_0 extends _i1.SmartFake implements _i2.Translate {
  _FakeTranslate_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [TranslateRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockTranslateRepositoryImpl extends _i1.Mock
    implements _i3.TranslateRepositoryImpl {
  MockTranslateRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Translate> create(
    _i5.TranslateTextRequest? translateRequest,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#create, [translateRequest]),
            returnValue: _i4.Future<_i2.Translate>.value(
              _FakeTranslate_0(
                this,
                Invocation.method(#create, [translateRequest]),
              ),
            ),
          )
          as _i4.Future<_i2.Translate>);
}

/// A class which mocks [DropdownButtonController].
///
/// See the documentation for Mockito's code generation for more information.
class MockDropdownButtonController<T> extends _i1.Mock
    implements _i6.DropdownButtonController<T> {
  MockDropdownButtonController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isRequired =>
      (super.noSuchMethod(Invocation.getter(#isRequired), returnValue: false)
          as bool);

  @override
  set value(T? newValue) => super.noSuchMethod(
    Invocation.setter(#value, newValue),
    returnValueForMissingStub: null,
  );

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
    Invocation.method(#addListener, [listener]),
    returnValueForMissingStub: null,
  );

  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
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
