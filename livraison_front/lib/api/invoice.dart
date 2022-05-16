
import 'package:livraison_front/models/client.dart';
import 'package:livraison_front/models/livreur.dart';

class Invoice {
  final InvoiceInfo info;
  final Livreur supplier;
  final Client customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final String date;
  final String dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final String date;
  final String prix;
  final String type;


  const InvoiceItem({
    required this.description,
     required this.date,
    required this.prix,
    required this.type
  });
}
