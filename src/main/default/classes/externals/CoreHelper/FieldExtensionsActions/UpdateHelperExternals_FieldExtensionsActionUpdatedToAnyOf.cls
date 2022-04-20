public abstract class UpdateHelperExternals_FieldExtensionsActionUpdatedToAnyOf implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return UpdateHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED.run(scope)
      && UpdateHelper.anyOf(scope.newValue, scope.values);
  }
}
