public abstract class CHExt_FieldExtensionsActionIs implements CoreHelper.IFieldExtensionsAction {
  public Boolean run(CoreHelper.FieldExtensionsScope scope) {
    return CoreHelper.falseIfNull(scope.newRecord) &&
      CoreHelper.anyOf(scope.newValue, scope.values);
  }
}
