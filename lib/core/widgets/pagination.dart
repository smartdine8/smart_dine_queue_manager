import 'package:flutter/material.dart';

import '../base/pagination/pagination_cubit.dart';
import 'circular_progress_widget.dart';

typedef ItemWidgetBuilder<T> = Widget Function(int index, T item);

class Pagination<T> extends StatefulWidget {
  final ItemWidgetBuilder<T> itemBuilder;

  final Axis scrollDirection;

  final Widget? progress;

  final Function(dynamic error)? onError;

  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap = false;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final bool addAutomaticKeepAlives = true;
  final bool addRepaintBoundaries = true;
  final bool addSemanticIndexes = true;
  final double? cacheExtent;
  final int? semanticChildCount;
  final int fetchLimit;
  int? index;
  ValueChanged loadMore;
  List? items;
  bool isEndOfList;
  bool isError;
  bool showLoading;

  final PaginationCubit? cubit;

  Pagination(
      {Key? key,
      required this.itemBuilder,
      this.cubit,
      this.scrollDirection = Axis.vertical,
      this.progress,
      this.onError,
      this.reverse = false,
      this.controller,
      this.primary,
      this.physics,
      this.padding,
      this.itemExtent,
      required this.index,
      this.cacheExtent,
      this.showLoading = false,
      this.semanticChildCount,
      required this.fetchLimit,
      required this.items,
      this.isError = false,
      required this.isEndOfList,
      required this.loadMore})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Pagination();
  }
}

class _Pagination<T> extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    if (widget.cubit != null) {
      widget.cubit!.limit = widget.fetchLimit;
    }

    return ListView.builder(
      padding: widget.padding,
      controller: widget.controller,
      physics: widget.physics,
      primary: widget.primary,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      itemExtent: widget.itemExtent,
      cacheExtent: widget.cacheExtent,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      scrollDirection: widget.scrollDirection,
      itemCount: 1 + (widget.fetchLimit * widget.index!),
      itemBuilder: (context, position) {
        if (position < widget.items!.length) {
          return widget.itemBuilder(position, widget.items![position]);
        } else if (widget.showLoading && !widget.isEndOfList) {
          return widget.progress ?? defaultLoading();
        } else if (position == widget.items!.length &&
            !widget.isEndOfList &&
            !widget.isError) {
          fetchMore();
          return widget.progress ?? defaultLoading();
        } else if (widget.isError && position == widget.items!.length) {
          return Center(
            child: GestureDetector(
              onTap: () {
                fetchMore();
                setState(() {
                  widget.showLoading = true;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Tap to retry",
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget defaultLoading() {
    return const Align(
      child: SizedBox(
        height: 40,
        width: 40,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressWidget(),
        ),
      ),
    );
  }

  void fetchMore() {
    widget.loadMore(widget.fetchLimit);
  }
}
