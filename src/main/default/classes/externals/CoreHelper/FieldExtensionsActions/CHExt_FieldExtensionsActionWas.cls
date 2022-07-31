public abstract class CHExt_FieldExtensionsActionWas implements CoreHelper.IFieldExtensionsAction {
  public Boolean run(CoreHelper.FieldExtensionsScope scope) {
    return CoreHelper.falseIfNull(scope.oldRecord) &&
      CoreHelper.anyOf(scope.oldValue, scope.values);
  }
}
