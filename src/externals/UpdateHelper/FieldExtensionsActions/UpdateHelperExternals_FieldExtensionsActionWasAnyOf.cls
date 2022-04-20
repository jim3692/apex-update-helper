public class UpdateHelperExternals_FieldExtensionsActionWasAnyOf implements IFieldExtensionsAction {
  public Boolean run (FieldExtensionsScope scope) {
    return UpdateHelper.falseIfNull(scope.oldRecord)
      && UpdateHelper.anyOf(scope.oldValue, scope.values);
  }
}
