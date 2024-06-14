import 'package:designli/stock_picker/domain/stock_picker_provider.dart';
import 'package:designli/stock_picker/interface/widgets/stock_card.dart';
import 'package:designli/utils/designli_colors.dart';
import 'package:designli/utils/load_status.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StockPickerScreen extends StatelessWidget {
  const StockPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stockPickerProvider = Provider.of<StockPickerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignliColors.blueBackground,
        actions: [
          InkWell(
            onTap: () {
              stockPickerProvider.validateAndNavigate(context);
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Text(
                    'Confirm',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: DesignliColors.blueBackground,
      body: ValueListenableBuilder(
        valueListenable: stockPickerProvider.stockLoad,
        builder: (context, status, snapshot) {
          return status == LoadStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : status == LoadStatus.error
                  ? const Center(
                      child: Text('Error'),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                          valueListenable: stockPickerProvider.selectedStock,
                          builder: (context, selectedStock, snaoshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'Welcome to \n Designli Trader',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: DesignliColors.magent,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'First of all, select the stock to view and the price alert in dollars you want to receive.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                TextField(
                                  controller: stockPickerProvider
                                      .valueFieldController.value,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Value alert',
                                    prefixIcon: const Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 80,
                                  color: DesignliColors.magent,
                                ),
                                TextField(
                                  controller: stockPickerProvider
                                      .stockFieldController.value,
                                  onChanged: (value) {
                                    stockPickerProvider.filterStocks();
                                  },
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Search for a stock symbol*',
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ValueListenableBuilder(
                                  valueListenable:
                                      stockPickerProvider.filteredStocks,
                                  builder: (context, filteredStocks, snapshot) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: filteredStocks.length,
                                        itemBuilder: (context, index) {
                                          return StockCard(
                                            stock: filteredStocks[index],
                                            isSelected: selectedStock ==
                                                filteredStocks[index],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Stock picked*: ',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      selectedStock?.symbol ?? 'None',
                                      style: GoogleFonts.poppins(
                                        color: DesignliColors.magent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
