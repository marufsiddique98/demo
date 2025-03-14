import 'package:demo/features/data/models/models.dart';
import 'package:demo/features/data/service/form_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formPageProvider = StateNotifierProvider<FormPageNotifier, AsyncValue<FormModel>>(
  (ref) => FormPageNotifier(),
);

class FormPageNotifier extends StateNotifier<AsyncValue<FormModel>> {
  final FormService formService = FormService();

  FormPageNotifier() : super(const AsyncLoading()) {
    init();
  }

  Future<void> init() async {
    try {
      final res = await formService.getFormResponse();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final formProvider = StateNotifierProvider.family<FormNotifier, String, FormAttribute>(
  (ref, attr) => FormNotifier(attr),
);

class FormNotifier extends StateNotifier<String> {
  final FormAttribute attribute;

  FormNotifier(this.attribute) : super('') {
    if (attribute.type == 'dropdown') {
      state = attribute.options[0];
    }
  }

  void onChanged(String val) {
    state = val;
  }
}
