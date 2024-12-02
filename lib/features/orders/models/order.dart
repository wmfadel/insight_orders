import 'package:equatable/equatable.dart';
import 'package:insight_orders/features/orders/models/order_status.dart';

class Order extends Equatable {
  Order({
    String? id,
    bool? isActive,
    String? price,
    String? company,
    String? picture,
    String? buyer,
    List<String>? tags,
    OrderStatus? status,
    String? registered,
  }) {
    _id = id;
    _isActive = isActive;
    _price = price;
    _company = company;
    _picture = picture;
    _buyer = buyer;
    _tags = tags;
    _status = status;
    _registered = registered;
  }

  Order.fromJson(dynamic json) {
    _id = json['id'];
    _isActive = json['isActive'];
    _price = json['price'];
    _company = json['company'];
    _picture = json['picture'];
    _buyer = json['buyer'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _status = orderStatusFromString(json['status']);
    _registered = json['registered'];
  }

  late final String? _id;
  late final bool? _isActive;
  late final String? _price;
  late final String? _company;
  late final String? _picture;
  late final String? _buyer;
  late final List<String>? _tags;
  late final OrderStatus? _status;
  late final String? _registered;

  Order copyWith({
    String? id,
    bool? isActive,
    String? price,
    String? company,
    String? picture,
    String? buyer,
    List<String>? tags,
    OrderStatus? status,
    String? registered,
  }) =>
      Order(
        id: id ?? _id,
        isActive: isActive ?? _isActive,
        price: price ?? _price,
        company: company ?? _company,
        picture: picture ?? _picture,
        buyer: buyer ?? _buyer,
        tags: tags ?? _tags,
        status: status ?? _status,
        registered: registered ?? _registered,
      );

  String? get id => _id;

  bool? get isActive => _isActive;

  String? get price => _price;

  String? get company => _company;

  String? get picture => _picture;

  String? get buyer => _buyer;

  List<String>? get tags => _tags;

  OrderStatus? get status => _status;

  String? get registered => _registered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['isActive'] = _isActive;
    map['price'] = _price;
    map['company'] = _company;
    map['picture'] = _picture;
    map['buyer'] = _buyer;
    map['tags'] = _tags;
    map['status'] = _status?.name;
    map['registered'] = _registered;
    return map;
  }

  @override
  List<Object?> get props => [
        _id,
        _isActive,
        _price,
        _company,
        _picture,
        _buyer,
        _tags,
        _status,
        _registered,
      ];
}
