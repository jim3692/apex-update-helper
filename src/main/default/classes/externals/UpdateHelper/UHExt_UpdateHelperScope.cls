public abstract class UHExt_UpdateHelperScope {
  /* bundler-make-final */ public CoreHelper.TriggerScope triggerScope { get; private set; }
  /* bundler-make-final */ public SObject oldRecord { get; private set; }
  /* bundler-make-final */ public SObject newRecord { get; private set; }
  /* bundler-make-final */ public Schema.DescribeSObjectResult describe { get; private set; }
  /* bundler-make-final */ public Id recordId { get; private set; }

  public void externalInit (CoreHelper.TriggerScope triggerScope, SObject record) {
    this.triggerScope = triggerScope;

    this.describe = record.getSObjectType().getDescribe();
    this.recordId = record.Id;

    this.oldRecord = this.triggerScope.oldMap?.get(record.Id);
    this.newRecord = record.Id == null
      ? record
      : triggerScope.newMap?.get(record.Id);

    if (this.newRecord == null) {
      this.newRecord = record;
    }
  }
}
