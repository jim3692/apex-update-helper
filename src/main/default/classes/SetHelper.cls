public class SetHelper {
  public CoreHelper.TriggerScope triggerScope { get; private set; }

  private final List<SObject> records;
  private final List<WhenTheExtensions> checks;

  public static SetHelper of (List<SObject> records) {
    return new SetHelper(records);
  }

  private SetHelper (List<SObject> records) {
    this.triggerScope = CoreHelper.getTriggerScope();
    this.records = records;
    this.checks = new List<WhenTheExtensions>();
  }

  public WhenTheExtensions whenThe (UpdateHelper.FutureFieldExtensionsExecutor check) {
    if (check == null) {
      throw new NullExtensionsException('Executor cannot be null');
    }

    WhenTheExtensions extensions = new WhenTheExtensions();
    extensions.externalInit(this, check);
    checks.add(extensions);
    return extensions;
  }

  public void run () {
    for (SObject record : records) {
      UpdateHelper.Scope updateHelperScope = new UpdateHelper.Scope();
      updateHelperScope.externalInit(triggerScope, record);
      for (WhenTheExtensions check : checks) {
        check.run(updateHelperScope);
      }
    }
  }

  public class WhenTheExtensions extends SHExt_WhenTheExtensions {}

  public class NullExtensionsException extends Exception {}
  public class NullSetException extends Exception {}
}
