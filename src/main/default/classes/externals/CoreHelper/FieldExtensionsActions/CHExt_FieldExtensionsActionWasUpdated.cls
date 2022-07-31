public abstract class CHExt_FieldExtensionsActionWasUpdated implements CoreHelper.IFieldExtensionsAction {
  public Boolean run(CoreHelper.FieldExtensionsScope scope) {
    if (!scope.helperScope.triggerScope.isUpdate) {
      return false;
    }

    return !CoreHelper.caseSensitiveEqualityCheck(
      scope.oldValue,
      scope.newValue
    );
  }
}
