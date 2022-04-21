public abstract class UHExt_TriggerScope {
  @TestVisible
  public Map<Id,SObject> oldMap { get; private set; }
  @TestVisible
  public Map<Id,SObject> newMap { get; private set; }
  @TestVisible
  public Boolean isUpdate { get; private set; }

  public UHExt_TriggerScope () {
    this.oldMap = Trigger.oldMap;
    this.newMap = Trigger.newMap;
    this.isUpdate = Trigger.isUpdate == null ? false : Trigger.isUpdate;
  }
}
