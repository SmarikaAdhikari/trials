class Account {
    final int totalCount;
    final List<Items> items;

    Account({
        required this.totalCount,
        required this.items,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        totalCount: json["totalCount"],
        items: List<Items>.from(json["items"].map((x) => Items.fromJson(x))),
    );

   
}

class Items {
    final String name;
    final String? address;
    final double? creditLimit;
    final String? paNumber;
    final String? mobileNo;
    final String accountGroupId;
    final String accountGroupName;
    final String id;

    Items({
        required this.name,
        required this.address,
        required this.creditLimit,
        required this.paNumber,
        required this.mobileNo,
        required this.accountGroupId,
        required this.accountGroupName,
        required this.id,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        name: json["name"],
        address: json["address"],
        creditLimit: json["creditLimit"],
        paNumber: json["paNumber"],
        mobileNo: json["mobileNo"],
        accountGroupId: json["accountGroupId"],
        accountGroupName: json["accountGroupName"],
        id: json["id"],
    );
}