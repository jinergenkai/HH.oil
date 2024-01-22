import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../common_view/blur_border_container.dart';
import 'bloc/home.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const HomePageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final contentController = TextEditingController();
    final moneyController = TextEditingController();

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: CommonScaffold(
        //* appbar
        appBar: AppBar(
          centerTitle: true,
          title: Text(DateTime.now().toStringWithFormat('dd/MM/yyyy'), style: AppTextStyles.s20w600Primary()),
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_left_rounded, size: Dimens.d50.responsive(), color: AppColors.current.primaryColor),
            onPressed: () {
              navigator.push(const AppRouteInfo.itemDetail(User(id: 1)));
            },
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_right_rounded, size: Dimens.d50.responsive(), color: AppColors.current.primaryColor),
              onPressed: () {
                navigator.push(const AppRouteInfo.itemDetail(User(id: 1)));
              },
            ),
          ],
          //* tabbar
          bottom: TabBar(
            indicatorColor: AppColors.current.primaryColor,
            tabs: <Widget>[
              Tab(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.view_list_sharp, color: AppColors.current.primaryColor), const SizedBox(width: 8), Text('Ghi Chép', style: AppTextStyles.s20w600Primary())],
              )),
              Tab(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.domain_verification_rounded, color: AppColors.current.primaryColor), const SizedBox(width: 8), Text('Chốt Sổ', style: AppTextStyles.s20w600Primary())],
              )),
            ],
          ),
        ),
        //* tabarview
        body: TabBarView(
          children: <Widget>[
            //* ghi chép
            SafeArea(
                child: SingleChildScrollView(
              child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: 0,
                  showCheckboxColumn: false,
                  border: TableBorder.all(color: AppColors.current.primaryColor.withOpacity(0.3), width: 2),
                  // columns: [{'', 2}, 'Nội dung', 'Tiền', ''].map((e) => HeaderDataColumn(e)).toList(),
                  columns: [
                    ['Nội dung', .6],
                    ['Tổng: 21.500k', .4],
                  ].map((e) => HeaderDataColumn(e, width)).toList(),
                  rows: [
                    ...List.generate(
                      20,
                      (index) => DataRow(
                        color: MaterialStateProperty.resolveWith<Color>((states) => index.isEven ? AppColors.current.primaryColor.withOpacity(0.1) : Colors.white),
                        onSelectChanged: (value) => navigator.push(const AppRouteInfo.itemDetail(User(id: 1))),
                        cells: [
                          //* Row Nội dung
                          DataCell(
                            Container(
                                padding: EdgeInsets.all(Dimens.d8.responsive()),
                                child: Text(
                                  '${index + 1}',
                                  style: AppTextStyles.s14w600Primary(),
                                )),
                            onTap: () {
                              //pop up
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Xóa ghi chép'),
                                      content: Text('Bạn có chắc chắn muốn xóa ghi chép này?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text('Hủy'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text('Xóa'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          //* Row Tiền Tổng
                          DataCell(
                            Container(
                                padding: EdgeInsets.all(Dimens.d8.responsive()),
                                child: Text(
                                  '${index + 1}',
                                  style: AppTextStyles.s14w600Primary(),
                                )),
                            showEditIcon: true,
                            onTap: () {
                              // edit cell
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return GhiChepDialog(
                                      contentController: contentController,
                                      moneyController: moneyController,
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
            )),
            //* Chốt sổ
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigator.push(const AppRouteInfo.itemDetail(User(id: 1)));
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.current.primaryColor,
        ),
      ),
    );
  }

  DataColumn HeaderDataColumn(List<dynamic> ob, width) => DataColumn(
          label: Expanded(
        child: Container(width: width * ob[1], child: Text(ob[0], style: AppTextStyles.s14w600Primary(), textAlign: TextAlign.center)),
      ));
}

//* ghi chep dialog
class GhiChepDialog extends StatelessWidget {
  const GhiChepDialog({
    super.key,
    required this.contentController,
    required this.moneyController,
  });

  final TextEditingController contentController;
  final TextEditingController moneyController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sửa ghi chép', style: AppTextStyles.s20w600Primary()),
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nội dung',
                labelStyle: AppTextStyles.s16w500Primary(),
                border: OutlineInputBorder(),
              ),
              style: AppTextStyles.s16w500Primary(),
              controller: contentController,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tiền',
                labelStyle: AppTextStyles.s16w500Primary(),
                border: OutlineInputBorder(),
              ),
              style: AppTextStyles.s16w500Primary(),
              keyboardType: TextInputType.number,
              controller: moneyController,
              // onTapOutside: (e) {},
              onEditingComplete: () {},
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Sửa'),
        ),
      ],
    );
  }
}
