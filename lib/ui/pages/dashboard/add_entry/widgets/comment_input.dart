import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_entry_bloc.dart';
import '../bloc/add_entry_event.dart';

class CommentInput extends StatefulWidget {
  final String comment;

  const CommentInput({super.key, required this.comment});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.comment);
  }

  @override
  void didUpdateWidget(covariant CommentInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.comment != widget.comment) {
      _controller.text = widget.comment;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 2,
      maxLength: 4096,
      decoration: InputDecoration(
        hintText: 'Comentario',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        fillColor: Colors.white,
        filled: true,
      ),
      onChanged: (value) =>
          context.read<AddEntryBloc>().add(CommentChanged(value)),
    );
  }
}
