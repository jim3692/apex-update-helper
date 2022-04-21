public abstract class UHExt_FutureFieldExtensions {
  /* bundler-make-final */ private CoreHelper.FieldExtensionsScope scope;
  /* bundler-make-final */ private CoreHelper.IFieldExtensionsAction action;

  public void externalInit (UpdateHelper helper, SObjectField field) {
    this.scope = new CoreHelper.FieldExtensionsScope();
    this.scope.externalInit(helper, field);
  }

  public void externalInit (UpdateHelper helper, SObjectField field, CoreHelper.IFieldExtensionsAction action) {
    this.scope = new CoreHelper.FieldExtensionsScope();
    externalInit(helper, field);
    this.action = action;
  }

  public CoreHelper.FutureFieldExtensionsExecutor wasUpdated () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED;
    return getExecutorForAction(action, null);
  }

  public CoreHelper.FutureFieldExtensionsExecutor updatedFromAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF;
    return getExecutorForAction(action, null);
  }

  public CoreHelper.FutureFieldExtensionsExecutor updatedFrom (Object value) {
    return updatedFromAnyOf(new Object[] { value });
  }

  public CoreHelper.FutureFieldExtensionsExecutor updatedToAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF;
    return getExecutorForAction(action, null);
  }

  public CoreHelper.FutureFieldExtensionsExecutor updatedTo (Object value) {
    return updatedToAnyOf(new Object[] { value });
  }

  public CoreHelper.FutureFieldExtensionsExecutor wasAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_ANY_OF;
    return getExecutorForAction(action, null);
  }

  public CoreHelper.FutureFieldExtensionsExecutor was (Object value) {
    return wasAnyOf(new Object[] { value });
  }

  public CoreHelper.FutureFieldExtensionsExecutor isAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_IS_ANY_OF;
    return getExecutorForAction(action, null);
  }

  public CoreHelper.FutureFieldExtensionsExecutor is (Object value) {
    return isAnyOf(new Object[] { value });
  }

  private CoreHelper.FutureFieldExtensionsExecutor getExecutorForAction (CoreHelper.IFieldExtensionsAction action, Object[] values) {
    CoreHelper.FutureFieldExtensionsExecutor executor = new CoreHelper.FutureFieldExtensionsExecutor();
    executor.externalInit(action, values);
    return executor;
  }
}
