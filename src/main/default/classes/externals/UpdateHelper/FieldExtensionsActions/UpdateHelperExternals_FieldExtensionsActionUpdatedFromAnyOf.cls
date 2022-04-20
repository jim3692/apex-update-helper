public class UpdateHelperExternals_FieldExtensionsActionUpdatedFromAnyOf implements IFieldExtensionsAction {
  public Boolean run (FieldExtensionsScope scope) {
    return UpdateHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED.run(scope)
      && UpdateHelper.anyOf(scope.oldValue, scope.values);
  }
}
