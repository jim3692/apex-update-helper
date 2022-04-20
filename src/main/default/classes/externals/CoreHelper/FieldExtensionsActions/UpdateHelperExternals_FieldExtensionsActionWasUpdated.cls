public abstract class UpdateHelperExternals_FieldExtensionsActionWasUpdated implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return scope.isUpdate
      && scope.oldValue != scope.newValue;
  }
}
