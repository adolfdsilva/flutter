import 'package:flutter/material.dart';
import 'package:mpwt/bLoC/summary.dart';
import 'package:mpwt/generated/i18n.dart';
import 'package:mpwt/model/list.dart';
import 'package:mpwt/printscreen.dart';
import 'package:mpwt/viewmodel/base_view_model.dart';
import 'utils/constants.dart';
import 'package:intl/intl.dart';
import 'model/login.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:provider/provider.dart';

LoginResponse loginResponse;
final formatter = DateFormat('dd/MMM/yyyy', 'en_US');
var isFetching = false;

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    loginResponse = ModalRoute.of(context).settings.arguments;
    final summary = Summary();
    return ChangeNotifierProvider(
        builder: (context) => summary,
        child: Scaffold(
          appBar: AppBar(
            title: Text(I18n.of(context).title_tran_summary),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final List<DateTime> picked =
                        await DateRagePicker.showDatePicker(
                            context: context,
                            initialFirstDate:
                                DateTime.now().subtract(Duration(days: 1)),
                            initialLastDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 750)),
                            lastDate: DateTime.now());
                    if (picked != null && picked.length == 2) {
                      summary.getTxns(
                          loginResponse.tid,
                          formatter.format(picked[0]),
                          formatter.format(picked[1]));
                    }
                  })
            ],
          ),
          backgroundColor: Color(0xffe0e0e0),
          body: TxnBody(),
        ));
  }
}

class TxnBody extends StatefulWidget {
  @override
  _TxnBodyState createState() => _TxnBodyState();
}

class _TxnBodyState extends State<TxnBody> {
  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var yesterday = now.subtract(Duration(hours: 24));
    Provider.of<Summary>(context, listen: false).getTxns(
        loginResponse.tid, formatter.format(yesterday), formatter.format(now));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Summary>(builder: (context, model, child) {
      if (model.state == ViewState.Busy)
        return Center(child: CircularProgressIndicator());
      else {
        if (model.error != null) {
          return Center(
            child: Text(model.error == timeoutMsg
                ? I18n.of(context).toast_read_timeout
                : model.error),
          );
        } else if (model.txnList.isEmpty)
          return Center(
            child: Text(I18n.of(context).text_no_transactions),
          );
        else
          return ListView.builder(itemBuilder: (context, index) {
            final ListResponse txn = model.txnList[index];
            return InkWell(
              onTap: () {
                txn.tid = loginResponse.tid;
                txn.agentNo = loginResponse.mob;
                txn.isDuplicate = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrintScreen(),
                        settings: RouteSettings(
                            name: 'printscreen', arguments: txn)));
              },
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                I18n.of(context).service_types[txn.service],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 4,
                              ),
                              Text(I18n.of(context).text_tran_id +
                                  ': ${txn.rrn}'),
                              Container(
                                height: 4,
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 200),
                                child: Text(I18n.of(context).text_ticket_no +
                                    ': ${txn.ticketNo}'),
                              ),
                              Container(
                                height: 4,
                              ),
                              Text(I18n.of(context).text_customer_mobile +
                                  ': ${txn.mobile}')
                            ],
                          ),
                          Column(children: <Widget>[
                            Image(
                              image: txn.rc == SUCCESS
                                  ? AssetImage('images/success.png')
                                  : AssetImage('images/error.png'),
                              width: 30,
                              height: 30,
                            ),
                            Container(
                              height: 4,
                            ),
                            Text(
                              formatAmount(txn.subInvoice.isEmpty
                                  ? txn.amount
                                  : (double.parse(
                                              txn.amount.replaceAll(',', '')) +
                                          double.parse(txn.subInvoice[0].amount
                                              .replaceAll(',', '')))
                                      .toString()),
                            ),
                          ])
                        ],
                      ),
                      Container(
                        height: 8,
                      ), //padding container
                      Container(
                        height: 1,
                        color: Color(0xffe0e0e0),
                      ),
                      Container(
                        height: 8,
                      ), //padding container
                      Text(txn.date)
                    ],
                  ),
                ),
              ),
            );
            // final headerDate =
            //     recordFormatter.parse(model.txnList.elementAt(index).date);
            // final header = recordFormatter.format(headerDate);
            // return StickyHeader(
            //   header: Container(
            //     height: 30.0,
            //     color: Colors.blueGrey[700],
            //     padding: EdgeInsets.symmetric(horizontal: 16.0),
            //     alignment: Alignment.center,
            //     child: Text(
            //       recordFormatter.format(headerDate),
            //       style: const TextStyle(color: Colors.white),
            //     ),
            //   ),
            //   content: Column(
            //     children: model.txnList
            //         .where((txn) => txn.date.startsWith(header))
            //         .map((txn) => ListTile(
            //               leading: Container(
            //                 color: txn.rc == SUCCESS
            //                     ? Colors.green
            //                     : Colors.red,
            //                 width: 5,
            //                 height: 50,
            //               ),
            //               title: Text(serviceTypes[txn.service]),
            //               subtitle: Text(txn.ticketNo +
            //                   (txn.subInvoice.isNotEmpty
            //                       ? '\n' + txn.subInvoice[0].ticketNo
            //                       : '')),
            //               trailing: Text(formatAmount(txn.subInvoice.isEmpty
            //                   ? txn.amount
            //                   : (double.parse(
            //                               txn.amount.replaceAll(',', '')) +
            //                           double.parse(txn.subInvoice[0].amount
            //                               .replaceAll(',', '')))
            //                       .toString())),
            //               onTap: () {
            //                 txn.tid = loginResponse.tid;
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => PrintScreen(),
            //                         settings: RouteSettings(
            //                             name: 'printscreen',
            //                             arguments: txn)));
            //               },
            //             ))
            //         .toList(),
            //   ),
            // );
          });
      }
    });
  }
}
