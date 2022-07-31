public abstract class SHExt_WhenTheExtensions {
  /* bundler-make-final */ private SetHelper helper;
  /* bundler-make-final */ private UpdateHelper.FutureFieldExtensionsExecutor check;
  private Set<Id> ids;

  public void externalInit(
    SetHelper helper,
    UpdateHelper.FutureFieldExtensionsExecutor check
  ) {
    this.helper = helper;
    this.check = check;
  }

  public SetHelper addIdTo(Set<Id> ids) {
    if (ids == null) {
      throw new SetHelper.NullSetException('Set cannot be null');
    }

    this.ids = ids;
    return helper;
  }

  public void run(UpdateHelper.Scope Scope) {
    if (check.run(Scope)) {
      ids.add(Scope.recordId);
    }
  }
}
