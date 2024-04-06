import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:punk_beer_app/common/components/app_loader.dart';
import 'package:punk_beer_app/common/components/empty_state.dart';
import 'package:punk_beer_app/common/components/general/app_header.dart';
import 'package:punk_beer_app/common/components/general/spacing.dart';
import 'package:punk_beer_app/common/constant/route_constant.dart';
import 'package:punk_beer_app/common/constant/size_constant.dart';
import 'package:punk_beer_app/common/constant/text_constant.dart';
import 'package:punk_beer_app/common/constant/util.dart';
import 'package:punk_beer_app/common/themes/app_colors.dart';
import 'package:punk_beer_app/data/enums/view_state.dart';
import 'package:punk_beer_app/data/models/brewery_model.dart';
import 'package:punk_beer_app/helpers/styles.dart';
import 'package:punk_beer_app/providers/brewery_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BreweryProvider? breweryProvider;

  int perPage = 10;
  int page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          breweryProvider =
              Provider.of<BreweryProvider>(context, listen: false),
          fetchBreweryHistory(isLoadingMore: false)
        });
    addScrollListenser();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // To handle pagination
  addScrollListenser() {
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          print("reached the end");
          page += 1;
          fetchBreweryHistory(isLoadingMore: true);
        }
      }
    });
  }

  // gets the list of brewery
  fetchBreweryHistory({
    bool isLoadingMore = false,
  }) async {
    await breweryProvider!.getBreweryHistories(
        page: page, per_page: perPage, isLoadingMore: isLoadingMore);
  }

  Widget _mainContent() {
    return Consumer<BreweryProvider>(builder: (context, model, _) {
      // returns when the data is being fetch (loading)
      if (model.breweryListViewState == ViewState.busy) {
        return const Center(
          child: Loader(
            color: AppColors.primaryRed,
          ),
        );
      }

      // returns when an erro occurs
      if (model.breweryListViewState == ViewState.error) {
        return const Center(
            child: Loader(
          color: AppColors.primaryRed,
          text: TextLiterals.errorFetchingHistory,
        ));
      }

      // returns when the list of data is empty
      if (model.breweryListViewState == ViewState.completed &&
          model.brewery.data!.isEmpty) {
        return EmptyState(
          message: TextLiterals.noHistory,
        );
      }

      // displays data to the user
      if (model.breweryListViewState == ViewState.completed &&
          model.brewery.data!.isNotEmpty) {
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              page = 1;

              return fetchBreweryHistory(isLoadingMore: false);
            },
            child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: model.brewery.data!.length,
                //physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  BreweryHistory eachBreweryHistory =
                      model.brewery.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.dimen_10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteLiterals.detailScreen,
                            arguments: eachBreweryHistory);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Sizes.dimen_15.r),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                BorderRadius.circular(Sizes.dimen_5.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VerticalSpacing(Sizes.dimen_10.h),
                            Styles.medium(
                              '${TextLiterals.name}: ${eachBreweryHistory.name}',
                              fontSize:
                                  scaledFontSize(Sizes.dimen_14.sp, context),
                            ),
                            VerticalSpacing(Sizes.dimen_10.h),
                            Styles.medium(
                                '${TextLiterals.address}: ${eachBreweryHistory.address1}',
                                fontSize:
                                    scaledFontSize(Sizes.dimen_12.sp, context),
                                color: AppColors.mediumGray),
                            VerticalSpacing(5.h),
                            Styles.medium(
                                '${TextLiterals.country}: ${eachBreweryHistory.country}',
                                fontSize:
                                    scaledFontSize(Sizes.dimen_12.sp, context),
                                color: AppColors.mediumGray),
                            VerticalSpacing(Sizes.dimen_10.h),
                            Styles.medium(TextLiterals.viewMore,
                                fontSize:
                                    scaledFontSize(Sizes.dimen_12.sp, context),
                                color: AppColors.primaryRed),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      }

      return SizedBox.shrink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightRed,
      appBar: AppBar(
        leading: null,
        actions: null,
        title: Styles.medium(TextLiterals.appName,
            fontSize: scaledFontSize(Sizes.dimen_16.sp, context),
            color: AppColors.white),
        centerTitle: true,
        backgroundColor: AppColors.primaryRed,
      ),
      body: Padding(
          padding: EdgeInsets.only(
              left: Sizes.dimen_15.w,
              right: Sizes.dimen_15.w,
              top: Sizes.dimen_20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpacing(Sizes.dimen_20.h),
              Styles.medium(
                TextLiterals.breweryHistory,
                fontSize: scaledFontSize(Sizes.dimen_16.sp, context),
              ),
              VerticalSpacing(Sizes.dimen_10.h),
              _mainContent(),
              context.watch<BreweryProvider>().isLoadingMoreBrewery
                  ? const Loader(
                      text: TextLiterals.fetchHistory,
                      color: AppColors.primaryRed,
                    )
                  : const SizedBox.shrink()
            ],
          )),
    );
  }
}
