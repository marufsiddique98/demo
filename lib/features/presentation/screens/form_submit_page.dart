import 'package:demo/core/constants.dart';
import 'package:demo/features/data/models/models.dart';
import 'package:demo/features/presentation/widgets/full_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../states/form_page_state.dart';

class FormSubmitPage extends ConsumerWidget {
  const FormSubmitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formPageProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_left)),
      ),
      body: state.when(
        data: (FormModel model) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${model.attributes.length} Items',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Gap(25),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(25),
                  Text(
                    'Selected Input',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.grayColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...model.attributes
                        .map((attribute) => Row(
                              children: [
                                Icon(Icons.radio_button_checked, color: AppColors.primaryColor, size: 16),
                                Gap(3),
                                Text(
                                  '${attribute.title}: ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    height: 1.7,
                                  ),
                                ),
                                Text(
                                  ref.watch(formProvider(attribute)),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                    Divider(
                      color: Colors.white,
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          enableDrag: true,
                          barrierLabel: 'Edit Selections',
                          context: context,
                          builder: (_) => ListView(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Edit Selections',
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                                height: 25,
                              ),
                              FullFormWidget(),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                                child: Text(
                                  'Update',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Selections',
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, t) => SizedBox(),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          child: Text(
            'Back',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
