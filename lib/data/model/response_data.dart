class ResponseData {
  int? customerExpenseId;
  int? customerId;
  int? categoryId;
  int? subCategoryId;
  int? amountSpent;
  String? expenseDate;
  int? isDeleted;
  String? name;
  String? phone;
  String? email;
  String? categoryName;
  String? subCategoryName;

  ResponseData(
      {this.customerExpenseId,
        this.customerId,
        this.categoryId,
        this.subCategoryId,
        this.amountSpent,
        this.expenseDate,
        this.isDeleted,
        this.name,
        this.phone,
        this.email,
        this.categoryName,
        this.subCategoryName});

  ResponseData.fromJson(Map<String, dynamic> json) {
    customerExpenseId = json['CustomerExpenseId'];
    customerId = json['CustomerId'];
    categoryId = json['CategoryId'];
    subCategoryId = json['SubCategoryId'];
    amountSpent = json['AmountSpent'];
    expenseDate = json['ExpenseDate'];
    isDeleted = json['IsDeleted'];
    name = json['Name'];
    phone = json['Phone'];
    email = json['Email'];
    categoryName = json['CategoryName'];
    subCategoryName = json['SubCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerExpenseId'] = customerExpenseId;
    data['CustomerId'] = customerId;
    data['CategoryId'] = this.categoryId;
    data['SubCategoryId'] = this.subCategoryId;
    data['AmountSpent'] = this.amountSpent;
    data['ExpenseDate'] = this.expenseDate;
    data['IsDeleted'] = this.isDeleted;
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['CategoryName'] = this.categoryName;
    data['SubCategoryName'] = this.subCategoryName;
    return data;
  }
}