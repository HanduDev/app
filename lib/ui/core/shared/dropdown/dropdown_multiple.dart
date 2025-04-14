import 'package:app/ui/core/shared/dropdown/dropdown_multiple_controller.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_multiple_model.dart';
import 'package:app/ui/core/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class DropdownMultiple extends StatefulWidget {
  final List<DropdownMultipleModel> data;
  final void Function(List<DropdownMultipleModel>)? onChange;
  final Widget Function(DropdownMultipleModel)? leading;
  final Widget Function(DropdownMultipleModel) render;
  final Widget? placeholder;
  final double? width;
  final DropdownMultipleController controller;
  final String? Function(List<DropdownMultipleModel>)? validator;
  final String? title;

  const DropdownMultiple({
    super.key,
    this.leading,
    required this.render,
    required this.controller,
    required this.data,
    this.title,
    this.placeholder,
    this.width = 158,
    this.onChange,
    this.validator,
  });

  @override
  State<DropdownMultiple> createState() => _DropdownState();
}

class _DropdownState extends State<DropdownMultiple> {
  void showModal(BuildContext context, FormFieldState field) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return BottomBar(
          data: widget.data,
          render: widget.render,
          leading: widget.leading,
          placeholder: widget.placeholder,
          controller: widget.controller,
          title: widget.title,
          width: widget.width,
          onChange: (values) {
            if (widget.onChange != null) {
              widget.onChange!(values);
            }

            field.didChange(values);

            setState(() {});
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (unnusedValue) {
        if (widget.validator != null) {
          return widget.validator!(widget.controller.values);
        }

        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState field) {
        return GestureDetector(
          onTap: () {
            showModal(context, field);
          },
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
                    children: [
                      Expanded(
                        child: Text(
                          widget.controller.values.isNotEmpty
                              ? widget.controller.values
                                  .map((e) => e.name)
                                  .join(', ')
                              : 'Selecione',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: AppColors.grey),
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
}

class BottomBar extends DropdownMultiple {
  const BottomBar({
    super.key,
    required super.data,
    required super.render,
    required super.controller,
    super.title,
    super.leading,
    super.placeholder,
    super.width,
    super.onChange,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState<T> extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
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
                widget.title ?? "Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    final value = widget.data[index];
                    bool isSelected = widget.controller.values.any(
                      (element) => element.id == value.id,
                    );

                    return ListTile(
                      leading: Checkbox(
                        value: isSelected,
                        onChanged: (_) {
                          setState(() {
                            isSelected = !isSelected;
                            widget.controller.toggle(value);
                            if (widget.onChange != null) {
                              widget.onChange!(widget.controller.values);
                            }
                          });
                        },
                      ),
                      title: widget.render(value),
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected;
                          widget.controller.toggle(value);
                          if (widget.onChange != null) {
                            widget.onChange!(widget.controller.values);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: "Fechar e Salvar",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
