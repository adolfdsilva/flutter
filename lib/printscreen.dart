import 'package:flutter/material.dart';
import 'generated/i18n.dart';
import 'model/list.dart';
import 'package:mpwt/utils/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plugins/plugins.dart';
import 'package:intl/intl.dart';
import 'utils/constants.dart';

ListResponse listResponse;
var hashMap;
final formatter = DateFormat('dd/MMM/yyyy', 'en_US');
bool isPrinterConnected = false;
String amount = '';
String totalAmount = '';
String fees = '';
String agentFees = '';

class PrintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    listResponse = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PrintScreen',
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.print),
              onPressed: () {
                connectAndPrint(context, CopyType.Customer);
              }),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (_) {
              connectAndPrint(context, constants.CopyType.Agent);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text(I18n.of(context).text_print_agent_copy),
              )
            ],
          )
        ],
      ),
      body: PrintData(),
    );
  }
}

class PrintData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (listResponse.subInvoice != null && listResponse.subInvoice.isNotEmpty) {
      ListResponse subInvoice = listResponse.subInvoice[0];
      amount = constants.formatDoubleAmount(
          double.parse(listResponse.amount.replaceAll(',', '')) +
              double.parse(subInvoice.amount.replaceAll(',', '')));
      totalAmount = constants.formatDoubleAmount(
          double.parse(listResponse.total.replaceAll(',', '')) +
              double.parse(subInvoice.total.replaceAll(',', '')));
      fees = constants.formatDoubleAmount(
          double.parse(listResponse.feesTotal.replaceAll(',', '')) +
              double.parse(subInvoice.feesTotal.replaceAll(',', '')));
      agentFees = constants.formatDoubleAmount(
          double.parse(listResponse.feesAgent.replaceAll(',', '')) +
              double.parse(subInvoice.feesAgent.replaceAll(',', '')));
    } else {
      amount = constants.formatAmount(listResponse.amount);
      totalAmount = constants.formatAmount(listResponse.total);
      fees = constants.formatAmount(listResponse.feesTotal);
      agentFees = constants.formatAmount(listResponse.feesAgent);
    }

    hashMap = {
      I18n.of(context).text_agent_id: listResponse.tid,
      'Did': constants.device_id,
      I18n.of(context).text_agent_no: listResponse.agentNo,
      I18n.of(context).text_tran_id: listResponse.rrn,
      I18n.of(context).text_date_time: listResponse.date,
      'copy_type': I18n.of(context).text_duplicate,
      I18n.of(context).text_service_type:
          'MPWT- ' + I18n.of(context).service_types[listResponse.service],
      I18n.of(context).text_ticket_no: listResponse.ticketNo,
      I18n.of(context).text_amount:
          listResponse.subInvoice == null || listResponse.subInvoice.isEmpty
              ? null
              : constants.formatAmount(listResponse.amount),
      I18n.of(context).text_add_service_type:
          listResponse.subInvoice == null || listResponse.subInvoice.isEmpty
              ? null
              : 'MPWT- ' +
                  I18n.of(context)
                      .service_types[listResponse.subInvoice[0].service],
      I18n.of(context).text_add_ref_no_print:
          listResponse.subInvoice == null || listResponse.subInvoice.isEmpty
              ? null
              : listResponse.subInvoice[0].ticketNo,
      I18n.of(context).text_add_info: listResponse.addInfo ?? '',
      I18n.of(context).text_customer_name: listResponse.customer,
      I18n.of(context).text_customer_mobile: listResponse.mobile ?? '',
      I18n.of(context).text_amount: amount,
      I18n.of(context).text_fees: fees,
      I18n.of(context).text_total_amount: totalAmount,
      I18n.of(context).text_agent_fee: agentFees,
      'text_terms_conn': '',
    };

    connectAndPrint(context, constants.CopyType.Customer);
    return ListView.builder(
        itemCount: hashMap.length + 1,
        itemBuilder: (context, index) {
          if (index == 0)
            return getWidget(context, index);
          else
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
              child: getWidget(context, index),
            );
        });
  }

  Widget getWidget(BuildContext context, int index) {
    if (index == 0) {
      return Container(
          width: 300,
          height: 150,
          child: Image.asset('images/logo_no_bg_no_stroke.png'));
    }

    final key = hashMap.entries.elementAt(index - 1).key;
    if (key == 'copy_type') if (listResponse.isDuplicate)
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              hashMap[key],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          ]);
    else
      return Container();
    else if (key == 'text_terms_conn') {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              I18n.of(context).text_terms_conn,
              style: TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            )
          ]);
    } else {
      if (hashMap[key] == null)
        return Container();
      else
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: Text(key)),
              Flexible(child: Text(hashMap[key]))
            ]);
    }
  }
}

void connectAndPrint(BuildContext context, CopyType copyType) async {
  final preferences = await SharedPreferences.getInstance();
  final address = preferences.get(constants.address);
  if (address == null) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(I18n.of(context).text_printer_not_config)));
    return;
  }

  if (isPrinterConnected)
    Plugins.print(getPrintData(context, copyType));
  else
    Plugins.connect(address).then((onValue) {
      isPrinterConnected = true;
      Plugins.print(getPrintData(context, copyType));
    });
}

String getPrintData(BuildContext context, CopyType copyType) {
  StringBuffer printData = StringBuffer("");
  printData.writeln(I18n.of(context).text_agent_id + ": " + listResponse.tid);
  if (copyType == CopyType.Agent)
    printData.writeln('Did: ' + constants.device_id);
  printData
      .writeln(I18n.of(context).text_agent_no + ": " + listResponse.agentNo);
  printData.writeln(I18n.of(context).text_tran_id + ": " + listResponse.rrn);
  printData.writeln(
      'Date: ' + DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()));
  printData.writeln(getDivider());
  printData.writeln('\t\t\t' +
      (copyType == CopyType.Customer
          ? I18n.of(context).text_customer_copy
          : I18n.of(context).text_customer_copy));
  if (listResponse.isDuplicate)
    printData.writeln('\t\t\t\t' + I18n.of(context).text_duplicate);
  printData.writeln(getDivider());

  printData.writeln(I18n.of(context).text_service_type +
      '\n\t\t\t\t' +
      'MPWT- ' +
      I18n.of(context).service_types[listResponse.service]);
  printData.writeln(
      I18n.of(context).text_ticket_no + '\n\t\t\t\t\t' + listResponse.ticketNo);
  if (listResponse.subInvoice != null && listResponse.subInvoice.isNotEmpty)
    printData.writeln(I18n.of(context).text_amount +
        '\n\t\t\t\t\t' +
        constants.formatAmount(listResponse.amount));
  printData.writeln(getDivider());

  if (listResponse.subInvoice != null && listResponse.subInvoice.isNotEmpty) {
    printData.writeln(I18n.of(context).text_add_service_type +
        '\n\t\t\t\t' +
        'MPWT- ' +
        I18n.of(context).service_types[listResponse.subInvoice[0].service]);
    printData.writeln(I18n.of(context).text_add_ref_no_print +
        '\n\t\t\t\t\t' +
        listResponse.subInvoice[0].ticketNo);
    printData.writeln(I18n.of(context).text_amount +
        '\n\t\t\t\t\t' +
        constants.formatAmount(listResponse.subInvoice[0].amount));
    printData.writeln(getDivider());
  }

  printData.writeln(
      I18n.of(context).text_add_info + '\n\t\t\t\t\t' + listResponse.addInfo ??
          '');
  printData.writeln(I18n.of(context).text_customer_name +
      '\n\t\t\t\t\t' +
      listResponse.customer);
  printData.writeln(I18n.of(context).text_customer_mobile +
          '\n\t\t\t\t\t' +
          listResponse.mobile ??
      '');
  printData.writeln(getDivider());

  printData.writeln(I18n.of(context).text_amount + '\n\t\t\t\t\t' + amount);
  printData.writeln(I18n.of(context).text_fees + '\n\t\t\t\t\t' + fees);
  printData.writeln(
      I18n.of(context).text_total_amount + '\n\t\t\t\t\t' + totalAmount);
  printData.writeln(getDivider());

  if (listResponse.subInvoice != null && listResponse.subInvoice.isNotEmpty) {
    if (copyType == CopyType.Agent) {
      if (!listResponse.isDuplicate) {
        printData.writeln(I18n.of(context).text_agent_balance +
            '\n\t\t\t\t\t' +
            listResponse.bal);
      }
      printData.writeln(
          I18n.of(context).text_agent_fee + '\n\t\t\t\t\t' + agentFees);
      printData.writeln(getDivider());
    }
    printData.writeln(I18n.of(context).text_terms_conn);
  }
  printData.writeln('\t\t\t\t' + constants.appName);

  return printData.toString();
}

String getDivider() {
  return List.filled(54, '-').join();
}
