import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class CommonDialogRecordLine extends StatefulWidget {
  const CommonDialogRecordLine({
    super.key,
    this.data = const RecordLine(content: '', money: 0),
    this.isEdit = false,
  });

  final bool isEdit;
  final RecordLine data;

  @override
  State<CommonDialogRecordLine> createState() => _CommonDialogRecordLineState();
}

class _CommonDialogRecordLineState extends State<CommonDialogRecordLine> {
  late TextEditingController contentController;
  late TextEditingController moneyController;
  bool isPlus = true;

  @override
  void initState() {
    contentController = TextEditingController(text: widget.data.content);
    moneyController = TextEditingController(text: widget.isEdit ? widget.data.money.toString() : "");
    isPlus = widget.data.sign > 0;
    super.initState();
  }

  // final RecordLine data;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text((widget.isEdit) ? 'Sửa dòng ghi chép # ${widget.data.index + 1}' : 'Tạo dòng ghi chép', style: AppTextStyles.s20w600Primary()),
      icon: const SizedBox.shrink(),
      content: Container(
        width: Dimens.d300.responsive(),
        child: IntrinsicHeight(
          child: Column(
            children: [
              // const SizedBox(height: 10),
              //* Text CreatedAt
              Text(
                'Thời gian tạo:  ${widget.isEdit ? widget.data.createdAt?.toStringWithFormat('hh:mm') : DateTime.now().toStringWithFormat('hh:mm')}',
                style: AppTextStyles.s16w500Primary(),
              ),

              const SizedBox(height: 20),
              //* TextField content
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nội dung',
                  labelStyle: AppTextStyles.s16w500Primary(),
                  border: const OutlineInputBorder(),
                ),
                style: AppTextStyles.s16w500Primary(),
                maxLines: null,
                controller: contentController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    // width: Dimens.d20.responsive(),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            isPlus = !isPlus;
                          });
                        },
                        icon: Container(
                          // height: Dimens.d30.responsive(),
                          // width: Dimens.d10.responsive(),

                          // color: Colors.red,
                          child: Icon(
                            isPlus ? Icons.add : Icons.remove,
                            color: AppColors.current.primaryColor,
                            size: Dimens.d20.responsive(),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Tiền',
                        labelStyle: AppTextStyles.s16w500Primary(),
                        border: const OutlineInputBorder(),
                      ),

                      style: AppTextStyles.s16w500Primary(),
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      controller: moneyController,
                      // onChanged: ,
                      // onTapOutside: (e) {},
                      // onEditingComplete: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        //* button delete
        widget.isEdit
            ? TextButton(
                onPressed: () async {
                  final isDelete = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Xác nhận xóa'),
                      content: const Text('Bạn có chắc chắn muốn xóa dòng ghi chép này?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Xóa', style: TextStyle(color: Colors.redAccent)),
                        ),
                      ],
                    ),
                  );
                  if (isDelete == true) {
                    Navigator.of(context).pop(true);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.redAccent)),
              )
            : const SizedBox.shrink(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            final dataReturn = RecordLine(
              content: contentController.text,
              money: num.parse(moneyController.text),
              sign: isPlus ? 1 : -1,
              index: widget.data.index,
              createdAt: widget.isEdit ? widget.data.createdAt : DateTime.now(),
              updatedAt: widget.isEdit ? DateTime.now() : null,
            );
            Navigator.of(context).pop(dataReturn);
          },
          child: Text(widget.isEdit ? 'Sửa' : 'Tạo'),
        ),
      ],
    );
  }
}
