public class FutureRecord {
  public final SObjectType sobjectType { get; private set; }
  public SObject record { get; private set; }

  public FutureRecord (SObjectType sobjectType) {
    System.assert(sobjectType != null);
    this.sobjectType = sobjectType;
  }

  public void setRecord (SObject record) {
    if (record?.getSObjectType() != sobjectType) {
      throw new FutureRecordBadRecordException();
    }

    this.record = record;
  }

  public class FutureRecordBadRecordException extends Exception {}
}
