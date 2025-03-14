import 'package:demo/features/presentation/screens/form_submit_page.dart';
import 'package:demo/features/presentation/widgets/full_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants.dart';
import '../states/form_page_state.dart';

class FormPage extends ConsumerWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formPageProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_left)),
        title: Text(
          'Input Types',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        children: [
          FullFormWidget(),
          ElevatedButton(
            onPressed: () {
              List<String> states = [];
              for (var attr in state.value!.attributes) {
                var formState = ref.watch(formProvider(attr));
                states.add(formState);
              }
              if (states.any((el) => el == '')) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all the fields')));
                return;
              }
              Navigator.push(context, MaterialPageRoute(builder: (_) => FormSubmitPage()));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text(
              'Submit',
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
