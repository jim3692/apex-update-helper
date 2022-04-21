public abstract class UHExt_FutureFieldExtensionsExecutor {
  /* bundler-make-final */ private CoreHelper.IFieldExtensionsAction action;
  /* bundler-make-final */ private Object[] values;

  public void externalInit (CoreHelper.IFieldExtensionsAction action, Object[] values) {
    this.action = action;
    this.values = values;
  }

  public Boolean run (CoreHelper.FieldExtensionsScope scope) {
    System.assert(action != null);
    CoreHelper.FieldExtensionsScope newScope = scope.copyWithValues(values);
    return action.run(newScope);
  }
}
