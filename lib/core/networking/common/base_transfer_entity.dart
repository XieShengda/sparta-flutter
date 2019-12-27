class BaseTransferEntity {
  final String object;
  final String sign;

  BaseTransferEntity(this.object, this.sign);

  Map<String, String> toJson() => {
        'object': this.object,
        'sign': this.sign,
      };
}
