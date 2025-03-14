import 'package:demo/core/constants.dart';
import 'package:demo/features/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../states/form_page_state.dart';

class FormWidget extends ConsumerWidget {
  const FormWidget({super.key, required this.attribute});
  final FormAttribute attribute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formProvider(attribute));
    final notifier = ref.read(formProvider(attribute).notifier);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attribute.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Icon(
                state == '' ? Icons.warning_amber_rounded : Icons.check_circle,
                size: 14,
                color: state == '' ? AppColors.warningColor : AppColors.successColor,
              ),
              Gap(4),
              Text(
                'Required',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: state == '' ? AppColors.warningColor : AppColors.successColor,
                ),
              ),
              Gap(10),
              if (attribute.type != 'textfield' && attribute.type == 'dropdown')
                Text(
                  'Select ${attribute.type == 'radio' ? 'upto ' : ''}1',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
          Gap(5),
          if (attribute.type == 'textfield')
            TextFormField(
              initialValue: state,
              onChanged: (val) => notifier.onChanged(val),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                filled: true,
                fillColor: AppColors.grayColor,
                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grayColor)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grayColor)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grayColor)),
                hintText: 'Type Here...',
              ),
            ),
          if (attribute.type == 'radio')
            ...attribute.options
                .map((el) => Transform.translate(
                      offset: Offset(-15, 0),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: el,
                            groupValue: state,
                            onChanged: (String? value) => notifier.onChanged(value!),
                          ),
                          Text(el),
                        ],
                      ),
                    ))
                .toList(),
          if (attribute.type == 'dropdown')
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.grayColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                value: state,
                items: attribute.options.map((el) {
                  String text = el;
                  if (el.toLowerCase().contains('bedrooms')) {
                    text = el + ' Bedrooms';
                  }
                  if (el.toLowerCase().contains('bathrooms')) {
                    text = el + ' Bathrooms';
                  }
                  return DropdownMenuItem<String>(value: el, child: Text(text));
                }).toList(),
                onChanged: (val) => notifier.onChanged(val!),
                underline: SizedBox(),
              ),
            ),
          if (attribute.type == 'checkbox')
            ...attribute.options
                .map((el) => Transform.translate(
                      offset: Offset(-15, 0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: el == state,
                            onChanged: (bool? value) {
                              notifier.onChanged(el);
                            },
                          ),
                          Text(el),
                        ],
                      ),
                    ))
                .toList(),
          Gap(15),
        ],
      ),
    );
  }
}
