// ignore_for_file: constant_identifier_names

class AccountGroupModel {
    int totalCount;
    List<Item> items;

    AccountGroupModel({
        required this.totalCount,
        required this.items,
    });

    factory AccountGroupModel.fromJson(Map<String, dynamic> json) => AccountGroupModel(
        totalCount: json["totalCount"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    String name;
    String narration;
    bool affectGrossProfit;
    int nature;
    int accountGroupId;
    String accountGroupName;
    bool isDefault;
    int id;

    Item({
        required this.name,
        required this.narration,
        required this.affectGrossProfit,
        required this.nature,
        required this.accountGroupId,
        required this.accountGroupName,
        required this.isDefault,
        required this.id,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        narration: json["narration"],
        affectGrossProfit: json["affectGrossProfit"],
        nature: json["nature"],
        accountGroupId: json["accountGroupId"],
        accountGroupName: json["accountGroupName"],
        isDefault: json["isDefault"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "narration": narration,
        "affectGrossProfit": affectGrossProfit,
        "nature": nature,
        "accountGroupId": accountGroupId,
        "accountGroupName": accountGroupName,
        "isDefault": isDefault,
        "id": id,
    };
}

// enum Narration {
//     EMPTY
// }

// final narrationValues = EnumValues({
//     " ": Narration.EMPTY
// });

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
