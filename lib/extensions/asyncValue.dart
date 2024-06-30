import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueX on AsyncValue {
  handleSideThings(BuildContext context,callback) {
    if (this is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((this as AsyncError).error.toString()),
        ),
      );
    }
  // if async data then good then do the callback
    if (this is AsyncData) {
      callback();
    }
  }
}
