part of './models.dart';

@immutable
class IdModel with EquatableMixin {
  final String? _id;

  const IdModel.absent()
      : _id = null,
        super();

  const IdModel.fromString(String id)
      : _id = id,
        super();

  IdModel.fromNumber(num id)
      : _id = id.toString(),
        super();

  IdModel.fromInt(int id)
      : _id = id.toString(),
        super();

  IdModel.fromDouble(double id)
      : _id = id.toString(),
        super();

  factory IdModel.generateFromRandomUUID() {
    return IdModel.fromString(
      const Uuid(options: {'grng': UuidUtil.cryptoRNG}).v4(),
    );
  }

  @override
  List<Object?> get props => [_id];

  bool get isAbsent => _id == null;

  String parseToString() => _id!;
  num parseToNumber() => num.parse(_id!);
  int parseToInt() => int.parse(_id!);
  double parseToDouble() => double.parse(_id!);

  num? tryParseToNumber() => _id != null ? num.tryParse(_id!) : null;
  int? tryParseToInt() => _id != null ? int.tryParse(_id!) : null;
  double? tryParseToDouble() => _id != null ? double.tryParse(_id!) : null;
}
