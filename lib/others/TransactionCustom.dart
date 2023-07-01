class TransactionCustom {
  final String id;
  final num amount;
  final String category;
  final int date;
  final String type;
  final String note;

  TransactionCustom({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.type,
    required this.note,
  });

  static TransactionCustom fromMap(String id, Map<String, dynamic> map) {
    return TransactionCustom(
      id: id,
      amount: map['amount'],
      category: map['category'],
      date: map['date'],
      type: map['type'],
      note: map['note'],
    );
  }
}
