public abstract class UpdateHelperExternals_FieldExtensionsActionUpdatedFromAnyOf implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return UpdateHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED.run(scope)
      && UpdateHelper.anyOf(scope.oldValue, scope.values);
  }
}
