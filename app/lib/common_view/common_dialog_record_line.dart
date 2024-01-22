import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class CommonDialogRecordLine extends StatefulWidget {
  const CommonDialogRecordLine({
    super.key,
    this.data = const RecordLine(content: '', money: BigDecimal.zero),
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

  @override
  void initState() {
    contentController = TextEditingController(text: widget.data.content);
    moneyController = TextEditingController(text: widget.data.money.toString());
    super.initState();
  }

  // final RecordLine data;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text((widget.isEdit) ? 'Sửa dòng ghi chép' : 'Tạo dòng ghi chép', style: AppTextStyles.s20w600Primary()),
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nội dung',
                labelStyle: AppTextStyles.s16w500Primary(),
                border: const OutlineInputBorder(),
              ),
              style: AppTextStyles.s16w500Primary(),
              controller: contentController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tiền',
                labelStyle: AppTextStyles.s16w500Primary(),
                border: const OutlineInputBorder(),
              ),
              style: AppTextStyles.s16w500Primary(),
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              controller: moneyController,
              // onChanged: ,
              // onTapOutside: (e) {},
              // onEditingComplete: () {},
            ),
          ],
        ),
      ),
      actions: [
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
              money: BigDecimal.parse(moneyController.text),
            );
            Navigator.of(context).pop(dataReturn);
          },
          child: Text(widget.isEdit ? 'Sửa' : 'Tạo'),
        ),
      ],
    );
  }
}
