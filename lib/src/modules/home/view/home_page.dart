import 'package:az_banking_app/src/config/config.dart';
import 'package:az_banking_app/src/modules/accounts/views/accounts_swiper_widget.dart';
import 'package:az_banking_app/src/modules/bank_services/views/bank_categories_widget.dart';
import 'package:az_banking_app/src/modules/home/actions/home_actions.dart';
import 'package:az_banking_app/src/modules/statements/controllers/statement_view_model.dart';
import 'package:az_banking_app/src/modules/statements/views/widgets/statement_list_view.dart';
import 'package:az_banking_app/src/views/custom/customs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppbar(title: TranslationsKeys.tkHomePage),
      body: ListView(
        padding: EdgeInsets.only(bottom: 24.0),
        children: [
          Container(
            color: ColorManager.lightBackgroundColor,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 24),
                AccountsSwiperWidget(),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: BankCategoriesWidget(),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0).copyWith(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.title(TranslationsKeys.tkTransactionsLabel),
                InkWell(
                    onTap: _toStatementPage,
                    child: CustomText.underline(TranslationsKeys.tkViewMoreLabel,fontSize: 14.0, color: ColorManager.primaryColor,)),
              ],
            ),
          ),
          GetX<StatementViewModel>(
            builder: (controller) => ApiHandler(
              apiResponse: controller.statements,
              onSuccess: StatementsListView(
                cardColor: ColorManager.lightBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                statements: controller.statements.data ?? [],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toStatementPage() {
    HomeActions.instance.toStatementPage();
  }
}
