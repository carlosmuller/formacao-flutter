import 'package:flutter/material.dart';

ButtonStyle positivePrimaryAction(context) {
 return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Theme
              .of(context)
              .colorScheme
              .secondary
              .withOpacity(0.5);
        }
        return Theme
            .of(context)
            .colorScheme
            .secondary;
      },
    ),
  );
}
