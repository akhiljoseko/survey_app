import 'package:flutter/material.dart';

class MultiSelectChipFormField<T> extends FormField<List<T>> {
  MultiSelectChipFormField({
    super.key,
    required List<T> options,
    required String Function(T) labelTextForOption,
    List<T>? initialValue,
    ValueChanged<List<T>>? onChanged,
    super.validator,
    String? labelText,
    bool enabled = true,
  }) : super(
         initialValue: initialValue ?? [],
         builder: (FormFieldState<List<T>> field) {
           void onChipTapped(bool selected, T item) {
             final currentValue = List<T>.from(field.value ?? []);
             selected ? currentValue.add(item) : currentValue.remove(item);
             field.didChange(currentValue);
             onChanged?.call(currentValue);
           }

           return InputDecorator(
             decoration: InputDecoration(
               labelText: labelText,
               errorText: field.errorText,
               border: InputBorder.none,
             ),
             child: Wrap(
               spacing: 10,
               children:
                   options.map((item) {
                     final isSelected = field.value!.contains(item);
                     return FilterChip(
                       label: Text(labelTextForOption(item)),
                       selected: isSelected,
                       onSelected:
                           enabled
                               ? (selected) => onChipTapped(selected, item)
                               : null,
                     );
                   }).toList(),
             ),
           );
         },
       );
}
