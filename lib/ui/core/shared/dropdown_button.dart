import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class Dropdown<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(T)? leading;
  final Widget Function(T) render;
  final void Function(T)? onSelect;
  final Widget? placeholder;
  final T? value;
  final double? width;

  const Dropdown({
    super.key,
    this.leading,
    required this.render,
    required this.data,
    this.onSelect,
    this.value,
    this.placeholder,
    this.width = 158,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  T? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLanguageModal(context);
      },
      child: SizedBox(
        height: 42,
        width: widget.width,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              value != null
                  ? widget.render(value as T)
                  : widget.placeholder ?? Text('Selecione'),
              Icon(Icons.arrow_drop_down, color: AppColors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
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
                    'Linguagens',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      controller: scrollController, // Conecta o scroll ao modal
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        T currentValue = widget.data[index];
                        return ListTile(
                          leading:
                              widget.leading != null
                                  ? widget.leading!(currentValue)
                                  : null,
                          title: widget.render(currentValue),
                          selected: widget.value == currentValue,
                          onTap: () {
                            if (widget.onSelect != null) {
                              widget.onSelect!(currentValue);
                              setState(() {
                                value = currentValue;
                              });
                            }

                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }
}
