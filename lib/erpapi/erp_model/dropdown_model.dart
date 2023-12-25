class GroupDropdownModel {
    int id;
    String displayName;
    int nature;
    bool affectGrossProfit;

    GroupDropdownModel({
        required this.id,
        required this.displayName,
        required this.nature,
        required this.affectGrossProfit,
    });

    factory GroupDropdownModel.fromJson(Map<String, dynamic> json) => GroupDropdownModel(
        id: json["id"],
        displayName: json["displayName"],
        nature: json["nature"],
        affectGrossProfit: json["affectGrossProfit"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "nature": nature,
        "affectGrossProfit": affectGrossProfit,
    };
}