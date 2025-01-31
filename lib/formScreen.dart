import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/model/transaction.dart';
import 'package:account/provider/transactionProvider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'ชื่อรายการ'),
              autofocus: true,
            ),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'จำนวนเงิน'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                double? amount = double.tryParse(amountController.text);

                if (title.isNotEmpty && amount != null) {
                  Transaction newTransaction = Transaction(
                    title: title,
                    amount: amount,
                    date: DateTime.now(), // บันทึกเวลาปัจจุบัน
                  );

                  Provider.of<TransactionProvider>(context, listen: false)
                      .addTransaction(newTransaction);

                  Navigator.pop(context);
                }
              },
              child: const Text('เพิ่มข้อมูล'),
            ),
          ],
        ),
      ),
    );
  }
}
