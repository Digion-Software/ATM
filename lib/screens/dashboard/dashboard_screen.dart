import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/screens/deposit_tab/deposit_screen.dart';
import 'package:atm/screens/drawer/drawer_screen.dart';
import 'package:atm/screens/home_tab/home_screen.dart';
import 'package:atm/screens/transaction_tab/transaction_screen.dart';
import 'package:atm/utils/open_drawer_menu.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<Widget> _widgetOptions = [
    TransactionScreen(),
    HomeScreen(),
    DepositScreen(depositType: null, withdrawalDatum: null, razorPayConfigModel: null),
  ];

  static const List<String> _screenNames = [
    "Transaction",
    "ATM",
    "Deposite",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: _scaffoldKey,
      drawer: DrawerScreen(
        onHomePressed: (){
          _onItemTapped(1);
        },
        onTransactionPressed: (){
          _onItemTapped(0);
        },
      ),
      body: Stack(
        children: [
          const Image(image: AssetImage(AppImages.bgShape)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          openDrawerMenu(scaffoldKey: _scaffoldKey);
                        },
                        child: Image.asset(
                          AppImages.menuIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      TitleTextView(
                        data: _screenNames.elementAt(_selectedIndex),
                        textColor: AppColors.whiteColor,
                        fontSize: 18,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              _selectedIndex != 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SimpleTextView(
                            data: "Deposit Above 500 Require KYC",
                            fontSize: 12,
                            textColor: AppColors.greyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            child: Row(
                              children: const [
                                Text("Verify Now"),
                                SizedBox(width: 5),
                                Icon(Icons.info_outline),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(height: 30),
              Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
              Container(
                color: AppColors.transparentColor,
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkResponse(
                        onTap: () {
                          _selectedIndex = 0;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Icon(Icons.article,
                            size: 30, color: _selectedIndex == 0 ? AppColors.primaryColor : AppColors.greyColor)),
                    InkWell(
                      onTap: () {
                        _selectedIndex = 1;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.5),
                              offset: const Offset(1, 3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                        child: const Icon(Icons.home, color: AppColors.whiteColor),
                      ),
                    ),
                    InkResponse(
                        onTap: () {
                          _selectedIndex = 2;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Icon(Icons.account_balance_wallet,
                            size: 30, color: _selectedIndex == 2 ? AppColors.primaryColor : AppColors.greyColor)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
