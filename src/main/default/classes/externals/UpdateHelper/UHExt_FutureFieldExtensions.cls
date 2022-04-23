public abstract class UHExt_FutureFieldExtensions {
  /* bundler-make-final */ private CoreHelper.FieldExtensionsScope scope;
  /* bundler-make-final */ private CoreHelper.IFieldExtensionsAction action;

  public void externalInit (UpdateHelper.Scope helperScope, SObjectField field) {
    this.scope = new CoreHelper.FieldExtensionsScope();
    this.scope.externalInit(helperScope, field);
  }

  public UpdateHelper.FutureFieldExtensionsExecutor wasUpdated () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED;
    return getExecutorForAction(action, null);
  }

  public UpdateHelper.FutureFieldExtensionsExecutor updatedFromAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF;
    return getExecutorForAction(action, values);
  }

  public UpdateHelper.FutureFieldExtensionsExecutor updatedFrom (Object value) {
    return updatedFromAnyOf(new Object[] { value });
  }

  public UpdateHelper.FutureFieldExtensionsExecutor updatedToAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF;
    return getExecutorForAction(action, values);
  }

  public UpdateHelper.FutureFieldExtensionsExecutor updatedTo (Object value) {
    return updatedToAnyOf(new Object[] { value });
  }

  public UpdateHelper.FutureFieldExtensionsExecutor wasAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_ANY_OF;
    return getExecutorForAction(action, values);
  }

  public UpdateHelper.FutureFieldExtensionsExecutor was (Object value) {
    return wasAnyOf(new Object[] { value });
  }

  public UpdateHelper.FutureFieldExtensionsExecutor isAnyOf (Object[] values) {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_IS_ANY_OF;
    return getExecutorForAction(action, values);
  }

  public UpdateHelper.FutureFieldExtensionsExecutor is (Object value) {
    return isAnyOf(new Object[] { value });
  }

  private UpdateHelper.FutureFieldExtensionsExecutor getExecutorForAction (CoreHelper.IFieldExtensionsAction action, Object[] values) {
    UpdateHelper.FutureFieldExtensionsExecutor executor = new UpdateHelper.FutureFieldExtensionsExecutor();
    executor.externalInit(scope, action, values);
    return executor;
  }
}
