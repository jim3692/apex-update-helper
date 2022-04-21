public abstract class UHExt_FieldExtensionsActionWasUpdated implements CoreHelper.IFieldExtensionsAction {
  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    if (!scope.helperScope.triggerScope.isUpdate) {
      return false;
    }

    if (scope.oldValue == null && scope.newValue == null) {
      return false;
    }

    if (scope.oldValue instanceof String) {
      Integer diff = ((String)scope.oldValue).compareTo((String)scope.newValue);
      return diff != 0;
    }

    return !scope.oldValue.equals(scope.newValue);
  }
}
