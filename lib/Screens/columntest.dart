// import 'package:flutter/material.dart';
// import 'dart:async';
//
//
// class LongPressSelectableText extends StatefulWidget {
//   @override
//   State<LongPressSelectableText> createState() => _LongPressSelectableTextState();
// }
//
// class _LongPressSelectableTextState extends State<LongPressSelectableText> {
//   final TextEditingController _controller = TextEditingController(text: 'Long press to select this text.');
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () {
//         final RenderBox renderBox = context.findRenderObject() as RenderBox;
//         final Offset localOffset = renderBox.localToGlobal(Offset.zero);
//         final TextPosition start = _controller.getSelectionBase();
//         final TextPosition end = _controller.selection;
//         final double left = localOffset.dx + renderBox.size.width / 4;
//         final double top = localOffset.dy + renderBox.size.height / 2;
//
//         final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
//         final Offset overlayTopLeft = overlay.localToGlobal(Offset.zero);
//         final Offset topLeft = Offset(left, top) - overlayTopLeft;
//
//         final TextSelection newSelection = TextSelection(
//           baseOffset: start.offset,
//           extentOffset: end.offset,
//           affinity: start.affinity,
//           isDirectional: end.offset >= start.offset,
//         );
//         _controller.selection = newSelection;
//         final TextEditingValue value = _controller.textEditingValue;
//         _controller.selection = value.selection.copyWith(baseOffset: -1, extentOffset: -1);
//         showMenu(
//           context: context,
//           position: RelativeRect.fromLTRB(topLeft.dx, topLeft.dy, 0, 0),
//           items: <PopupMenuEntry>[
//             PopupMenuItem(
//               child: Text('Copy'),
//               value: 'copy',
//             ),
//           ],
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         child: TextField(
//           controller: _controller,
//           readOnly: true,
//           enableInteractiveSelection: false,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//         ),
//       ),
//     );
//   }
// }