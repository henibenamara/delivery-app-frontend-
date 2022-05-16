import 'dart:io';

import 'package:livraison_front/api/invoice.dart';
import 'package:livraison_front/api/utils.dart';
import 'package:livraison_front/models/client.dart';
import 'package:livraison_front/models/livreur.dart';
import 'package:livraison_front/services/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),

        buildInvoice(invoice),
        Divider(),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 2 * PdfPageFormat.mm),
              Text("facture de Livraison", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,)),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Client customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Client :", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)),
          SizedBox(height: 4 * PdfPageFormat.mm),
          Text("nom :"+customer.nom +" "+ customer.prenom, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("adresse "+customer.clientAdresse),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '';
    final titles = <String>[
      'numero Livraison:',
      'Date Livraison:',

    ];
    final data = <String>[
      info.number,
     info.date,
      paymentTerms,
      info.dueDate,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Livreur supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Livreur :", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)),
          SizedBox(height: 4 * PdfPageFormat.mm),
          Text("nom :"+supplier.nom +" "+supplier.prenom, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text("Num° "+supplier.livTelephone.toString()),
          SizedBox(height: 1 * PdfPageFormat.mm),

        ],
      );



  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'type Colis',
      'prix',
    ];
    final data = invoice.items.map((item) {

      return [
        item.description,
        item.type,
        '${item.prix}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
      },
    );
  }


  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),

          SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
