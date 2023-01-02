import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../widgets/shared.dart';

class ModelFutureBuilder<T> extends StatelessWidget {
  const ModelFutureBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.onError,
    this.loading,
    this.onRefresh,
    this.error,
    this.isFullScreen = false,
    this.isSheet = false,
  }) : super(key: key);

  final bool busy;
  final T? data;
  final WidgetBuilder? onError;
  final RefreshCallback? onRefresh;
  final bool isFullScreen;
  final bool isSheet;
  final dynamic error;
  final Widget? loading;
  final ValueWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ?? ModelBusyWidget(isFullScreen: isFullScreen || isSheet);
    } else {
      if (data == null) {
        return onError != null
            ? onError!(context)
            : ModelErrorWidget(
                onRefresh: onRefresh,
                error: error,
                isFullScreen: isFullScreen,
              );
      } else {
        return onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh!,
                child: builder(context, data as T, null),
              )
            : builder(context, data as T, null);
      }
    }
  }
}

class ModelFutureListBuilder<T> extends StatelessWidget {
  const ModelFutureListBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.empty,
    this.loading,
    this.onRefresh,
    this.hasRefreshButton = true,
    this.emptyText,
    this.isFullScreen = false,
  }) : super(key: key);

  final bool busy;
  final List<T> data;
  final Widget? empty;
  final Widget? loading;
  final RefreshCallback? onRefresh;
  final bool hasRefreshButton;
  final String? emptyText;
  final ValueWidgetBuilder<List<T>> builder;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ?? ModelBusyWidget(isFullScreen: isFullScreen);
    } else {
      if (data.isEmpty) {
        return empty ??
            ModelErrorWidget(
              onRefresh: hasRefreshButton ? onRefresh : null,
              error: emptyText ?? 'No items found',
              isFullScreen: isFullScreen,
            );
      } else {
        return onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh!,
                child: builder(context, data, null),
              )
            : builder(context, data, null);
      }
    }
  }
}

class ModelBusyWidget extends StatelessWidget {
  const ModelBusyWidget({
    Key? key,
    required this.isFullScreen,
  }) : super(key: key);

  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return const Scaffold(
        body: SizedBox.expand(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}

class ModelErrorWidget extends StatelessWidget {
  const ModelErrorWidget({
    Key? key,
    this.onRefresh,
    required this.error,
    required this.isFullScreen,
  }) : super(key: key);

  final RefreshCallback? onRefresh;
  final dynamic error;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return Scaffold(
        appBar: AppBar(
          leading: backButton(),
          elevation: 8,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: _getBody(),
      );
    }
    return _getBody();
  }

  Widget _getBody() {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: onRefresh != null,
            child: OutlinedButton(
              onPressed: onRefresh,
              style: OutlinedButton.styleFrom(
                primary: Palette.primary,
                visualDensity: VisualDensity.comfortable,
                tapTargetSize: MaterialTapTargetSize.padded,
                padding: EdgeInsets.fromLTRB(15.w, 13.h, 15.w, 10.h),
              ),
              child: Text(
                'Refresh',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: onRefresh != null ? 10 : 0),
            child: Text(
              error?.toString() ?? "",
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
