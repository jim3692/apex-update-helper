public abstract class CHExt_WhenTheExtensions {
  /* bundler-make-final */ private SetHelper helper;
  /* bundler-make-final */ private CoreHelper.FutureFieldExtensionsExecutor check;
  private Set<Id> ids;

  public void externalInit (SetHelper helper, CoreHelper.FutureFieldExtensionsExecutor check) {
    this.helper = helper;
    this.check = check;
    this.ids = new Set<Id>();
  }

  public SetHelper addIdTo (Set<Id> ids) {
    this.ids = ids;
    return helper;
  }

  public void run (UpdateHelper.UpdateHelperScope updateHelperScope) {
    if (check.run(updateHelperScope)) {
      ids.add(updateHelperScope.recordId);
    }
  }
}
