public abstract class UHExt_FieldExtensionsActionWasUpdated implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    return scope.helperScope.isUpdate
      && scope.oldValue != scope.newValue;
  }
}