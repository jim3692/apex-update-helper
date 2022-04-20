public abstract class UpdateHelperExternals_FieldExtensionsActionIsAnyOf implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return UpdateHelper.falseIfNull(scope.newRecord)
      && UpdateHelper.anyOf(scope.newValue, scope.values);
  }
}
