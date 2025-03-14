import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/models.dart';
import '../states/form_page_state.dart';
import 'form_widget.dart';

class FullFormWidget extends ConsumerWidget {
  const FullFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formPageProvider);
    return state.when(
        data: (FormModel data) {
          return Column(
            children: [
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.attributes.map((attribute) => FormWidget(attribute: attribute)).toList(),
              )),
            ],
          );
        },
        error: (error, t) => SizedBox(),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
