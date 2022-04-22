public class SetHelper {
  @TestVisible
  public CoreHelper.TriggerScope triggerScope { get; private set; }

  private final List<SObject> records;
  private final List<CoreHelper.WhenTheExtensions> checks;

  public static SetHelper of (List<SObject> records) {
    return new SetHelper(records);
  }

  private SetHelper (List<SObject> records) {
    this.triggerScope = CoreHelper.getTriggerScope();
    this.records = records;
    this.checks = new List<CoreHelper.WhenTheExtensions>();
  }

  public CoreHelper.WhenTheExtensions whenThe (CoreHelper.FutureFieldExtensionsExecutor check) {
    CoreHelper.WhenTheExtensions extensions = new CoreHelper.WhenTheExtensions();
    extensions.externalInit(this, check);
    checks.add(extensions);
    return extensions;
  }

  public void run () {
    for (SObject record : records) {
      UpdateHelper.UpdateHelperScope updateHelperScope = new UpdateHelper.UpdateHelperScope();
      updateHelperScope.externalInit(triggerScope, record);
      for (CoreHelper.WhenTheExtensions check : checks) {
        check.run(updateHelperScope);
      }
    }
  }
}
