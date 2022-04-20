public abstract class UHExt_FieldExtensionsActionIs implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return CoreHelper.falseIfNull(scope.newRecord)
      && CoreHelper.anyOf(scope.newValue, scope.values);
  }
}
