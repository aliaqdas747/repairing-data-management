import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCard extends StatelessWidget {
  final String phoneModel;
  final String customerName;
  final String customerPhone;
  final String issueType;
  final VoidCallback onDelete;
  final bool isRepaired;
  final bool isInProcess;
  final bool isPending;

  CustomCard({
    required this.phoneModel,
    required this.customerName,
    required this.customerPhone,
    required this.issueType,
    required this.onDelete,
    this.isRepaired = true,
    this.isInProcess = false,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.blue.shade700,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage('assets/images/gg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Details section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '01. $phoneModel',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Customer Name: $customerName\nPhone No: $customerPhone\nIssue Type: $issueType',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Status section
            Wrap(
            alignment: WrapAlignment.center,
              children: [
                Flexible(
                  child: StatusChip(
                    label: 'Repaired',
                    value: false, onChanged: () {  },
                  ),
                ),
                Flexible(
                  child: StatusChip(
                    label: 'In Process',
                    value: isInProcess, onChanged: () {  },
                  ),
                ),
                Flexible(
                  child: StatusChip(
                    label: 'Pending',
                    value: isPending, onChanged: () {  },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Delete button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(

                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback onChanged;

  StatusChip({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: value,
          onChanged: (newValue) => onChanged(),
        ),
        Text(label,style: TextStyle(color: Colors.white),),
      ],
    );
  }
}