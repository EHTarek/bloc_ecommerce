
class ProductsEntity {
  int? id;
  String? code;
  String? name;
  int? unitId;
  String? price;
  String? secondaryPrice;
  String? sku;
  String? packSize;
  String? stock;
  String? type;
  int? categoryId;
  String? notes;
  String? vat;
  String? status;
  dynamic stdPriceAccounts;
  dynamic vatValueAccounts;
  String? sdvInv;
  String? sdInv;
  String? vatInv;
  int? unitSupply;
  String? unitSupplyQty;
  int? mushok64Show;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic tradeOfferInputQty;
  dynamic tradeOfferQty;
  String? unitName;
  String? unitQty;
  String? categoryName;
  String? stockQty;
  dynamic tradeOfferPrimary;

  ProductsEntity({
    this.id,
    this.code,
    this.name,
    this.unitId,
    this.price,
    this.secondaryPrice,
    this.sku,
    this.packSize,
    this.stock,
    this.type,
    this.categoryId,
    this.notes,
    this.vat,
    this.status,
    this.stdPriceAccounts,
    this.vatValueAccounts,
    this.sdvInv,
    this.sdInv,
    this.vatInv,
    this.unitSupply,
    this.unitSupplyQty,
    this.mushok64Show,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.tradeOfferInputQty,
    this.tradeOfferQty,
    this.unitName,
    this.unitQty,
    this.categoryName,
    this.stockQty,
    this.tradeOfferPrimary,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "unit_id": unitId,
    "price": price,
    "secondary_price": secondaryPrice,
    "sku": sku,
    "pack_size": packSize,
    "stock": stock,
    "type": type,
    "category_id": categoryId,
    "notes": notes,
    "vat": vat,
    "status": status,
    "std_price_accounts": stdPriceAccounts,
    "vat_value_accounts": vatValueAccounts,
    "sdv_inv": sdvInv,
    "sd_inv": sdInv,
    "vat_inv": vatInv,
    "unit_supply": unitSupply,
    "unit_supply_qty": unitSupplyQty,
    "mushok_6_4_show": mushok64Show,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "tradeOfferInputQty": tradeOfferInputQty,
    "tradeOfferQty": tradeOfferQty,
    "unit_name": unitName,
    "unit_qty": unitQty,
    "category_name": categoryName,
    "stockQty": stockQty,
    "trade_offer_primary": tradeOfferPrimary,
  };
}
