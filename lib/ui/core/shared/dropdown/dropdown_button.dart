import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:localization/localization.dart';

class Dropdown<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(T)? leading;
  final Widget Function(T) render;
  final void Function(T)? onSelect;
  final Widget? placeholder;
  final T? value;
  final double? width;
  final DropdownButtonController controller;
  final String? title;
  final String? Function(T?)? validator;

  const Dropdown({
    super.key,
    required this.render,
    required this.data,
    required this.controller,
    this.title,
    this.leading,
    this.onSelect,
    this.value,
    this.placeholder,
    this.width = 158,
    this.validator,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.validator,
      initialValue: widget.controller.value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<T> field) {
        return GestureDetector(
          onTap: () => _showLanguageModal(context, field),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widget.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color:
                          field.hasError
                              ? Colors.red
                              : field.hasInteractedByUser
                              ? AppColors.green
                              : Colors.transparent,
                      width: 1.5,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        widget.controller.value != null
                            ? [
                              if (widget.leading != null)
                                widget.leading!.call(widget.controller.value),

                              SizedBox(width: widget.leading != null ? 8 : 0),

                              Expanded(
                                child: widget.render(widget.controller.value),
                              ),

                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.grey,
                              ),
                            ]
                            : [
                              Text(
                                "common.select".i18n(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.grey,
                              ),
                            ],
                  ),
                ),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    field.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageModal(BuildContext context, FormFieldState<T> field) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.title ?? "common.menu".i18n(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        T currentValue = widget.data[index];
                        bool isSelected =
                            widget.controller.value == currentValue;

                        return ListTile(
                          key: ValueKey<T>(currentValue),
                          leading:
                              isSelected
                                  ? Icon(Icons.check, color: AppColors.green)
                                  : widget.leading?.call(currentValue),
                          title: widget.render(currentValue),
                          selected: isSelected,
                          onTap: () {
                            widget.controller.value = currentValue;
                            field.didChange(currentValue);
                            widget.onSelect?.call(currentValue);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: "common.close_and_save".i18n(),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
