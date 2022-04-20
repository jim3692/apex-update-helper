public class UpdateHelperExternals_FieldExtensionsActionWasUpdated implements IFieldExtensionsAction {
  public Boolean run (FieldExtensionsScope scope) {
    return scope.isUpdate
      && scope.oldValue != scope.newValue;
  }
}
