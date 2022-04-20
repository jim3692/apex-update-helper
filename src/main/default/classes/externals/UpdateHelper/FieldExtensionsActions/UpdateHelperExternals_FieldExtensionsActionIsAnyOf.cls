public class UpdateHelperExternals_FieldExtensionsActionIsAnyOf implements IFieldExtensionsAction {
  public Boolean run (FieldExtensionsScope scope) {
    return UpdateHelper.falseIfNull(scope.newRecord)
      && UpdateHelper.anyOf(scope.newValue, scope.values);
  }
}
