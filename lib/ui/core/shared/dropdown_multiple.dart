import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class DropdownMultiple<T> extends StatefulWidget {
  final List<T> data;
  final List<T>? selectedValues;
  final void Function(List<T>)? onChange;
  final Widget Function(T)? leading;
  final Widget Function(T) render;
  final Widget? placeholder;
  final double? width;

  const DropdownMultiple({
    super.key,
    this.leading,
    required this.render,
    required this.data,
    this.placeholder,
    this.width = 158,
    this.selectedValues,
    this.onChange,
  });

  @override
  State<DropdownMultiple<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<DropdownMultiple<T>> {
  List<T> selectedValues = [];

  void showModal() {
    setState(() {
      selectedValues = widget.selectedValues!;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return BottomBar<T>(
          data: widget.data,
          render: widget.render,
          leading: widget.leading,
          placeholder: widget.placeholder,
          selectedValues: selectedValues,
          width: widget.width,
          onSelect: (values) {
            if (widget.onChange != null) {
              widget.onChange!(values);
            }
            setState(() {
              selectedValues = values;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showModal,
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
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.placeholder ??
                  Expanded(
                    child: Text('Selecione', overflow: TextOverflow.ellipsis),
                  ),
              Icon(Icons.arrow_drop_down, color: AppColors.grey),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class BottomBar<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(T)? leading;
  final Widget Function(T) render;
  final Widget? placeholder;
  final double? width;
  final void Function(List<T>) onSelect;
  final List<T> selectedValues;

  const BottomBar({
    super.key,
    this.leading,
    required this.render,
    required this.data,
    required this.onSelect,
    required this.selectedValues,
    this.placeholder,
    this.width = 158,
  });

  @override
  State<BottomBar<T>> createState() => _BottomBarState<T>();
}

class _BottomBarState<T> extends State<BottomBar<T>> {
  List<T> selectedValues = [];

  void toggleValue(T value) {
    setState(() {
      if (selectedValues.contains(value)) {
        selectedValues.remove(value);
      } else {
        selectedValues.add(value);
      }

      widget.onSelect(selectedValues);
    });
  }

  bool isSelected(T value) {
    return selectedValues.contains(value);
  }

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
              const Text(
                'Linguagens',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    final value = widget.data[index];

                    return ListTile(
                      leading: Checkbox(
                        value: isSelected(value),
                        onChanged: (_) => toggleValue(value),
                      ),
                      title: widget.render(value),
                      selected: isSelected(value),
                      onTap: () => toggleValue(value),
                    );
                  },
                ),
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
    selectedValues = widget.selectedValues;
  }
}
