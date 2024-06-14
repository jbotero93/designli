import 'package:designli/stock_picker/domain/model/stock_model.dart';
import 'package:designli/stock_picker/domain/stock_picker_provider.dart';
import 'package:designli/utils/designli_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StockCard extends StatelessWidget {
  const StockCard({super.key, required this.stock, required this.isSelected});

  final StockModel stock;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final stockPickerProvider = Provider.of<StockPickerProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (isSelected) {
          stockPickerProvider.selectedStock.value = null;
        } else {
          stockPickerProvider.selectedStock.value = stock;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 180,
        decoration: BoxDecoration(
          color: isSelected ? DesignliColors.magent : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Symb',
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : DesignliColors.magent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  stock.symbol,
                  style: GoogleFonts.poppins(
                    color: isSelected
                        ? DesignliColors.blueBackground
                        : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Type',
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : DesignliColors.magent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  stock.type,
                  style: GoogleFonts.poppins(
                    color: isSelected
                        ? DesignliColors.blueBackground
                        : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MIC',
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : DesignliColors.magent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  stock.mic,
                  style: GoogleFonts.poppins(
                    color: isSelected
                        ? DesignliColors.blueBackground
                        : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
