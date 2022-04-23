public abstract class CHExt_FieldExtensionsActionUpdatedTo implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED.run(scope)
      && CoreHelper.anyOf(scope.newValue, scope.values);
  }
}
