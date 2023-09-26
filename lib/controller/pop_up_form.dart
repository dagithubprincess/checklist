// import 'package:flutter/material.dart';
// import 'dart:developer' as dev;
//
//
// class PopupForm extends StatefulWidget {
//   const PopupForm({Key? key, required this.context}) : super(key: key);
//
//   Context context;
//
//   void showDialog(Context context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Title"),
//           content: Column(
//             children: [
//               TextField(
//                 decoration: InputDecoration(hintText: "Hint Text"),
//               ),
//               TextField(
//                 decoration: InputDecoration(hintText: "Hint Text"),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Close"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Do something when the user submits the form
//               },
//               child: Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   State<PopupForm> createState() => _PopupFormState();
// }
//
// class _PopupFormState extends State<PopupForm> {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ElevatedButton(
//       onPressed: () {
//         dev.log('in elevaed button onpressed');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Popup Form'),
//               content: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     TextFormField(
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       decoration:
//                       const InputDecoration(labelText: 'Password'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('Processing Data')));
//                         }
//                       },
//                       child: const Text('Submit'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: const Text('Show Popup Form'),
//     );
//   }
// }