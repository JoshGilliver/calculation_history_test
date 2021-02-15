// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_history_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculationHistoryEntryModelAdapter
    extends TypeAdapter<CalculationHistoryEntryModel> {
  @override
  final int typeId = 0;

  @override
  CalculationHistoryEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculationHistoryEntryModel(
      calculation: fields[0] as String,
      result: fields[2] as double,
      calculationDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CalculationHistoryEntryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.calculation)
      ..writeByte(1)
      ..write(obj.calculationDate)
      ..writeByte(2)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationHistoryEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
