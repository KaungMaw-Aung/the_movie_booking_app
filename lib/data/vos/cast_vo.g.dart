// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CastVOAdapter extends TypeAdapter<CastVO> {
  @override
  final int typeId = 5;

  @override
  CastVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      (fields[3] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CastVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.profilePath)
      ..writeByte(3)
      ..write(obj.movieIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastVO _$CastVOFromJson(Map<String, dynamic> json) => CastVO(
      json['id'] as int?,
      json['name'] as String?,
      json['profile_path'] as String?,
      (json['movieIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$CastVOToJson(CastVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'movieIds': instance.movieIds,
    };
