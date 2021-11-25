import 'package:flutter/material.dart';

class MenuItemTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final onTap;

  const MenuItemTile({
    Key? key,
    required this.title,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: 70, //_animation.value,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? Color(0xFF4AC8EA) : Colors.white30,
              size: 38,
            ),
            const SizedBox(width: 0),
            Text(widget.title,
                style: widget.isSelected
                    ? const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
