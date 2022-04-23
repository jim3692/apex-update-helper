public abstract class UHExt_FutureFieldExtensionsExecutor {
  /* bundler-make-final */ public CoreHelper.FieldExtensionsScope scope;
  /* bundler-make-final */ private CoreHelper.IFieldExtensionsAction action;
  /* bundler-make-final */ private Object[] values;

  public void externalInit (CoreHelper.FieldExtensionsScope scope, CoreHelper.IFieldExtensionsAction action, Object[] values) {
    this.scope = scope;
    this.action = action;
    this.values = values;
  }

  public Boolean run (UpdateHelper.Scope helperScope) {
    System.assert(action != null);
    CoreHelper.FieldExtensionsScope newScope = new CoreHelper.FieldExtensionsScope();
    newScope.externalInit(helperScope, scope.field, values);
    return action.run(newScope);
  }
}
