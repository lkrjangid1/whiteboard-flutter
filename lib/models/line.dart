import 'package:json_annotation/json_annotation.dart';

import 'point.dart';

part 'line.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Line {
  const Line(this.points, this.lineColor, this.lineType);

  factory Line.fromJson(Map json) => _$LineFromJson(json);

  final List<Point?> points;
  final int lineColor;
  final String lineType;

  Map<String, dynamic> toJson() => _$LineToJson(this);
}
