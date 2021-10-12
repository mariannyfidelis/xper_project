import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/pages/overview/widgets/client_gerenciador.dart';
import '/widgets/Dashboard/pages/overview/widgets/overview_cards_large.dart';
import '/widgets/Dashboard/pages/overview/widgets/overview_cards_medium.dart';
import '/widgets/Dashboard/pages/overview/widgets/overview_cards_small.dart';
import '/widgets/Dashboard/pages/overview/widgets/revenue_section_large_dash.dart';
import '/widgets/Dashboard/pages/overview/widgets/revenue_section_small.dart';
import '/widgets/Dashboard/responsividade/reposinvidade_dash.dart';

import 'package:get/get.dart';

class OverViewPageDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                child: CustomText(
                  text: menuControllerDash.activeItem.value,
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomSize(context))
                  OverViewCardsMediumScreenSizeDash()
                else
                  OverviewCardsLargeScreenDash()
              else
                OverViewCardsSmallScreenDash(),
              if (!ResponsiveWidget.isSmallScreen(context))
                RevenueSectionLargeDash()
              else
                RevenueSectionSmallDash(),
              ClientsList()
            ],
          ),
        ),
      ],
    );
  }
}
