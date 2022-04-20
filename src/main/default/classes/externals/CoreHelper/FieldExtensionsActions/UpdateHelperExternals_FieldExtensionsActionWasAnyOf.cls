public abstract class UpdateHelperExternals_FieldExtensionsActionWasAnyOf implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return UpdateHelper.falseIfNull(scope.oldRecord)
      && UpdateHelper.anyOf(scope.oldValue, scope.values);
  }
}
